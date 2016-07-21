using DemoMisrInternationalLab.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Utilities
{
    public static class DbFunctions
    {
        /// <summary>
        /// /////////////////////////////////////////////
        /// </summary>
        /// <param name="LoginName"></param>
        /// <param name="Password"></param>
        /// <returns></returns>
        public static User Login(string LoginName, string Password)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                User _User = db.Users.Where(u => u.UserName.ToLower().Trim() == LoginName.ToLower().Trim() 
                                            && u.UserPassword.Trim() == Password.Trim()).SingleOrDefault();
                return _User;
            }
        }
        /// <summary>
        /// /////////////////////////////////////////
        /// </summary>
        /// <param name="LoginName"></param>
        /// <param name="RoleName"></param>
        /// <returns></returns>
        public static bool IsUserInRole(string LoginName, string RoleName)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                User _User = db.Users.Where(u => u.UserName.ToLower().Trim() == LoginName.ToLower().Trim()).SingleOrDefault();
                if (_User != null)
                {
                    /*var roles = from q in db.SYSUserRoles
                                join r in db.LOOKUPRoles on q.LOOKUPRoleID equals r.LOOKUPRoleID
                                where r.RoleName.Equals(roleName) && q.SYSUserID.Equals(SU.SYSUserID)
                                select r.RoleName;*/
                    if (_User.Role.RoleName == RoleName)
                    {
                        return true;
                    }
                }

            }
            return false;
        }
        /// <summary>
        /// ////////////////////////////////////
        /// </summary>
        /// <param name="StateProvinceID"></param>
        /// <returns></returns>
        public static List<City> GetCities(int StateProvinceID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<City> Cities = db.Cities.Where(c => c.ProvinceID == StateProvinceID).ToList();
                return Cities;
            }
        }
        /// <summary>
        /// ////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<Province> GetProvinces()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<Province> Provinces = db.Provinces.ToList();
                return Provinces;
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<DoctorRef> GetDoctorsRef()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                var DoctorsRef = (from s in db.DoctorRefs
                              select s).ToList();
                return DoctorsRef;
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<DoctorSpecialization> GetDoctorsSpecialization()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<DoctorSpecialization> DoctorsSpecialization = new List<DoctorSpecialization>();
                DoctorsSpecialization = (from s in db.DoctorSpecializations
                                         select s).ToList();
                return DoctorsSpecialization;
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="NewDoctorRef"></param>
        /// <returns></returns>
        public static int AddNewDoctorRef(DoctorRefViewModel NewDoctorRef)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    int? SelectedCityID = null;
                    if (!String.IsNullOrWhiteSpace(NewDoctorRef.SelectedCityID))
                    {
                        SelectedCityID = Convert.ToInt32(NewDoctorRef.SelectedCityID);
                    }
                    DoctorRef _DoctorRef = new DoctorRef()
                    {
                        Address = NewDoctorRef.Address,
                        DoctorName = NewDoctorRef.DoctorName,
                        InsertionDate = DateTime.Now,
                        Mobile = NewDoctorRef.Mobile,
                        Phone = NewDoctorRef.Phone,
                        SpecialID = NewDoctorRef.DoctorsSpecializations.SelectedDoctorSpecializationID,
                        CityID = SelectedCityID
                    };
                    db.DoctorRefs.Add(_DoctorRef);
                    db.SaveChanges();
                    return _DoctorRef.DoctorRefID;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static decimal GetAnalyzesCost(string AnalyzesIDs,string PackageName)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                decimal TotalCost = 0;
                var SelectedPackage = db.Packages.Where(p => p.PackageName == PackageName).SingleOrDefault();
                if (SelectedPackage != null)
                {
                    List<int> RequiredAnalyzes = AnalyzesIDs.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(Int32.Parse).ToList();
                    var SelectedAnalyzes = (from p in db.PackageCostLists
                                            where RequiredAnalyzes.Contains(p.AnalysisID) && p.PackageID == SelectedPackage.PackageID
                                            select p);
                    foreach (var analyzis in SelectedAnalyzes)
                    {
                        TotalCost += analyzis.Analysis.CostPrice * (1 - analyzis.CurrentAnalysisDiscountRate / 100);
                    }
                }
                return TotalCost;
            }
        }
        /// <summary>
        /// /////////////////////////////////////////////
        /// </summary>
        /// <param name="AnalysisID"></param>
        /// <returns></returns>
        public static Analysis GetAnalysis(int AnalysisID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                Analysis _analysis = null;
                var SelectedAnalysis = (from p in db.Analyses
                                        where p.AnalysisID == AnalysisID
                                       select p).SingleOrDefault();
                if (SelectedAnalysis != null)
                {
                    _analysis = SelectedAnalysis;
                }
                return _analysis;
            }
        }
        /// <summary>
        /// ///////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<AnalysisViewModel> GetAnalyzes()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<AnalysisViewModel> AnalyzesList = new List<AnalysisViewModel>();
                var _Analyzes = (from a in db.Analyses
                                 select a).ToList();
                foreach (var analysis in _Analyzes)
                {
                    AnalyzesList.Add(new AnalysisViewModel()
                    {
                        AnalysisDisplayName = analysis.AnalysisName + " : (" + analysis.CostPrice + ")",
                        Analysis = analysis
                    });

                }
                return AnalyzesList;
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="OrganizationType"></param>
        /// <returns></returns>
        public static List<Organization> GetOrganizationsByCategoryType(string CategoryTypeName)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<Organization> Organizations = new List<Organization>();
                Organizations = (from o in db.Organizations
                                 where o.Package.CategoryType.CategoryTypeName == CategoryTypeName
                                 select o).ToList();
                return Organizations;
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientModelRequest"></param>
        /// <returns></returns>
        public static List<PatientRequest> GetMatchingPatients(PatientInfoViewModel PatientModelRequest)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequest> SelectedPatientsRequest = new List<PatientRequest>();
                List<Patient> SelectedPatients = new List<Patient>();
                if (PatientModelRequest != null)
                {
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.FirstName))
                    {
                        var MatchedByName = (from p in db.Patients
                                             where p.FirstName.Trim().ToLower().StartsWith(PatientModelRequest.FirstName.Trim().ToLower())
                                             select p);
                        if (!String.IsNullOrWhiteSpace(PatientModelRequest.MiddleName))
                        {
                            MatchedByName = MatchedByName.Where(p => p.MiddleName.Trim().ToLower().StartsWith(PatientModelRequest.MiddleName.Trim().ToLower()));
                        }
                        if (!String.IsNullOrWhiteSpace(PatientModelRequest.LastName))
                        {
                            MatchedByName = MatchedByName.Where(p => p.LastName.Trim().ToLower().StartsWith(PatientModelRequest.LastName.Trim().ToLower()));
                        }
                        SelectedPatients = SelectedPatients.Concat(MatchedByName).ToList();
                    }

                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.Mobile))
                    {
                        var MatchedByMoblie = (from p in db.Patients
                                               where p.Mobile.Trim().ToLower() == PatientModelRequest.Mobile.Trim().ToLower()
                                               select p);
                        SelectedPatients = SelectedPatients.Concat(MatchedByMoblie).ToList();
                    }
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.Phone))
                    {
                        var MatchedByPhone = (from p in db.Patients
                                              where p.Phone.Trim().ToLower() == PatientModelRequest.Phone.Trim().ToLower()
                                              select p);
                        SelectedPatients = SelectedPatients.Concat(MatchedByPhone).ToList();
                    }
                }
                foreach (var patient in SelectedPatients)
                {
                    var Request = patient.PatientRequests.FirstOrDefault();
                    if (Request != null)
                    {
                        Request.DoctorRef = patient.PatientRequests.FirstOrDefault().DoctorRef;
                        SelectedPatientsRequest.Add(Request);
                    }
                }
                return SelectedPatientsRequest;
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////
        /// </summary>
        /// <param name="UpdatedPatient"></param>
        /// <returns></returns>
        public static void UpdateExistingPatient(PatientInfoViewModel UpdatedPatient, string UserName)
        {
            if (UpdatedPatient == null && UpdatedPatient.PatientID == 0)
            {
                throw new Exception("This patient doesn't exist in the database");
            }
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                int EmployeeID = 0;
                if (!String.IsNullOrWhiteSpace(UserName))
                {
                    var _User = db.Users.Where(u => u.UserName.Trim().ToLower() == UserName.Trim().ToLower()).SingleOrDefault();
                    if (_User != null)
                    {
                        EmployeeID = _User.EmployeeID;
                    }
                }
                if (EmployeeID == 0)
                {
                    throw new Exception("There is no user with username: " + UserName);
                }
                var _Patient = db.Patients.Where(p => p.PatientID == UpdatedPatient.PatientID).SingleOrDefault();
                if (_Patient == null)
                {
                    throw new Exception("This patient doesn't exist in the database");
                }
                _Patient.Address = UpdatedPatient.Address;
                if (!String.IsNullOrWhiteSpace(UpdatedPatient.Age))
                {
                    int YearOfBirth = DateTime.Now.Year - Convert.ToInt32(Math.Round(Convert.ToDecimal(UpdatedPatient.Age)));
                    _Patient.BirthDate = new DateTime(YearOfBirth, 1, 1);
                }
                if (!String.IsNullOrWhiteSpace(UpdatedPatient.SelectedCityID))
                {
                    _Patient.CityID = Convert.ToInt32(UpdatedPatient.SelectedCityID);
                }
                _Patient.Email = UpdatedPatient.Email;

                _Patient.EmployeeID = EmployeeID;

                _Patient.FirstName = UpdatedPatient.FirstName;
                _Patient.Gender = UpdatedPatient.Gender;
                _Patient.LastDataModified = DateTime.Now;
                _Patient.LastName = UpdatedPatient.LastName;
                _Patient.MiddleName = UpdatedPatient.MiddleName;
                _Patient.Mobile = UpdatedPatient.Mobile;
                _Patient.NationalID = UpdatedPatient.NationalID;
                _Patient.Phone = UpdatedPatient.Phone;
                if (UpdatedPatient.ReferenceID != null)
                {
                    _Patient.ReferenceID = UpdatedPatient.ReferenceID.Value;
                }
                db.SaveChanges();
            }
        }

        public static void UpdatePatientRefID(int PatientID, int PatientReferenceID, string UserName)
        {
            if (PatientID == 0)
            {
                throw new Exception("This patient doesn't exist in the database");
            }
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                int EmployeeID = 0;
                if (!String.IsNullOrWhiteSpace(UserName))
                {
                    var _User = db.Users.Where(u => u.UserName.Trim().ToLower() == UserName.Trim().ToLower()).SingleOrDefault();
                    if (_User != null)
                    {
                        EmployeeID = _User.EmployeeID;
                    }
                }
                if (EmployeeID == 0)
                {
                    throw new Exception("There is no user with username: " + UserName);
                }
                var _Patient = db.Patients.Where(p => p.PatientID == PatientID).SingleOrDefault();
                if (_Patient == null)
                {
                    throw new Exception("This patient doesn't exist in the database");
                }
                _Patient.EmployeeID = EmployeeID;
                _Patient.ReferenceID = PatientReferenceID;
                _Patient.LastDataModified = DateTime.Now;
                db.SaveChanges();
            }
        }
        /// <summary>
        /// //////////////////////////////////////////
        /// </summary>
        /// <param name="NewPatient"></param>
        /// <returns></returns>
        public static int AddNewPatient(PatientInfoViewModel NewPatient, string UserName)
        {
            if (NewPatient == null)
            {
                throw new Exception("The patient info is missing");
            }
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                int EmployeeID = 0;
                if (!String.IsNullOrWhiteSpace(UserName))
                {
                    var _User = db.Users.Where(u => u.UserName.Trim().ToLower() == UserName.Trim().ToLower()).SingleOrDefault();
                    if (_User != null)
                    {
                        EmployeeID = _User.EmployeeID;
                    }
                }
                if (EmployeeID == 0)
                {
                    throw new Exception("There is no user with username: " + UserName);
                }
                Patient _Patient = new Patient();

                _Patient.Address = NewPatient.Address;
                if (!String.IsNullOrWhiteSpace(NewPatient.Age))
                {
                    int YearOfBirth = DateTime.Now.Year - Convert.ToInt32(Math.Round(Convert.ToDecimal(NewPatient.Age)));
                    _Patient.BirthDate = new DateTime(YearOfBirth, 1, 1);
                }
                if (!String.IsNullOrWhiteSpace(NewPatient.SelectedCityID))
                {
                    _Patient.CityID = Convert.ToInt32(NewPatient.SelectedCityID);
                }
                _Patient.Email = NewPatient.Email;

                _Patient.EmployeeID = EmployeeID;

                _Patient.FirstName = NewPatient.FirstName;
                _Patient.Gender = NewPatient.Gender;
                _Patient.LastDataModified = DateTime.Now;
                _Patient.LastName = NewPatient.LastName;
                _Patient.MiddleName = NewPatient.MiddleName;
                _Patient.Mobile = NewPatient.Mobile;
                _Patient.NationalID = NewPatient.NationalID;
                _Patient.Phone = NewPatient.Phone;
                int? PatientRefID = db.GetPatientRefID().FirstOrDefault();
                _Patient.ReferenceID = PatientRefID.Value;
                _Patient.RegisteredDate = DateTime.Now;
                db.Patients.Add(_Patient);
                db.SaveChanges();
                return _Patient.PatientID;
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientID"></param>
        /// <returns></returns>
        public static Patient GetPatient(int PatientID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                Patient _patient = null;
                var SelectedPatient = (from p in db.Patients
                                       where p.PatientID == PatientID
                                       select p).SingleOrDefault();
                if (SelectedPatient != null)
                {
                    _patient = SelectedPatient;
                    _patient.City = SelectedPatient.City;
                }
                return _patient;
            }

        }
        /// <summary>
        /// ////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientModelRequest"></param>
        /// <param name="SelectBySearchCriteria"></param>
        /// <returns></returns>
        public static List<Patient> GetPatients(PatientInfoViewModel PatientModelRequest, bool SelectBySearchCriteria)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                bool SearchCriteriaIsFound = false;
                List<Patient> SelectedPatients = new List<Patient>();
                var _patients = (from p in db.Patients select p);
                if (PatientModelRequest != null)
                {
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.FirstName))
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.FirstName.Trim().ToLower().StartsWith(PatientModelRequest.FirstName.Trim().ToLower()));
                    }
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.MiddleName))
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.MiddleName.Trim().ToLower().StartsWith(PatientModelRequest.MiddleName.Trim().ToLower()));
                    }
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.LastName))
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.LastName.Trim().ToLower().StartsWith(PatientModelRequest.LastName.Trim().ToLower()));
                    }
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.Mobile))
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.Mobile.Trim().ToLower().StartsWith(PatientModelRequest.Mobile.Trim().ToLower()));
                    }
                    if (!String.IsNullOrWhiteSpace(PatientModelRequest.Phone))
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.Phone.Trim().ToLower().StartsWith(PatientModelRequest.Phone.Trim().ToLower()));
                    }
                    if (PatientModelRequest.BirthDate != null && PatientModelRequest.BirthDate != new DateTime())
                    {
                        SearchCriteriaIsFound = true;
                        _patients = _patients.Where(p => p.BirthDate.Value.Year == PatientModelRequest.BirthDate.Value.Year);
                    }
                }
                if (!SelectBySearchCriteria)
                {
                    SelectedPatients = _patients.ToList();
                }
                else
                {
                    if (SearchCriteriaIsFound)
                    {
                        SelectedPatients = _patients.ToList();
                    }
                }

                return SelectedPatients;
            }
        }
        public static string AddPatientRequest(PatientRequestInputsDataModel PatientRequestInputs, string UserName)
        {
            if (PatientRequestInputs.AnalyzesIDs == null || !PatientRequestInputs.AnalyzesIDs.Any())
            {
                throw new Exception("Please select analyzes first");
            }
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                int EmployeeID = 0;
                if (!String.IsNullOrWhiteSpace(UserName))
                {
                    var _User = db.Users.Where(u => u.UserName.Trim().ToLower() == UserName.Trim().ToLower()).SingleOrDefault();
                    if (_User != null)
                    {
                        EmployeeID = _User.EmployeeID;
                    }
                }
                if (EmployeeID == 0)
                {
                    throw new Exception("There is no user with username: " + UserName);
                }
                if (PatientRequestInputs.OrganizationID != null && PatientRequestInputs.OrganizationID != 0)
                {
                    var _Organization = db.Organizations.Where(p => p.OrganizationID == PatientRequestInputs.OrganizationID).SingleOrDefault();
                    if (_Organization == null)
                    {
                        throw new Exception("There is no organization with ID: " + PatientRequestInputs.OrganizationID);
                    }
                }
                var _Patient = db.Patients.Where(p => p.PatientID == PatientRequestInputs.PatientID).SingleOrDefault();
                if (_Patient == null)
                {
                    throw new Exception("There is no patient with ID: " + PatientRequestInputs.PatientID);
                }
                if (PatientRequestInputs.DoctorRefID != null)
                {
                    var _DoctorRef = db.DoctorRefs.Where(p => p.DoctorRefID == PatientRequestInputs.DoctorRefID).SingleOrDefault();
                    if (_DoctorRef == null)
                    {
                        throw new Exception("There is no doctor reference with ID: " + PatientRequestInputs.DoctorRefID);
                    }
                }
                PatientRequest _PatientRequest = new PatientRequest();
                _PatientRequest.Comment = PatientRequestInputs.Comment;
                _PatientRequest.DoctorRefID = PatientRequestInputs.DoctorRefID;
                _PatientRequest.EmployeeID = EmployeeID;
                if (PatientRequestInputs.OrganizationID == null || PatientRequestInputs.OrganizationID == 0)
                {
                    var IndividualOrganization = GetOrganizationsByCategoryType(ResourceFiles.CategoryType.Individual).FirstOrDefault();
                    if (IndividualOrganization != null)
                    {
                        _PatientRequest.OrganizationID = IndividualOrganization.OrganizationID;
                    }
                }
                else
                {
                    _PatientRequest.OrganizationID = PatientRequestInputs.OrganizationID;
                }
                _PatientRequest.PatientID = PatientRequestInputs.PatientID;
                _PatientRequest.Priority = PatientRequestInputs.Priority;
                _PatientRequest.RequestDate = DateTime.Now;
                Random _r = new Random();
                string ThirdPart = _r.Next(0, 999).ToString().PadLeft(3, '0');
                string FourthPart = _r.Next(84, 999).ToString().PadLeft(3, '0');
                _PatientRequest.RequestedRefID = String.Format("000/000/{0}/{1}", ThirdPart, FourthPart);
                _PatientRequest.AttachmentSession = PatientRequestInputs.AttachmentSession;
                _PatientRequest.ExtraDiscount = PatientRequestInputs.ExtraDiscount;
                _PatientRequest.ExtraCost = PatientRequestInputs.ExtraCost;
                _PatientRequest.TotalOrganizationCost = PatientRequestInputs.TotalOrganizationCost;
                _PatientRequest.TotalPatientCost = PatientRequestInputs.TotalPatientCost;
                db.PatientRequests.Add(_PatientRequest);
                db.SaveChanges();
                Status _PendingRequestStatus = db.Status.Where(s => s.StatusIdentifier == ResourceFiles.Status.PatientRequestPending).SingleOrDefault();
                if (_PendingRequestStatus == null)
                {
                    throw new Exception("There is no status in DB for PatientRequestPending");
                }
                PatientRequestStatu _PatientRequestStatu = new PatientRequestStatu();
                _PatientRequestStatu.Comment = PatientRequestInputs.Comment;
                _PatientRequestStatu.EmployeeID = EmployeeID;
                _PatientRequestStatu.RequestID = _PatientRequest.RequestID;
                _PatientRequestStatu.StatusDate = DateTime.Now;
                _PatientRequestStatu.StatusID = _PendingRequestStatus.StatusID;
                db.PatientRequestStatus.Add(_PatientRequestStatu);
                db.SaveChanges();
                foreach (int AnalysisID in PatientRequestInputs.AnalyzesIDs)
                {
                    int? RunNumber = db.GetAnalysisRunNumber().FirstOrDefault();
                    PatientRequestAnalysi _PatientRequestAnalysi = new PatientRequestAnalysi();
                    _PatientRequestAnalysi.AnalysisID = AnalysisID;
                    _PatientRequestAnalysi.EmployeeID = EmployeeID;
                    _PatientRequestAnalysi.RequestDate = DateTime.Now;
                    _PatientRequestAnalysi.RequestID = _PatientRequest.RequestID;
                    _PatientRequestAnalysi.RunNumber = RunNumber;
                    db.PatientRequestAnalysis.Add(_PatientRequestAnalysi);
                    db.SaveChanges();
                }
                if (PatientRequestInputs.Paid != 0)
                {
                    PatientRequestPayment _PatientRequestPayment = new PatientRequestPayment();
                    _PatientRequestPayment.Comment = PatientRequestInputs.Comment;
                    _PatientRequestPayment.PaidAmount = PatientRequestInputs.Paid;
                    _PatientRequestPayment.PaymentDate = DateTime.Now;
                    _PatientRequestPayment.EmployeeID = EmployeeID;
                    _PatientRequestPayment.RequestID = _PatientRequest.RequestID;
                    db.PatientRequestPayments.Add(_PatientRequestPayment);
                    db.SaveChanges();
                }
                return _PatientRequest.RequestedRefID;
            }
        }


        public static List<Patient_Request_Status_Analysis_ViewModel> GetPendingPatientsRequest()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                var _PatientRequest_LastStatus = (from p in db.Patient_PatientRequest_LastStatus
                                                  where p.StatusIdentifier == ResourceFiles.Status.PatientRequestPending
                                                  select p).ToList(); /// using paging
                var PendingRequestIDs = _PatientRequest_LastStatus.Select(p => p.RequestID).ToList();
                var _PatientRequest_Analysis = (from p in db.PatientRequest_Analysis
                                                where PendingRequestIDs.Contains(p.RequestID)
                                                select p).ToList();

                List<Patient_Request_Status_Analysis_ViewModel> PendingPatientsRequest = Build_Patient_Request_Status_Analysis_ViewModel_List(_PatientRequest_LastStatus, _PatientRequest_Analysis);
                return PendingPatientsRequest;
            }
        }

        private static List<Patient_Request_Status_Analysis_ViewModel> Build_Patient_Request_Status_Analysis_ViewModel_List(
            List<Patient_PatientRequest_LastStatus> _PatientRequest_LastStatus,
            List<PatientRequest_Analysis> _PatientRequest_Analysis)
        {
            List<Patient_Request_Status_Analysis_ViewModel> PendingPatientsRequest = new List<Patient_Request_Status_Analysis_ViewModel>(); 
            if (_PatientRequest_LastStatus != null)
            {
                foreach (var Request in _PatientRequest_LastStatus)
                {
                    Patient_Request_Status_Analysis_ViewModel PatientRequestLastStatus = new Patient_Request_Status_Analysis_ViewModel();
                    PatientRequestLastStatus.PatientRequestStatus = Request;
                    List<string> FullNameArray = new List<string>();
                    if (Request.FirstName != null)
                    {
                        FullNameArray.Add(Request.FirstName.Trim());
                    }
                    if (Request.MiddleName != null)
                    {
                        FullNameArray.Add(Request.MiddleName.Trim());
                    }
                    if (Request.LastName != null)
                    {
                        FullNameArray.Add(Request.LastName.Trim());
                    }
                    PatientRequestLastStatus.PatientFullName = String.Join(" ", FullNameArray);
                    if (_PatientRequest_Analysis != null && _PatientRequest_Analysis.Any())
                    {
                        PatientRequestLastStatus.PatientRequestAnalysis = _PatientRequest_Analysis.Where(a => a.RequestID == Request.RequestID).ToList();
                    }
                    if (!String.IsNullOrWhiteSpace(Request.Priority))
                    {
                        string Prefix = String.Empty;
                        switch (Request.Priority.Trim().ToLower())
                        {
                            case "low":
                                Prefix = "1- ";
                                break;
                            case "medium":
                                Prefix = "2- ";
                                break;
                            case "high":
                                Prefix = "3- ";
                                break;
                        }
                        PatientRequestLastStatus.PriorityOrder = Prefix + Request.Priority;
                    }
                    else
                    {
                        PatientRequestLastStatus.PriorityOrder = "0";
                    }
                    PendingPatientsRequest.Add(PatientRequestLastStatus);
                }
            }
            return PendingPatientsRequest;
        }

        private static List<PatientRequestAnalysi> GetPatientRequestAnalysis(int RequestID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequestAnalysi> PatientRequestAnalysis = new List<PatientRequestAnalysi>();
                var _PatientRequestAnalysis = (from p in db.PatientRequestAnalysis
                                               where p.RequestID == RequestID
                                               select p);

                foreach (var p in _PatientRequestAnalysis)
                {
                    PatientRequestAnalysis.Add(new PatientRequestAnalysi()
                    {
                        Analysis = p.Analysis,
                        AnalysisID = p.AnalysisID,
                        Employee = p.Employee,
                        EmployeeID = p.EmployeeID,
                        PatientRequest = p.PatientRequest,
                        PatientRequestAnalysisStatus = GetPatientRequestAnalysisStatus(p.RequestedAnalysisID),
                        RequestDate = p.RequestDate,
                        RequestedAnalysisID = p.RequestedAnalysisID,
                        RequestID = p.RequestID,
                        RunNumber = p.RunNumber
                    });
                }
                return PatientRequestAnalysis;
            }
        }

        private static List<PatientRequestAnalysisStatu> GetPatientRequestAnalysisStatus(int RequestedAnalysisID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequestAnalysisStatu> PatientRequestAnalysisStatus = new List<PatientRequestAnalysisStatu>();
                var _PatientRequestAnalysisStatus = (from p in db.PatientRequestAnalysisStatus
                                                     where p.RequestedAnalysisID == RequestedAnalysisID
                                                     select p);
                foreach (var p in _PatientRequestAnalysisStatus)
                {
                    PatientRequestAnalysisStatus.Add(new PatientRequestAnalysisStatu()
                    {
                        Comment = p.Comment,
                        Employee = p.Employee,
                        EmployeeID = p.EmployeeID,
                        PatientRequestAnalysi = p.PatientRequestAnalysi,
                        RequestAnalysisStatusID = p.RequestAnalysisStatusID,
                        RequestedAnalysisID = p.RequestedAnalysisID,
                        Status = p.Status,
                        StatusDate = p.StatusDate,
                        StatusID = p.StatusID

                    });
                }
                return PatientRequestAnalysisStatus;
            }
        }

        private static List<PatientRequestStatu> GetPatientRequestStatus(int RequestID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequestStatu> PatientRequestStatus = new List<PatientRequestStatu>();
                var _PatientRequestStatus = (from p in db.PatientRequestStatus
                                             where p.RequestID == RequestID
                                             select p);
                foreach (var p in _PatientRequestStatus)
                {
                    PatientRequestStatus.Add(new PatientRequestStatu()
                    {
                        Comment = p.Comment,
                        Employee = p.Employee,
                        EmployeeID = p.EmployeeID,
                        PatientRequest = p.PatientRequest,
                        RequestID = p.RequestID,
                        RequestStatusID = p.RequestStatusID,
                        Status = p.Status,
                        StatusDate = p.StatusDate,
                        StatusID = p.StatusID

                    });
                }
                return PatientRequestStatus;
            }
        }

        private static List<PatientRequestPayment> GetPatientRequestPayments(int RequestID)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                var PatientRequestPayments = (from p in db.PatientRequestPayments
                                          where p.RequestID == RequestID
                                          select p).ToList();
                return PatientRequestPayments;
            }
        }

        public static List<Patient_Request_Status_Analysis_ViewModel> GetPatientsRequestTransactions(string SearchPattern, DateTime DateFrom, DateTime DateTo)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                IEnumerable<Patient_PatientRequest_LastStatus> _PatientRequest_LastStatus = new List<Patient_PatientRequest_LastStatus>();
                if (String.IsNullOrWhiteSpace(SearchPattern))
                {
                    _PatientRequest_LastStatus = (from p in db.Patient_PatientRequest_LastStatus
                                                  where p.RequestDate >= DateFrom && p.RequestDate < DateTo
                                                  select p).ToList();
                }
                else
                {
                    //// Search by patient name
                    var MatchedByName = (from p in db.Patient_PatientRequest_LastStatus
                                         where (p.FirstName.Trim() + (p.MiddleName.Trim() == null ? " " : " " + p.MiddleName.Trim() + " ") + p.LastName.Trim()).ToLower().Contains(SearchPattern.Trim().ToLower())
                                         select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedByName).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


                    //// Search by Mobile
                    var MatchedByMoblie = (from p in db.Patient_PatientRequest_LastStatus
                                           where p.Mobile.Trim().ToLower().Contains(SearchPattern.Trim().ToLower())
                                           select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedByMoblie).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


                    //// Search by Phone
                    var MatchedByPhone = (from p in db.Patient_PatientRequest_LastStatus
                                          where p.Phone.Trim().ToLower().Contains(SearchPattern.Trim().ToLower())
                                          select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedByPhone).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


                    //// Search by Priority
                    var MatchedByPriority = (from p in db.Patient_PatientRequest_LastStatus
                                             where p.Priority.Trim().ToLower().Contains(SearchPattern.Trim().ToLower())
                                             select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedByPriority).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


                    //// Search by Request Ref ID
                    var MatchedByRequestRefID = (from p in db.Patient_PatientRequest_LastStatus
                                                 where p.RequestedRefID.Trim().ToLower().Contains(SearchPattern.Trim().ToLower())
                                                 select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedByRequestRefID).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


                    //// Search by analysis name
                    var RequestIDsListByAnalysisName = (from p in db.PatientRequest_Analysis
                                                        where p.AnalysisName.Trim().ToLower().Contains(SearchPattern.Trim().ToLower())
                                                        && p.RequestDate >= DateFrom && p.RequestDate < DateTo
                                                        select p.RequestID).ToList();
                    var MatchedbyAnalysisName = (from p in db.Patient_PatientRequest_LastStatus
                                                 where RequestIDsListByAnalysisName.Contains(p.RequestID)
                                                 select p);
                    _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union(MatchedbyAnalysisName).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());

                    //// Date range select
                    _PatientRequest_LastStatus = (from p in _PatientRequest_LastStatus
                                                  where p.RequestDate >= DateFrom && p.RequestDate < DateTo
                                                  select p).ToList();

                }

                var PendingRequestIDs = _PatientRequest_LastStatus.Select(p => p.RequestID).ToList();
                var _PatientRequest_Analysis = (from p in db.PatientRequest_Analysis
                                                where PendingRequestIDs.Contains(p.RequestID)
                                                select p).ToList();
                List<Patient_Request_Status_Analysis_ViewModel> PatientsRequestTransactions = Build_Patient_Request_Status_Analysis_ViewModel_List(_PatientRequest_LastStatus.ToList(), _PatientRequest_Analysis);
                ///// Sorting by Request Date desc then priority desc
                PatientsRequestTransactions = PatientsRequestTransactions.OrderByDescending(p => p.PatientRequestStatus.RequestDate).ThenBy(p => p.PriorityOrder).ToList();
                return PatientsRequestTransactions;
            }
        }       
        /// <summary>
        /// ///////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<PatientRequestAnalysi> GetPendingAnalyzes()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequestAnalysi> PendingAnalyzes=new List<PatientRequestAnalysi>();
                var _PendingAnalyzes = (from r in db.PatientRequestAnalysisStatus
                                       group r by r.RequestedAnalysisID into G
                                       from g in G
                                       let MaxStatusID = G.Max(s => s.RequestAnalysisStatusID)
                                       where g.RequestAnalysisStatusID == MaxStatusID
                                       && g.Status.StatusIdentifier == ResourceFiles.Status.AnalysisPendingForSampling
                                       select g.PatientRequestAnalysi);
                foreach (var analysis in _PendingAnalyzes)
                {
                    PendingAnalyzes.Add(new PatientRequestAnalysi()
                                    {
                                        Analysis = analysis.Analysis,
                                        AnalysisID = analysis.AnalysisID,
                                        Employee = analysis.Employee,
                                        EmployeeID = analysis.EmployeeID,
                                        PatientRequest = analysis.PatientRequest,
                                        PatientRequestAnalysisStatus = analysis.PatientRequestAnalysisStatus,
                                        RequestDate = analysis.RequestDate,
                                        RequestedAnalysisID = analysis.RequestedAnalysisID,
                                        RequestID = analysis.RequestID
                                    });
                }
                return PendingAnalyzes;
            }
        }
        /// <summary>
        /// //////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static List<PatientRequestAnalysi> GetSampledAnalyzes()
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                List<PatientRequestAnalysi> SampledAnalyzes = new List<PatientRequestAnalysi>();
                var _SampledAnalyzes = (from r in db.PatientRequestAnalysisStatus
                                        group r by r.RequestedAnalysisID into G
                                        from g in G
                                        let MaxStatusID = G.Max(s => s.RequestAnalysisStatusID)
                                        where g.RequestAnalysisStatusID == MaxStatusID
                                        && g.Status.StatusIdentifier == ResourceFiles.Status.AnalysisSampled
                                        select g.PatientRequestAnalysi);
                foreach (var analysis in _SampledAnalyzes)
                {
                    SampledAnalyzes.Add(new PatientRequestAnalysi()
                    {
                        Analysis = analysis.Analysis,
                        AnalysisID = analysis.AnalysisID,
                        Employee = analysis.Employee,
                        EmployeeID = analysis.EmployeeID,
                        PatientRequest = analysis.PatientRequest,
                        PatientRequestAnalysisStatus = analysis.PatientRequestAnalysisStatus,
                        RequestDate = analysis.RequestDate,
                        RequestedAnalysisID = analysis.RequestedAnalysisID,
                        RequestID = analysis.RequestID
                    });
                }
                return SampledAnalyzes;
            }
        }
        /// <summary>
        /// /////////////////////////////////////
        /// </summary>
        /// <param name="RequestID"></param>
        /// <param name="ChemistEmployee"></param>
        public static void ReceivePatientRequest(int RequestID, Employee ChemistEmployee)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                var PatientRequest = db.PatientRequests.Where(r => r.RequestID == RequestID).FirstOrDefault();
                if (PatientRequest != null)
                {
                    var PatientRequestReceivedStatus = db.Status.Where(s => s.StatusIdentifier == ResourceFiles.Status.PatientRequestReceived).FirstOrDefault();
                    var AnalysisPendingForSamplingStatus = db.Status.Where(s => s.StatusIdentifier == ResourceFiles.Status.AnalysisPendingForSampling).FirstOrDefault();
                    if (PatientRequestReceivedStatus != null && AnalysisPendingForSamplingStatus != null)
                    {
                        //// add the received status for the patient request
                        PatientRequestStatu RequestStatus = new PatientRequestStatu()
                        {
                            EmployeeID = ChemistEmployee.EmployeeID,
                            Comment = "Patient request is received by " + ChemistEmployee.FirstName + " " + ChemistEmployee.LastName,// employee name 
                            RequestID = PatientRequest.RequestID,
                            StatusDate = DateTime.Now,
                            StatusID = PatientRequestReceivedStatus.StatusID
                        };
                        db.PatientRequestStatus.Add(RequestStatus);
                        //// add the pending status for the requested analyzes
                        var RequestedAnalyzes = db.PatientRequestAnalysis.Where(r => r.RequestID == PatientRequest.RequestID);
                        foreach (var analysis in RequestedAnalyzes)
                        {
                            PatientRequestAnalysisStatu AnalysisStatus = new PatientRequestAnalysisStatu()
                            {
                                EmployeeID = ChemistEmployee.EmployeeID,
                                Comment = "Patient requested analyzes is pending for sampling by " + ChemistEmployee.FirstName + " " + ChemistEmployee.LastName,// employee name 
                                RequestedAnalysisID = analysis.RequestedAnalysisID,
                                StatusDate = DateTime.Now,
                                StatusID = AnalysisPendingForSamplingStatus.StatusID
                            };
                            db.PatientRequestAnalysisStatus.Add(AnalysisStatus);
                        }
                        db.SaveChanges();
                    }
                }
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="RequestedAnalysisID"></param>
        /// <param name="ChemistEmployee"></param>
        public static void SampleAnalysis(int RequestedAnalysisID, Employee ChemistEmployee)
        {
            using (DemoMisrIntEntities db = new DemoMisrIntEntities())
            {
                var RequestedAnalsis = db.PatientRequestAnalysis.Where(r => r.RequestedAnalysisID == RequestedAnalysisID).FirstOrDefault();
                if (RequestedAnalsis != null)
                {
                    var Status = db.Status.Where(s => s.StatusIdentifier == ResourceFiles.Status.AnalysisSampled).FirstOrDefault();
                    if (Status != null)
                    {
                        PatientRequestAnalysisStatu RequestedAnalysisStatus = new PatientRequestAnalysisStatu()
                        {
                            EmployeeID = ChemistEmployee.EmployeeID,
                            Comment = "Requested analysis is sampled by " + ChemistEmployee.FirstName + " " + ChemistEmployee.LastName,// employee name 
                            RequestedAnalysisID = RequestedAnalsis.RequestedAnalysisID,
                            StatusDate = DateTime.Now,
                            StatusID = Status.StatusID
                        };
                        db.PatientRequestAnalysisStatus.Add(RequestedAnalysisStatus);
                        db.SaveChanges();
                    }
                }
            }
        }

       

    }
}