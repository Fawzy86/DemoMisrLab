using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Security;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    [AuthorizeRoles("DoctorApply")]
    public class QCController : Controller
    {
        //
        // GET: /QC/
        public ActionResult Index()
        {
            return View();
        }

        #region QC Result
        public ActionResult GetPatientsRequestsPendingForReporting(string RequestId)
        {
            PatientsRequestsAllViewModel OpeningPatientRequest = new PatientsRequestsAllViewModel();
            OpeningPatientRequest.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestByAnalysisStatus(Resources.Status.PendingForReporting);
            if (!String.IsNullOrWhiteSpace(RequestId))
            {
                int _RequestId = 0;
                Int32.TryParse(RequestId, out _RequestId);
                if (_RequestId != 0)
                {
                    OpeningPatientRequest.PatientRequestStatusWithAnalyzes = (from p in OpeningPatientRequest.PatientRequestStatusWithAnalyzes
                                                                              where p.PatientRequestStatus.RequestID == _RequestId
                                                                              select p).ToList();
                }
            }
            return PartialView("_QCPatientsRequests", OpeningPatientRequest);
        }


        public ActionResult GetPatientAnalyzesPendingForReporting(string RequestId, string ViewOption)
        {
            PatientRequest_Analyzes_History_ViewModel RequestAnalyzes = new PatientRequest_Analyzes_History_ViewModel();
            if (!String.IsNullOrWhiteSpace(RequestId))
            {
                int _RequestId = 0;
                var RequestIdArray = RequestId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                Int32.TryParse(RequestIdArray[RequestIdArray.Length - 1], out _RequestId);
                if (_RequestId != 0)
                {
                    RequestAnalyzes = DbFunctions.GetAnalyzesForReporting(_RequestId, ViewOption);
                }
            }
            return PartialView("_QCAnalysisResult", RequestAnalyzes);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RecyleAnalysisResults(FormCollection form, PatientRequest_Analyzes_History_ViewModel model, string RequestedAnalysisId)
        {
            if (model != null && model.CurrentRequestAnalyzes !=null && model.CurrentRequestAnalyzes.Any() && !String.IsNullOrWhiteSpace(RequestedAnalysisId))
            {
                var RequestedAnalysisIdArray = RequestedAnalysisId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                int _RequestedAnalysisId = Convert.ToInt32(RequestedAnalysisIdArray[RequestedAnalysisIdArray.Length - 1]);
                DbFunctions.UpdateRequestedAnalyzesStatus(new List<int>() { _RequestedAnalysisId }, Resources.Status.RecycledByQC, HttpContext.User.Identity.Name);
                //// For checking the pending request
                return CheckPendingRequestForReporting(model.CurrentRequestAnalyzes, _RequestedAnalysisId);
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ApproveAnalysisResults(FormCollection form, PatientRequest_Analyzes_History_ViewModel model, string RequestedAnalysisId)
        {
            if (model != null && model.CurrentRequestAnalyzes !=null && model.CurrentRequestAnalyzes.Any() && !String.IsNullOrWhiteSpace(RequestedAnalysisId))
            {
                var RequestedAnalysisIdArray = RequestedAnalysisId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                int _RequestedAnalysisId = Convert.ToInt32(RequestedAnalysisIdArray[RequestedAnalysisIdArray.Length - 1]);
                var AnalysisResults = (from p in model.CurrentRequestAnalyzes
                                       where p.Analysis.RequestedAnalysisID == _RequestedAnalysisId
                                       select p.AnalysisResults).SingleOrDefault();
                DbFunctions.UpdateAnalysisResultsByQC(AnalysisResults, HttpContext.User.Identity.Name);
                DbFunctions.UpdateRequestedAnalyzesStatus(new List<int>() { _RequestedAnalysisId }, Resources.Status.ApprovedByQC, HttpContext.User.Identity.Name);
                //// For checking the pending request
                return CheckPendingRequestForReporting(model.CurrentRequestAnalyzes, _RequestedAnalysisId);
            }
            return null;
        }

        private ActionResult CheckPendingRequestForReporting(List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Requests, int RequestedAnalysisId)
        {
            if (Requests != null && Requests.Any())
            {
                int RequestId = (from p in Requests
                                 where p.Analysis.RequestedAnalysisID == RequestedAnalysisId
                                 select p.Analysis.RequestID).Distinct().FirstOrDefault();
                if (RequestId != 0)
                {
                    var PendingRequestsForReporting = DbFunctions.GetPatientsRequestByAnalysisStatus(Resources.Status.PendingForReporting);
                    if (PendingRequestsForReporting.Any())
                    {
                        var IsPending = PendingRequestsForReporting.Any(p => p.PatientRequestStatus.RequestID == RequestId);
                        if (!IsPending)
                        {
                            PatientsRequestsAllViewModel OpeningPatientRequest = new PatientsRequestsAllViewModel();
                            OpeningPatientRequest.PatientRequestStatusWithAnalyzes = PendingRequestsForReporting;
                            return PartialView("_QCPatientsRequests", OpeningPatientRequest);
                        }
                    }
                }
            }
            return null;
        }

        #endregion


        #region QC analyzes result revision

        public ActionResult GetAnalyzes(string SearchPattern, string SearchType, string DateRange)
        {
            DateTime DateFrom = DateTime.Now.Date;
            DateTime DateTo = DateTime.Now.AddDays(1).Date;
            if (!String.IsNullOrWhiteSpace(DateRange))
            {
                string[] DateRangeArray = DateRange.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                DateTime.TryParse(DateRangeArray[0], out DateFrom);
                if (DateRangeArray.Length > 1)
                {
                    if (DateTime.TryParse(DateRangeArray[1], out DateTo))
                    {
                        DateTo = DateTo.AddDays(1).Date;
                    }
                }
            }
           
            List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
            Analyzes = DbFunctions.GetAnalyzesForQCReviewing(SearchPattern, SearchType, DateFrom, DateTo);
            return PartialView("_RevisionAnalyzes", Analyzes);
        }

        public ActionResult GetAnalysisDetails(string RequestedAnalysisId)
        {
            Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel AnalysisDetails = new Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel();
            if (!String.IsNullOrWhiteSpace(RequestedAnalysisId))
            {
                AnalysisDetails = DbFunctions.GetAnalysisDetails(Convert.ToInt32(RequestedAnalysisId));
                return PartialView("_AnalysisDetailsReport", AnalysisDetails);
            }
            return null;
        }

        #endregion
    }
}