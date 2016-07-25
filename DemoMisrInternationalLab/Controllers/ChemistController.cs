﻿using DemoMisrInternationalLab.Models;
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

        public ActionResult GetSampledRequestAnalyzesAfterReceive()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
            return PartialView("_SampledAnalyzesAfterReceive", SampledRequestAnalyzes);
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
        public ActionResult SampleSelectedRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.AddNewRequestAnalyzesStatus(model.SelectedRequestAnalyzesIDs, ResourceFiles.Status.AnalysisSampled, HttpContext.User.Identity.Name);
               // List<PatientRequestAnalysis_LastStatus> PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
               // return PatientRequestAnalyzes;
            }
            return null;
        }


           

        /// Preservation Actions//////////////////////////////////////////////////////////////////////////////////////////////



        public ActionResult GetSampledRequestAnalyzesForPreservation()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSampled);
            return PartialView("_SampledAnalyzesForPreservation", SampledRequestAnalyzes);
        }

        public ActionResult GetSavedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel SavedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SavedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisSaved);
            return PartialView("_SaveSamples", SavedSampledRequestAnalyzes);
        }

        public ActionResult GetTransferredSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel TransferredSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            TransferredSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisTransferred);
            return PartialView("_TransferredSamples", TransferredSampledRequestAnalyzes);
        }

        public ActionResult GetLabbedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel LabbedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            LabbedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(ResourceFiles.Status.AnalysisMovedToLab);
            return PartialView("_SampledAnalyzesAfterReceive", LabbedSampledRequestAnalyzes);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.AddNewRequestAnalyzesStatus(model.SelectedRequestAnalyzesIDs, ResourceFiles.Status.AnalysisSaved, HttpContext.User.Identity.Name);
                return GetSavedSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult TransferredSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.AddNewRequestAnalyzesStatus(model.SelectedRequestAnalyzesIDs, ResourceFiles.Status.AnalysisTransferred, HttpContext.User.Identity.Name);
                return GetTransferredSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MoveToLabSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.AddNewRequestAnalyzesStatus(model.SelectedRequestAnalyzesIDs, ResourceFiles.Status.AnalysisMovedToLab, HttpContext.User.Identity.Name);
                return GetLabbedSampledRequestAnalyzes();
            }
            return null;
        }
	}
}