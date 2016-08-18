using DemoMisrInternationalLab.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Utilities
{
    public static class Helper
    {
        public static  bool IsRequestPendingForReporting(List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Requests, int RequestedAnalysisId)
        {
            int RequestId = (from p in Requests
                             where p.Analysis.RequestedAnalysisID == RequestedAnalysisId
                             select p.Analysis.RequestID).Distinct().FirstOrDefault();
            if (RequestId != 0)
            {
                var PendingRequestsForReporting = DbFunctions.GetPatientsRequestByAnalysisStatus(Resources.Status.PendingForReporting);
                if (PendingRequestsForReporting.Any())
                {
                    return PendingRequestsForReporting.Any(p => p.PatientRequestStatus.RequestID == RequestId);
                }
            }
            return false;
        }
        public static PatientRequestInputsDataModel SetPatientRequestInputs(PatientRequestViewModel model)
        {
            PatientRequestInputsDataModel PatientRequestInputs = new PatientRequestInputsDataModel();
            PatientRequestInputs.AnalyzesIDs = model.Analyzes.SelectedAnalyzesIDs;
            PatientRequestInputs.Comment = null;
            PatientRequestInputs.DoctorRefID = model.DoctorsRef.SelectedDoctorRefID;
            PatientRequestInputs.OrganizationID = model.Organizations.SelectedOrganizationID;
            PatientRequestInputs.PaidAmount = model.NewPaymentAmount;
            PatientRequestInputs.PatientID = model.PatientInfo.PatientID;
            PatientRequestInputs.Priority = model.RequestPriority;
            PatientRequestInputs.TotalOrganizationCost = 0;
            PatientRequestInputs.TotalPatientCost = model.TotalAfterCharges;
            PatientRequestInputs.ExtraCost = model.ExtraCost;
            PatientRequestInputs.ExtraDiscount = model.ExtraDiscount;
            PatientRequestInputs.AttachmentSession = model.AttachmentSession;
            return PatientRequestInputs;
        }

        public static void MoveAttachments(string SourceDirectory, string DestinationDirectory)
        {
            string AttachmentSessionDirPath = Path.Combine(SourceDirectory);
            if (Directory.Exists(AttachmentSessionDirPath))
            {
                DirectoryInfo AttachmentSessionDirInfo = new DirectoryInfo(AttachmentSessionDirPath);
                if (AttachmentSessionDirInfo.GetFiles().Any())
                {
                    string SubmittedRequestDirPath = Path.Combine(DestinationDirectory);
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

        public static PatientRequestViewModel GetPatientRequestView()
        {
            PatientRequestViewModel PatientRequest = new PatientRequestViewModel();
            //// Get Provinces
            PatientRequest.PatientInfo.Provinces.ProvincesList = DbFunctions.GetProvinces();
            //// Get DoctorsRef
            PatientRequest.DoctorsRef.DoctorsRefList = DbFunctions.GetDoctorsRef();
            //// Get Analyzes
            PatientRequest.Analyzes.AnalyzesList = DbFunctions.GetAnalyzes();
            PatientRequest.AttachmentSession = Guid.NewGuid().ToString("N");
            return PatientRequest;
        }

        public static PatientInfoViewModel GetPatientInfo(int? patientID)
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
    }
}