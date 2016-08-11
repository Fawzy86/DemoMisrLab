using DemoMisrInternationalLab.Models;
using System;
using System.Collections.Generic;
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
    }
}