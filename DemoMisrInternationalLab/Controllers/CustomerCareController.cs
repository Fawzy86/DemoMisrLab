using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Security;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    [AuthorizeRoles("CS")]

    public class CustomerCareController : Controller
    {
        //
        // GET: /CustomerCare/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult loadPatientRequestIndividual()
        {
            PatientRequestViewModel PatientRequest = GetPatientRequestView();
            return PartialView("_PatientRequestIndividual", PatientRequest);
        }

        public ActionResult loadPatientRequestContract()
        {
            PatientRequestViewModel PatientRequest = GetPatientRequestView();
            PatientRequest.Organizations.OrganizationsList = DbFunctions.GetOrganizationsByCategoryType(ResourceFiles.CategoryType.Contract);
            return PartialView("_PatientRequestContract", PatientRequest);
        }

        public ActionResult loadPatientRequestLabToLab()
        {
            PatientRequestViewModel PatientRequest = GetPatientRequestView();
            PatientRequest.Organizations.OrganizationsList = DbFunctions.GetOrganizationsByCategoryType(ResourceFiles.CategoryType.LabToLab);
            return PartialView("_PatientRequestLabToLab", PatientRequest);
        }

        public ActionResult loadPatientRequestStatus()
        {
            PatientsRequestsStatusViewModel PatientRequestStatus = new PatientsRequestsStatusViewModel();
            PatientRequestStatus.PatientRequestStatusWithAnalyzes = GetPendingPatientsRequest();
            return PartialView("_PatientRequestStatus", PatientRequestStatus);
        }
        
        [NonAction]
        private List<Patient_Request_Status_Analysis_ViewModel> GetPendingPatientsRequest()
        {
            return DbFunctions.GetPendingPatientsRequest();
        }

        public ActionResult loadPatientRequestTranactions()
        {
            return PartialView("_PatientRequestTransactions");
        }

        public ActionResult loadInvoices()
        {
            PatientRequestViewModel PatientRequest = GetPatientRequestView();
            return PartialView("_Invoices", PatientRequest);
        }

        public ActionResult loadReports()
        {
            PatientsRequestsStatusViewModel PatientRequestStatus = new PatientsRequestsStatusViewModel();
            PatientRequestStatus.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestTransactions(null, new DateTime(1986, 1, 1), new DateTime(2020, 1, 1));
            return PartialView("_Reports", PatientRequestStatus);
        }

        [NonAction]
        private PatientRequestViewModel GetPatientRequestView()
        {
            PatientRequestViewModel PatientRequest = new PatientRequestViewModel();
            //// Get Provinces
            var ProvincesList = DbFunctions.GetProvinces();
            PatientRequest.PatientInfo.Provinces.ProvincesList = ProvincesList;
            //// Get DoctorsRef
            var DoctorsRefList = GetDoctorsRef();
            PatientRequest.DoctorsRef.DoctorsRefList = DoctorsRefList;
            //// Get Analyzes
            var AnalyzesList = DbFunctions.GetAnalyzes();
            PatientRequest.Analyzes.AnalyzesList = AnalyzesList;
            PatientRequest.AttachmentSession = Guid.NewGuid().ToString("N");
            return PatientRequest;
        }
        [NonAction]
        private PatientInfoViewModel GetPatientInfo(int? patientID)
        {
            PatientInfoViewModel _Patient = new PatientInfoViewModel();
            _Patient.Provinces.ProvincesList = DbFunctions.GetProvinces();
            if (patientID != null && patientID != 0)
            {
                var MatchedPatient = DbFunctions.GetPatient(patientID.Value);
                if (MatchedPatient != null)
                {
                    _Patient.PatientID = MatchedPatient.PatientID;
                    _Patient.Address = MatchedPatient.Address;
                    if (MatchedPatient.BirthDate != new DateTime())
                    {
                        _Patient.BirthDate = MatchedPatient.BirthDate;
                        _Patient.Age = (DateTime.Now.Year - MatchedPatient.BirthDate.Value.Year).ToString();
                    }
                    _Patient.Email = MatchedPatient.Email;
                    _Patient.FirstName = MatchedPatient.FirstName;
                    _Patient.LastName = MatchedPatient.LastName;
                    _Patient.MiddleName = MatchedPatient.MiddleName;
                    _Patient.Gender = MatchedPatient.Gender;
                    _Patient.Mobile = MatchedPatient.Mobile;
                    _Patient.Phone = MatchedPatient.Phone;
                    _Patient.ReferenceID = MatchedPatient.ReferenceID;
                    _Patient.RegisteredDate = MatchedPatient.RegisteredDate;
                    _Patient.NationalID = MatchedPatient.NationalID;
                    if (MatchedPatient.CityID != null && MatchedPatient.CityID != 0)
                    {
                        _Patient.Provinces.SelectedProvinceID = MatchedPatient.City.ProvinceID;
                    }
                }
            }
            return _Patient;
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        [ValidateAntiForgeryToken]
        public ActionResult GetMatchingPatients(FormCollection form, PatientInfoViewModel model, string SearchForPatient, string ResetPatientInfo)
        {
            List<Patient> _MatchingPatients = new List<Patient>();
            if (ModelState.IsValid)
            {
                if (model != null)
                {
                    _MatchingPatients = DbFunctions.GetPatients(model, true);
                }
                if (_MatchingPatients == null || !_MatchingPatients.Any())
                {
                    return Content("There is no matching patients for your search");
                }
                else
                {
                    return PartialView("_MatchingPatientsPartial", _MatchingPatients);
                }
            }
            else
            {
                ModelState.AddModelError("", "Invalid data");
                return null;
            }
        }

        public ActionResult GetCityView(int? stateProvinceID,string Container)
        {
            CitiesViewModel Cities = new CitiesViewModel();
            if (stateProvinceID != null && stateProvinceID != 0)
            {
                Cities.CitiesList = GetCities(stateProvinceID.Value);
            }
            ViewBag.DivContainer = Container;
            return PartialView("_City", Cities);
        }

        [NonAction]
        private List<City> GetCities(int StateProvinceID)
        {
            return DbFunctions.GetCities(StateProvinceID);
        }
        public ActionResult GetDoctorsRefPartial(int? DocrtorRefID)
        {
            DoctorsRefViewModel DoctorsRef = new DoctorsRefViewModel();
            DoctorsRef.DoctorsRefList = GetDoctorsRef();
            DoctorsRef.SelectedDoctorRefID = DocrtorRefID;
            return PartialView("_DoctorRef", DoctorsRef);
        }

        public ActionResult LoadDoctorRefAddPartial(string Category)
        {
            DoctorRefViewModel DoctorRef = new DoctorRefViewModel();
            DoctorRef.DoctorsSpecializations.DoctorsSpecializationsList = DbFunctions.GetDoctorsSpecialization();
            DoctorRef.Provinces.ProvincesList = DbFunctions.GetProvinces();
            ViewBag.Container = Category;
            return PartialView("_DoctorRefAdd", DoctorRef);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddNewDoctorRef(FormCollection form, DoctorRefViewModel model)
        {
            if (ModelState.IsValid)
            {
                model.SelectedCityID = form["SelectedCityID"];
                int DocrtorRefID = DbFunctions.AddNewDoctorRef(model);
                return GetDoctorsRefPartial(DocrtorRefID);
            }
            else
            {
                var AllErrors = ModelState.Values.SelectMany(m => m.Errors).Select(e => e.ErrorMessage);
                ViewBag.ErrorMessage = String.Join(Environment.NewLine, AllErrors);
                return PartialView("_Error");
            }
        }

        [NonAction]
        private List<DoctorRef> GetDoctorsRef()
        {
            return DbFunctions.GetDoctorsRef();
        }
        public decimal GetAnalyzesCost(string analyzesIDs)
        {
            decimal TotalCost = 0;
            if (!String.IsNullOrWhiteSpace(analyzesIDs))
            {
                TotalCost = DbFunctions.GetAnalyzesCost(analyzesIDs, ResourceFiles.Package.Individual);
            }
            return TotalCost;
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult UploadAttachment(string attachmentSession)
        {
            HttpFileCollectionBase files = Request.Files;
            string TempAttachmentDirecotryPath = Path.Combine(Server.MapPath("~/Uploads/TempSession"), attachmentSession);
            if (files.Count > 0)
            {
                try
                {
                    for (int i = 0; i < files.Count; i++)
                    {
                        if (!Directory.Exists(TempAttachmentDirecotryPath))
                        {
                            Directory.CreateDirectory(TempAttachmentDirecotryPath);
                        }
                        HttpPostedFileBase file = files[i];
                        string FileName = null;
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            FileName = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            FileName = file.FileName;
                        }

                        string SaveFilePath = Path.Combine(TempAttachmentDirecotryPath, FileName);
                        file.SaveAs(SaveFilePath);
                    }

                    return Json("File Uploaded Successfully!");
                }
                catch (Exception ex)
                {
                    return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                return Json("No files selected.");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitPatientRequest(FormCollection form, PatientRequestViewModel model, string Category)
        {
            if (ModelState.IsValid)
            {
                ViewBag.Container = Category;
                if (String.IsNullOrWhiteSpace(HttpContext.User.Identity.Name))
                {
                    ViewBag.ErrorMessage = "Please login first";
                    return PartialView("_Error", ViewBag.ErrorMessage);
                }
                if (!String.IsNullOrWhiteSpace(Category))
                {
                    if (Category != ResourceFiles.CategoryType.Individual && model.Organizations.SelectedOrganizationID == 0)
                    {
                        ViewBag.ErrorMessage = "Please select your " + Category;
                        return PartialView("_Error", ViewBag.ErrorMessage);
                    }
                }
                if (model.Analyzes.SelectedAnalyzesIDs == null || !model.Analyzes.SelectedAnalyzesIDs.Any())
                {
                    ViewBag.ErrorMessage = "Please select analyzes first";
                    return PartialView("_Error", ViewBag.ErrorMessage);
                }
                model.PatientInfo.SelectedCityID = form["SelectedCityID"];
                if (model.DoctorsRef.SelectedDoctorRefID == null || model.DoctorsRef.SelectedDoctorRefID == 0)
                {
                    string SelectedDoctorRefID = form["SelectedDoctorRefID"];
                    int DoctorRefID = 0;
                    if (Int32.TryParse(SelectedDoctorRefID, out DoctorRefID))
                    {
                        model.DoctorsRef.SelectedDoctorRefID = DoctorRefID;
                    }
                }

                List<PatientRequest> MatchedPatients = DbFunctions.GetMatchingPatients(model.PatientInfo);

                model.PatientInfo.PatientID = DbFunctions.AddNewPatient(model.PatientInfo, HttpContext.User.Identity.Name);
                AddPatientRequest(model, HttpContext.User.Identity.Name);
                MoveAttachments(model.AttachmentSession);

                if (MatchedPatients.Any())
                {
                    model.MatchingPatients = MatchedPatients;
                    
                    return PartialView("_MatchingPatientsForRequest", model);
                }
                return PatientRequestSucceeded("Well done! Your request has been created successfully.", Category);

            }
            else
            {
                var AllErrors = ModelState.Values.SelectMany(m => m.Errors).Select(e => e.ErrorMessage);
                ViewBag.ErrorMessage = String.Join(Environment.NewLine, AllErrors);
                return PartialView("_Error");
            }
        }

        [NonAction]
        private string AddPatientRequest(PatientRequestViewModel model,  string UserName)
        {
            PatientRequestInputsDataModel PatientRequestInputs = new PatientRequestInputsDataModel();
            PatientRequestInputs.AnalyzesIDs = model.Analyzes.SelectedAnalyzesIDs;
            PatientRequestInputs.Comment = null;
            PatientRequestInputs.DoctorRefID = model.DoctorsRef.SelectedDoctorRefID;
            PatientRequestInputs.OrganizationID = model.Organizations.SelectedOrganizationID;
            PatientRequestInputs.Paid = model.Paid;
            PatientRequestInputs.PatientID = model.PatientInfo.PatientID;
            PatientRequestInputs.Priority = model.RequestPriority;
            PatientRequestInputs.TotalOrganizationCost = 0;
            PatientRequestInputs.TotalPatientCost = model.TotalAfterCharges;
            PatientRequestInputs.AttachmentSession = model.AttachmentSession;
            return DbFunctions.AddPatientRequest(PatientRequestInputs, UserName);
        }

        [NonAction]
        private void MoveAttachments(string AttachmentSession)
        {
            string AttachmentSessionDirPath = Path.Combine(Server.MapPath("~/Uploads/TempSession"), AttachmentSession);
            if (Directory.Exists(AttachmentSessionDirPath))
            {
                DirectoryInfo AttachmentSessionDirInfo = new DirectoryInfo(AttachmentSessionDirPath);
                if (AttachmentSessionDirInfo.GetFiles().Any())
                {
                    string SubmittedRequestDirPath = Path.Combine(Server.MapPath("~/Uploads/SubmittedRequest"), AttachmentSession);
                    if (!Directory.Exists(SubmittedRequestDirPath))
                    {
                        Directory.CreateDirectory(SubmittedRequestDirPath);
                    }
                    foreach (var file in AttachmentSessionDirInfo.GetFiles())
                    {
                        System.IO.File.Copy(file.FullName, Path.Combine(SubmittedRequestDirPath, file.Name), true);
                    }
                    Directory.Delete(AttachmentSessionDirPath, true);
                }
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdatePatientRefID(FormCollection form, PatientRequestViewModel model, int PatientRefID, string Category)
        {
            try
            {
                if (model != null && model.PatientInfo != null && model.PatientInfo.PatientID != 0)
                {
                    DbFunctions.UpdatePatientRefID(model.PatientInfo.PatientID, PatientRefID, HttpContext.User.Identity.Name);
                    return PatientRequestSucceeded("Well done! Your request has been created successfully, and assigned to an existing patient.", Category);
                }
                else
                {
                    return Content("Cannot update the patient reference id");
                }
            }
            catch (Exception ex)
            {
                return Content(ex.Message);
            }
        }

        private ActionResult PatientRequestSucceeded(string Message,string Container)
        {
            ViewBag.Message = Message;
            ViewBag.Container = Container;
            return PartialView("_PatientRequestSuccessResult");
        }


        public ActionResult LoadTransactions(string SearchPattern, string DateRange)
        {
            PatientsRequestsStatusViewModel PatientRequestStatus = new PatientsRequestsStatusViewModel();
            DateTime DateFrom = DateTime.Now.Date;
            DateTime DateTo = DateTime.Now.AddDays(1).Date;
            if (!String.IsNullOrWhiteSpace(DateRange))
            {
                string[] DateRangeArray = DateRange.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                DateTime.TryParse(DateRangeArray[0], out DateFrom);
                if(DateRangeArray.Length>1)
                {
                    if (DateTime.TryParse(DateRangeArray[1], out DateTo))
                    {
                        DateTo = DateTo.AddDays(1).Date;
                    }
                }
            }
            PatientRequestStatus.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestTransactions(SearchPattern, DateFrom, DateTo);
            return PartialView("_Transactions", PatientRequestStatus);
        }

        public ActionResult OpenInvoice(int RequestID)
        {
            /// do some function for building the invoice

            return View("InvoicePreview");
        }
	}
}