using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    public class QCController : Controller
    {
        //
        // GET: /QC/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetPatientsRequestsPendingForReporting()
        {
            PatientsRequestsAllViewModel OpeningPatientRequest = new PatientsRequestsAllViewModel();
            OpeningPatientRequest.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestByAnalysisStatus(Resources.Status.PendingForReporting);
            return PartialView("_QCPatientsRequests", OpeningPatientRequest);
        }


        public ActionResult GetPatientAnalyzesPendingForReporting(string RequestId)
        {
            List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
            if (!String.IsNullOrWhiteSpace(RequestId))
            {
                int _RequestId = 0;
                if (RequestId.Contains("_"))
                {
                    var RequestIdArray = RequestId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                    Int32.TryParse(RequestIdArray[RequestIdArray.Length - 1], out _RequestId);
                }
                else
                {
                    Int32.TryParse(RequestId, out _RequestId);
                }
                if (_RequestId != 0)
                {
                    Analyzes = DbFunctions.GetPatientAnalyzesForReporting(_RequestId);
                }
            }
            return PartialView("_QCAnalysisResult", Analyzes);

        }
	}
}