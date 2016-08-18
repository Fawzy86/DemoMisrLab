using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Models.EntityModel;
using DemoMisrInternationalLab.Security;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
using System.Threading.Tasks;
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
            PatientRequestViewModel PatientRequest = Helper.GetPatientRequestView();
            return PartialView("_PatientRequestIndividual", PatientRequest);
        }

        public ActionResult loadPatientRequestContract()
        {
            PatientRequestViewModel PatientRequest =  Helper.GetPatientRequestView();
            PatientRequest.Organizations.OrganizationsList =  DbFunctions.GetOrganizationsByCategoryType(Resources.CategoryType.Contract);
            return PartialView("_PatientRequestContract", PatientRequest);
        }

        public ActionResult loadPatientRequestLabToLab()
        {
            PatientRequestViewModel PatientRequest = Helper.GetPatientRequestView();
            PatientRequest.Organizations.OrganizationsList =  DbFunctions.GetOrganizationsByCategoryType(Resources.CategoryType.LabToLab);
            return PartialView("_PatientRequestLabToLab", PatientRequest);
        }

        public ActionResult loadPatientRequestStatus()
        {
            PatientsRequestsAllViewModel PatientRequestStatus = new PatientsRequestsAllViewModel();
            PatientRequestStatus.PatientRequestStatusWithAnalyzes =  DbFunctions.GetPatientsRequestWithStatus(Resources.Status.PendingForSampling);
            return PartialView("_PatientRequestStatus", PatientRequestStatus);
        }
        

        public ActionResult loadPatientRequestTranactions()
        {
            return PartialView("_PatientRequestTransactions");
        }

        public ActionResult loadInvoices()
        {
            PatientRequestViewModel PatientRequest =  Helper.GetPatientRequestView();
            return PartialView("_Invoices", PatientRequest);
        }

        public ActionResult loadReports()
        {
            PatientsRequestsAllViewModel PatientRequestStatus = new PatientsRequestsAllViewModel();
            PatientRequestStatus.PatientRequestStatusWithAnalyzes =  DbFunctions.GetPatientsRequestTransactionsForCustomerCare(null, new DateTime(1986, 1, 1), new DateTime(2020, 1, 1));
            return PartialView("_Reports", PatientRequestStatus);
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
                    _MatchingPatients =  DbFunctions.GetPatients(model, true);
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

        public ActionResult GetCityView(int? stateProvinceID, string Container)
        {
            CitiesViewModel Cities = new CitiesViewModel();
            if (stateProvinceID != null && stateProvinceID != 0)
            {
                Cities.CitiesList =  DbFunctions.GetCities(stateProvinceID.Value);
            }
            ViewBag.DivContainer = Container;
            return PartialView("_City", Cities);
        }


        public ActionResult GetDoctorsRefPartial(int? DocrtorRefID)
        {
            DoctorsRefViewModel DoctorsRef = new DoctorsRefViewModel();
            DoctorsRef.DoctorsRefList =  DbFunctions.GetDoctorsRef();
            DoctorsRef.SelectedDoctorRefID = DocrtorRefID;
            return PartialView("_DoctorRef", DoctorsRef);
        }

        public ActionResult LoadDoctorRefAddPartial(string Category)
        {
            DoctorRefViewModel DoctorRef = new DoctorRefViewModel();
            DoctorRef.DoctorsSpecializations.DoctorsSpecializationsList =  DbFunctions.GetDoctorsSpecialization();
            DoctorRef.Provinces.ProvincesList =  DbFunctions.GetProvinces();
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
                int DocrtorRefID =  DbFunctions.AddNewDoctorRef(model);
                return  GetDoctorsRefPartial(DocrtorRefID);
            }
            else
            {
                var AllErrors = ModelState.Values.SelectMany(m => m.Errors).Select(e => e.ErrorMessage);
                ViewBag.ErrorMessage = String.Join(Environment.NewLine, AllErrors);
                return PartialView("_Error");
            }
        }

        public decimal GetAnalyzesCost(string analyzesIDs,string OrganizationId)
        {
            decimal TotalCost = 0;
            if (!String.IsNullOrWhiteSpace(analyzesIDs))
            {
                int _OrganizationId = 0;
                if (!String.IsNullOrWhiteSpace(OrganizationId))
                {
                    Int32.TryParse(OrganizationId, out _OrganizationId);
                }
                TotalCost = DbFunctions.GetAnalyzesCost(analyzesIDs, _OrganizationId);
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
                try
                {
                    ViewBag.Container = Category;
                    if (!String.IsNullOrWhiteSpace(Category))
                    {
                        if (Category != Resources.CategoryType.Individual && model.Organizations.SelectedOrganizationID == 0)
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
                    PatientRequestInputsDataModel PatientRequestInputs = Helper.SetPatientRequestInputs(model);
                    DbFunctions.AddPatientRequest(PatientRequestInputs, HttpContext.User.Identity.Name);
                    Helper.MoveAttachments(Path.Combine(Server.MapPath(Resources.Path.TempAttachmentsPath), model.AttachmentSession), Server.MapPath(Resources.Path.AttachmentsPath));

                    if (MatchedPatients.Any())
                    {
                        model.MatchingPatients = MatchedPatients;

                        return PartialView("_MatchingPatientsForRequest", model);
                    }
                    return PatientRequestSucceeded("Well done! Your request has been created successfully.", Category);
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMessage = ex.Message + Environment.NewLine + ex.TargetSite;
                    return PartialView("_Error");
                }
            }
            else
            {
                if (model != null)
                {
                    if (!String.IsNullOrWhiteSpace(Category))
                    {
                        if (Category != Resources.CategoryType.Individual && model.Organizations.SelectedOrganizationID == 0)
                        {
                            ModelState.AddModelError("Category", Category + " selection is required");
                        }
                    }
                    if (model.Analyzes.SelectedAnalyzesIDs == null || !model.Analyzes.SelectedAnalyzesIDs.Any())
                    {
                        ModelState.AddModelError("Analyzes", "Select one analysis at least");
                    }
                }
                var AllErrors = ModelState.Values.SelectMany(m => m.Errors).Select(e => e.ErrorMessage);
                string Errors = String.Join(Environment.NewLine + "<br />", AllErrors);
                ViewBag.ErrorMessage = Errors;
                return PartialView("_Error");
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
            PatientsRequestsAllViewModel PatientRequestStatus = new PatientsRequestsAllViewModel();
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
            PatientRequestStatus.PatientRequestStatusWithAnalyzes =  DbFunctions.GetPatientsRequestTransactionsForCustomerCare(SearchPattern, DateFrom, DateTo);
            return PartialView("_Transactions", PatientRequestStatus);
        }

        public ActionResult GetPatientRequestPayment(int RequestId)
        {
            if (RequestId != 0)
            {
                PatientRequestViewModel PatientRequest = new PatientRequestViewModel();
                PatientRequest = DbFunctions.GetCustomerCarePatientRequest(RequestId);
                return PartialView("_RequestPayment", PatientRequest);
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitNewRequestPayment(FormCollection form, PatientRequestViewModel model)
        {
            if (model != null && ModelState.IsValid)
            { 
            }
            return null;
        }

        public ActionResult OpenInvoice(int RequestID)
        {
            /// do some function for building the invoice

            return View("InvoicePreview");
        }
	}
}