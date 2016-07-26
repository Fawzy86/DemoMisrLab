using DemoMisrInternationalLab.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Data.Entity;

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
        public static  User Login(string LoginName, string Password)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    User _User =  db.Users.Where(u => u.UserName.ToLower().Trim() == LoginName.ToLower().Trim()
                                                && u.UserPassword.Trim() == Password.Trim()).SingleOrDefault();
                    return _User;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// /////////////////////////////////////////
        /// </summary>
        /// <param name="LoginName"></param>
        /// <param name="RoleName"></param>
        /// <returns></returns>
        public static string GetUserRole(string LoginName)
        {
            try
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
                        /*if (_User.Role.RoleName == RoleName)
                        {
                            return true;
                        }*/
                        return _User.Role.RoleName != null ? _User.Role.RoleName.Trim() : null;
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return null;
        }
        public static  int GetUserEmployeeId(string UserName)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    if (String.IsNullOrWhiteSpace(UserName))
                    {
                        throw new Exception("Please login first");
                    }
                    var _User =  db.Users.Where(u => u.UserName.ToLower().Trim() == UserName.ToLower().Trim()).SingleOrDefault();

                    if (_User != null)
                    {
                        return _User.Employee.EmployeeID;
                    }
                    else
                    {
                        throw new Exception("There is no user with username: " + UserName);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ////////////////////////////////////
        /// </summary>
        /// <param name="StateProvinceID"></param>
        /// <returns></returns>
        public static List<City> GetCities(int StateProvinceID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<City> Cities =  db.Cities.Where(c => c.ProvinceID == StateProvinceID).ToList();
                    return Cities;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static  List<Province> GetProvinces()
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<Province> Provinces =  db.Provinces.ToList();
                    return Provinces;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static  List<DoctorRef> GetDoctorsRef()
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    var DoctorsRef =  db.DoctorRefs.ToList();
                    return DoctorsRef;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static  List<DoctorSpecialization> GetDoctorsSpecialization()
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<DoctorSpecialization> DoctorsSpecialization =   db.DoctorSpecializations.ToList();
                    return DoctorsSpecialization;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="NewDoctorRef"></param>
        /// <returns></returns>
        public static  int AddNewDoctorRef(DoctorRefViewModel NewDoctorRef)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    if (NewDoctorRef.DoctorsSpecializations.SelectedDoctorSpecializationID != 0)
                    {
                        throw new Exception("The specialization is missing");
                    }
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

        public static  decimal GetAnalyzesCost(string AnalyzesIDs, string PackageName)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    decimal TotalCost = 0;
                    var SelectedPackage =  db.Packages.Where(p => p.PackageName == PackageName).SingleOrDefault();
                    if (SelectedPackage != null)
                    {
                        List<int> RequiredAnalyzes = AnalyzesIDs.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(Int32.Parse).ToList();
                        var SelectedAnalyzes =  (from p in db.PackageCostLists
                                                      where RequiredAnalyzes.Contains(p.AnalysisID) && p.PackageID == SelectedPackage.PackageID
                                                      select p).ToList();
                        foreach (var analyzis in SelectedAnalyzes)
                        {
                            TotalCost += analyzis.Analysis.CostPrice * (1 - analyzis.CurrentAnalysisDiscountRate / 100);
                        }
                    }
                    return TotalCost;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// /////////////////////////////////////////////
        /// </summary>
        /// <param name="AnalysisID"></param>
        /// <returns></returns>
        public static  Analysis GetAnalysis(int AnalysisID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    Analysis _analysis =  (from p in db.Analyses
                                                where p.AnalysisID == AnalysisID
                                                select p).SingleOrDefault();

                    return _analysis;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ///////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>
        public static  List<AnalysisViewModel> GetAnalyzes()
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<AnalysisViewModel> AnalyzesList = new List<AnalysisViewModel>();
                    var _Analyzes =  (from a in db.Analyses
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="OrganizationType"></param>
        /// <returns></returns>
        public static  List<Organization> GetOrganizationsByCategoryType(string CategoryTypeName)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<Organization> Organizations = new List<Organization>();
                    Organizations =  (from o in db.Organizations
                                           where o.Package.CategoryType.CategoryTypeName == CategoryTypeName
                                           select o).ToList();
                    return Organizations;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientModelRequest"></param>
        /// <returns></returns>
        public static  List<PatientRequest> GetMatchingPatients(PatientInfoViewModel PatientModelRequest)
        {
            try
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
                            SelectedPatients =  SelectedPatients.Concat( MatchedByName).ToList();
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
                            SelectedPatients = SelectedPatients.Concat( MatchedByPhone).ToList();
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////
        /// </summary>
        /// <param name="UpdatedPatient"></param>
        /// <returns></returns>
        public static  void UpdateExistingPatient(PatientInfoViewModel UpdatedPatient, string UserName)
        {
            try
            {
                if (UpdatedPatient == null && UpdatedPatient.PatientID == 0)
                {
                    throw new Exception("This patient doesn't exist in the database");
                }
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    int EmployeeID =  GetUserEmployeeId(UserName);
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static  void UpdatePatientRefID(int PatientID, int PatientReferenceID, string UserName)
        {
            try
            {
                if (PatientID == 0)
                {
                    throw new Exception("This patient doesn't exist in the database");
                }
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    int EmployeeID =  GetUserEmployeeId(UserName);
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////
        /// </summary>
        /// <param name="NewPatient"></param>
        /// <returns></returns>
        public static  int AddNewPatient(PatientInfoViewModel NewPatient, string UserName)
        {
            try
            {
                if (NewPatient == null)
                {
                    throw new Exception("The patient info is missing");
                }
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    int EmployeeID =  GetUserEmployeeId(UserName);
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientID"></param>
        /// <returns></returns>
        public static  Patient GetPatient(int PatientID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    Patient _patient = null;
                    var SelectedPatient =  (from p in db.Patients
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }
        /// <summary>
        /// ////////////////////////////////////////////////////
        /// </summary>
        /// <param name="PatientModelRequest"></param>
        /// <param name="SelectBySearchCriteria"></param>
        /// <returns></returns>
        public static  List<Patient> GetPatients(PatientInfoViewModel PatientModelRequest, bool SelectBySearchCriteria)
        {
            try
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
                        SelectedPatients =  _patients.ToList();
                    }
                    else
                    {
                        if (SearchCriteriaIsFound)
                        {
                            SelectedPatients =  _patients.ToList();
                        }
                    }

                    return SelectedPatients;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static  string AddPatientRequest(PatientRequestInputsDataModel PatientRequestInputs, string UserName)
        {
            try
            {
                if (PatientRequestInputs.AnalyzesIDs == null || !PatientRequestInputs.AnalyzesIDs.Any())
                {
                    throw new Exception("Please select analyzes first");
                }
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    int EmployeeID =  GetUserEmployeeId(UserName);
                    if (PatientRequestInputs.OrganizationID != null && PatientRequestInputs.OrganizationID != 0)
                    {
                        var _Organization =  db.Organizations.Where(p => p.OrganizationID == PatientRequestInputs.OrganizationID).SingleOrDefault();
                        if (_Organization == null)
                        {
                            throw new Exception("There is no organization with ID: " + PatientRequestInputs.OrganizationID);
                        }
                    }
                    var _Patient =  db.Patients.Where(p => p.PatientID == PatientRequestInputs.PatientID).SingleOrDefault();
                    if (_Patient == null)
                    {
                        throw new Exception("There is no patient with ID: " + PatientRequestInputs.PatientID);
                    }
                    if (PatientRequestInputs.DoctorRefID != null)
                    {
                        var _DoctorRef =  db.DoctorRefs.Where(p => p.DoctorRefID == PatientRequestInputs.DoctorRefID).SingleOrDefault();
                        if (_DoctorRef == null)
                        {
                            throw new Exception("There is no doctor reference with ID: " + PatientRequestInputs.DoctorRefID);
                        }
                    }
                    PatientRequest _PatientRequest = new PatientRequest();
                    int? RequestNumber =  db.GetRequestNumber().FirstOrDefault();
                    _PatientRequest.RequestNumber = RequestNumber.Value;
                    _PatientRequest.Comment = PatientRequestInputs.Comment;
                    _PatientRequest.DoctorRefID = PatientRequestInputs.DoctorRefID;
                    _PatientRequest.EmployeeID = EmployeeID;
                    if (PatientRequestInputs.OrganizationID == null || PatientRequestInputs.OrganizationID == 0)
                    {
                        var IndividualOrganizations=  GetOrganizationsByCategoryType(Resources.CategoryType.Individual);
                        if (IndividualOrganizations != null && IndividualOrganizations.FirstOrDefault() != null)
                        {
                            _PatientRequest.OrganizationID = IndividualOrganizations.FirstOrDefault().OrganizationID;
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
                    Status _PendingRequestStatus =  db.Status.Where(s => s.StatusIdentifier == Resources.Status.PatientRequestPending).SingleOrDefault();
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
                        PatientRequestAnalysi _PatientRequestAnalysi = new PatientRequestAnalysi();
                        _PatientRequestAnalysi.AnalysisID = AnalysisID;
                        _PatientRequestAnalysi.EmployeeID = EmployeeID;
                        _PatientRequestAnalysi.RequestDate = DateTime.Now;
                        _PatientRequestAnalysi.RequestID = _PatientRequest.RequestID;
                        _PatientRequestAnalysi.RunNumber = null;
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public static  List<Patient_Request_Status_Analysis_ViewModel> GetPatientsRequestWithStatus(string RequestStatus)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    var _PatientRequest_LastStatus =  (from p in db.Patient_PatientRequest_LastStatus
                                                            where p.StatusIdentifier == RequestStatus
                                                            select p).ToList(); /// using paging
                    var PendingRequestIDs = _PatientRequest_LastStatus.Select(p => p.RequestID).ToList();
                    var _PatientRequest_Analysis =  (from p in db.PatientRequest_Analysis
                                                          where PendingRequestIDs.Contains(p.RequestID)
                                                          select p).ToList();

                    List<Patient_Request_Status_Analysis_ViewModel> PendingPatientsRequest = Build_Patient_Request_Status_Analysis_ViewModel_List(_PatientRequest_LastStatus, _PatientRequest_Analysis);
                    return PendingPatientsRequest;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private static List<Patient_Request_Status_Analysis_ViewModel> Build_Patient_Request_Status_Analysis_ViewModel_List(
            List<Patient_PatientRequest_LastStatus> _PatientRequest_LastStatus,
            List<PatientRequest_Analysis> _PatientRequest_Analysis)
        {
            try
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private static  List<PatientRequestAnalysi> GetPatientRequestAnalysis(int RequestID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<PatientRequestAnalysi> PatientRequestAnalysis = new List<PatientRequestAnalysi>();
                    var _PatientRequestAnalysis =  (from p in db.PatientRequestAnalysis
                                                         where p.RequestID == RequestID
                                                         select p).ToList();

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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private static List<PatientRequestAnalysisStatu> GetPatientRequestAnalysisStatus(int RequestedAnalysisID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<PatientRequestAnalysisStatu> PatientRequestAnalysisStatus = new List<PatientRequestAnalysisStatu>();
                    var _PatientRequestAnalysisStatus = (from p in db.PatientRequestAnalysisStatus
                                                         where p.RequestedAnalysisID == RequestedAnalysisID
                                                         select p).ToList();
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private static  List<PatientRequestStatu> GetPatientRequestStatus(int RequestID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    List<PatientRequestStatu> PatientRequestStatus = new List<PatientRequestStatu>();
                    var _PatientRequestStatus =  (from p in db.PatientRequestStatus
                                                       where p.RequestID == RequestID
                                                       select p).ToList();
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
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private static  List<PatientRequestPayment> GetPatientRequestPayments(int RequestID)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    var PatientRequestPayments =  (from p in db.PatientRequestPayments
                                                        where p.RequestID == RequestID
                                                        select p).ToList();
                    return PatientRequestPayments;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static  List<Patient_Request_Status_Analysis_ViewModel> GetPatientsRequestTransactions(string SearchPattern, DateTime DateFrom, DateTime DateTo)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    IEnumerable<Patient_PatientRequest_LastStatus> _PatientRequest_LastStatus = new List<Patient_PatientRequest_LastStatus>();
                    if (String.IsNullOrWhiteSpace(SearchPattern))
                    {
                        _PatientRequest_LastStatus =  (from p in db.Patient_PatientRequest_LastStatus
                                                            where p.RequestDate >= DateFrom && p.RequestDate < DateTo
                                                            select p).ToList();
                    }
                    else
                    {
                        //// Search by patient name
                        var MatchedByName = (from p in db.Patient_PatientRequest_LastStatus
                                             where (p.FirstName.Trim() + (p.MiddleName.Trim() == null ? " " : " " + p.MiddleName.Trim() + " ") + p.LastName.Trim()).ToLower().Contains(SearchPattern.Trim().ToLower())
                                             select p);
                        _PatientRequest_LastStatus = _PatientRequest_LastStatus.Union( MatchedByName.ToList()).GroupBy(p => p.RequestedRefID).Select(p => p.FirstOrDefault());


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
                        var RequestIDsListByAnalysisName =  (from p in db.PatientRequest_Analysis
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
                    var _PatientRequest_Analysis =  (from p in db.PatientRequest_Analysis
                                                          where PendingRequestIDs.Contains(p.RequestID)
                                                          select p).ToList();
                    List<Patient_Request_Status_Analysis_ViewModel> PatientsRequestTransactions = Build_Patient_Request_Status_Analysis_ViewModel_List(_PatientRequest_LastStatus.ToList(), _PatientRequest_Analysis);
                    ///// Sorting by Request Date desc then priority desc
                    PatientsRequestTransactions = PatientsRequestTransactions.OrderByDescending(p => p.PatientRequestStatus.RequestDate).ThenBy(p => p.PriorityOrder).ToList();
                    return PatientsRequestTransactions;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// ///////////////////////////
        /// </summary>
        /// <returns></returns>
        public static  List<PatientRequest_PatientRequestAnalysis_LastStatus> GetRequestAnalyzesWithStatus(string StatusIdentifier)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    var _RequestAnalyzes =  (from r in db.PatientRequest_PatientRequestAnalysis_LastStatus
                                                  where r.StatusIdentifier == StatusIdentifier
                                                  select r).ToList();
                    return _RequestAnalyzes;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// /////////////////////////////////////
        /// </summary>
        /// <param name="RequestID"></param>
        /// <param name="ChemistEmployee"></param>
        public static  void ReceivePatientRequest(List<int> RequestsIDs, string UserName)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    if (RequestsIDs != null && RequestsIDs.Any())
                    {
                        int EmployeeID =  GetUserEmployeeId(UserName);
                        foreach (var requestID in RequestsIDs)
                        {
                            try
                            {
                                var PatientRequest = db.PatientRequests.Where(r => r.RequestID == requestID).FirstOrDefault();
                                if (PatientRequest != null)
                                {
                                    var _PatientRequestReceivedStatus =  db.Status.Where(s => s.StatusIdentifier == Resources.Status.PatientRequestReceived).FirstOrDefault();
                                    var _AnalysisPendingForSamplingStatus =  db.Status.Where(s => s.StatusIdentifier == Resources.Status.AnalysisPendingForSampling).FirstOrDefault();
                                    if (_PatientRequestReceivedStatus != null && _AnalysisPendingForSamplingStatus != null)
                                    {
                                        //// add the received status for the patient request
                                        PatientRequestStatu RequestStatus = new PatientRequestStatu()
                                        {
                                            EmployeeID = EmployeeID,
                                            //   Comment = "Patient request is received by " + EmployeeID.FirstName + " " + EmployeeID.LastName,// employee name 
                                            RequestID = PatientRequest.RequestID,
                                            StatusDate = DateTime.Now,
                                            StatusID = _PatientRequestReceivedStatus.StatusID
                                        };
                                        db.PatientRequestStatus.Add(RequestStatus);
                                        //// add the pending status for the requested analyzes
                                        var _RequestedAnalyzes =  db.PatientRequestAnalysis.Where(r => r.RequestID == PatientRequest.RequestID).ToList();
                                        foreach (var analysis in _RequestedAnalyzes)
                                        {
                                            PatientRequestAnalysisStatu AnalysisStatus = new PatientRequestAnalysisStatu()
                                            {
                                                EmployeeID = EmployeeID,
                                                //     Comment = "Patient requested analyzes is pending for sampling by " + EmployeeID.FirstName + " " + EmployeeID.LastName,// employee name 
                                                RequestedAnalysisID = analysis.RequestedAnalysisID,
                                                StatusDate = DateTime.Now,
                                                StatusID = _AnalysisPendingForSamplingStatus.StatusID
                                            };
                                            db.PatientRequestAnalysisStatus.Add(AnalysisStatus);
                                        }
                                         db.SaveChanges();
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                continue;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// //////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="RequestedAnalysisID"></param>
        /// <param name="ChemistEmployee"></param>
        public static  void AddNewRequestAnalyzesStatus(List<int> RequestedAnalyzesIDs, string StatusIdentifier, string UserName)
        {
            try
            {
                using (DemoMisrIntEntities db = new DemoMisrIntEntities())
                {
                    if (RequestedAnalyzesIDs != null && RequestedAnalyzesIDs.Any())
                    {
                        int EmployeeID =  GetUserEmployeeId(UserName);
                        foreach (var requestedAnalysisID in RequestedAnalyzesIDs)
                        {
                            try
                            {
                                var _RequestedAnalsis =  db.PatientRequestAnalysis.Where(r => r.RequestedAnalysisID == requestedAnalysisID).FirstOrDefault();
                                if (_RequestedAnalsis != null)
                                {
                                    if (_RequestedAnalsis.RunNumber == null)
                                    {
                                        int? RunNumber = db.GetAnalysisRunNumber().FirstOrDefault();
                                        _RequestedAnalsis.RunNumber = RunNumber.Value;
                                    }
                                    var _Status =  db.Status.Where(s => s.StatusIdentifier == StatusIdentifier).FirstOrDefault();
                                    if (_Status != null)
                                    {
                                        PatientRequestAnalysisStatu _RequestedAnalysisStatus = new PatientRequestAnalysisStatu()
                                        {
                                            EmployeeID = EmployeeID,
                                            //   Comment = "Requested analysis is sampled by " + ChemistEmployee.FirstName + " " + ChemistEmployee.LastName,// employee name 
                                            RequestedAnalysisID = _RequestedAnalsis.RequestedAnalysisID,
                                            StatusDate = DateTime.Now,
                                            StatusID = _Status.StatusID
                                        };
                                        db.PatientRequestAnalysisStatus.Add(_RequestedAnalysisStatus);
                                         db.SaveChanges();
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                continue;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}