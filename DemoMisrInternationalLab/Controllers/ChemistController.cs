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
       [AuthorizeRoles("Chemist")]
    public class ChemistController : Controller
    {
        //
        // GET: /ReceiveAndSample/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetPendingPatientRequest()
        {
            PatientsRequestsStatusViewModel PendingPatientRequest = new PatientsRequestsStatusViewModel();
            PendingPatientRequest.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestWithStatus(ResourceFiles.Status.PatientRequestPending);
            return PartialView("_ReceivePatientRequest", PendingPatientRequest);
        }

        public ActionResult GetPendingRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel PendingRequestAnalyzes = new PatientRequestAnalysisViewModel();
            PendingRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisPendingForSampling);
            return PartialView("_PendingAnalyzesForSampling", PendingRequestAnalyzes);
        }

        public ActionResult GetSampledRequestAnalyzesAfterReceive(List<PatientRequestAnalysi> Analyzes)
        {
            if (Analyzes == null || !Analyzes.Any())
            {
                 Analyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
            }
            return PartialView("_SampledAnalyzesAfterReceive", Analyzes);
        }

        public ActionResult GetSampledRequestAnalyzesForPreservation(List<PatientRequestAnalysi> Analyzes)
        {
            PatientRequestAnalysisViewModel PendingRequestAnalyzes = new PatientRequestAnalysisViewModel();
            if (Analyzes == null || !Analyzes.Any())
            {
                Analyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
            }
            PendingRequestAnalyzes.PatientRequestAnalyzes = Analyzes;
            return PartialView("_SampledAnalyzesForPreservation", PendingRequestAnalyzes);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ReceiveSelectedPatientsRequest(FormCollection form, PatientsRequestsStatusViewModel model)
        {
            if (model.SelectedPatientsRequestIDs != null && model.SelectedPatientsRequestIDs.Any())
            {
                DbFunctions.ReceivePatientRequest(model.SelectedPatientsRequestIDs, HttpContext.User.Identity.Name);
                return GetPendingPatientRequest();
            }
            return null;
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public List<PatientRequestAnalysi> SampleSelectedRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.SampleRequestAnalyzes(model.SelectedRequestAnalyzesIDs, HttpContext.User.Identity.Name);
                List<PatientRequestAnalysi> PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
                return PatientRequestAnalyzes;
            }
            return null;
        }
	}
}