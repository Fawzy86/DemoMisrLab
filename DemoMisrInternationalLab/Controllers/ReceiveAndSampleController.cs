using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    public class ReceiveAndSampleController : Controller
    {
        //
        // GET: /ReceiveAndSample/
        public ActionResult Index()
        {
            return View(GetPendingRequestAndAnalyzes());
        }

        [NonAction]
        private ReceiveAndSampleViewModel GetPendingRequestAndAnalyzes()
        {
            ReceiveAndSampleViewModel ReceivedSampling = new ReceiveAndSampleViewModel();

            ReceivedSampling.PendingPatientsRequests = DbFunctions.GetPendingPatientsRequest();

            ReceivedSampling.PendingAnalyzesForSampling = DbFunctions.GetPendingAnalyzes();

            ReceivedSampling.SampledAnalyzes = DbFunctions.GetSampledAnalyzes();

            ReceivedSampling.SelectedAnalyzesIDs = new int[] { };

            ReceivedSampling.SelectedPatientsRequestIDs = new int[] { };

            return ReceivedSampling;
        }

        [HttpPost]
        public ActionResult Index(ReceiveAndSampleViewModel model, string ReceiveActionLink, string SampleActionLink)
        {
            if (ModelState.IsValid)
            {
                if (ReceiveActionLink != null)
                {
                    return ReceivePatientsRequest(model);
                }
                else if (SampleActionLink != null)
                {
                    return SampleAnalyzes(model);
                }
            }
            return View(model);
        }


        [NonAction]
        private ActionResult ReceivePatientsRequest(ReceiveAndSampleViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.SelectedPatientsRequestIDs != null && model.SelectedPatientsRequestIDs.Any())
                {
                    foreach (var requestID in model.SelectedPatientsRequestIDs)
                    {
                        DbFunctions.ReceivePatientRequest(requestID, new Employee() { EmployeeID = 2, FirstName = "Ahmed" });
                    }
                    return RedirectToAction("Index");
                }
            }
            return View(model);
        }

        [NonAction]
        private ActionResult SampleAnalyzes(ReceiveAndSampleViewModel model)
        {
            if (ModelState.IsValid)
            {

                if (model.SelectedAnalyzesIDs != null && model.SelectedAnalyzesIDs.Any())
                {
                    foreach (var requestedAnalysisID in model.SelectedAnalyzesIDs)
                    {
                        DbFunctions.SampleAnalysis(requestedAnalysisID, new Employee() { EmployeeID = 2, FirstName = "Ahmed" });
                    }
                    return RedirectToAction("Index");
                }

            }
            return View(model);
            //  return RedirectToAction("Index");
        }
	}
}