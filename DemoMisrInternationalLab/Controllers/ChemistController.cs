﻿using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Security;
using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
            PatientsRequestsAllViewModel PendingPatientRequest = new PatientsRequestsAllViewModel();
            PendingPatientRequest.PatientRequestStatusWithAnalyzes =  DbFunctions.GetPatientsRequestWithStatus(Resources.Status.PendingForSampling);
            return PartialView("_ReceivePatientRequest", PendingPatientRequest);
        }

        public ActionResult GetPendingRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel PendingRequestAnalyzes = new PatientRequestAnalysisViewModel();
            PendingRequestAnalyzes.PatientRequestAnalyzes =  DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.PendingForSampling);
            return PartialView("_PendingAnalyzesForSampling", PendingRequestAnalyzes);
        }

        public ActionResult GetSampledRequestAnalyzesAfterReceive()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes =  DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.ReceivedForSampling);
            return PartialView("_SampledAnalyzesAfterReceive", SampledRequestAnalyzes);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ReceiveSelectedPatientsRequest(FormCollection form, PatientsRequestsAllViewModel model)
        {
            if (model.SelectedPatientsRequestIDs != null && model.SelectedPatientsRequestIDs.Any())
            {
                 DbFunctions.ReceivePatientRequest(model.SelectedPatientsRequestIDs, HttpContext.User.Identity.Name);
                return   GetPendingPatientRequest();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SampleSelectedRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                 DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.ReceivedForSampling, HttpContext.User.Identity.Name);
               // List<PatientRequestAnalysis_LastStatus> PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.AnalysisSampled);
               // return PatientRequestAnalyzes;
            }
            return null;
        }


           

        /// Preservation Actions//////////////////////////////////////////////////////////////////////////////////////////////



        public ActionResult GetSampledRequestAnalyzesForPreservation()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.ReceivedForSampling);
            return PartialView("_SampledAnalyzesForPreservation", SampledRequestAnalyzes);
        }

        public ActionResult GetSavedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel SavedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SavedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.SavedByChemist);
            return PartialView("_SaveSamples", SavedSampledRequestAnalyzes);
        }

        public ActionResult GetTransferredSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel TransferredSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            TransferredSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.TransferredByChemist);
            return PartialView("_TransferredSamples", TransferredSampledRequestAnalyzes);
        }

        public ActionResult GetLabbedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel LabbedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            LabbedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.PendingForAnalysising);
            return PartialView("_SampledAnalyzesAfterReceive", LabbedSampledRequestAnalyzes);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.SavedByChemist, HttpContext.User.Identity.Name);
                return  GetSavedSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult TransferredSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.TransferredByChemist, HttpContext.User.Identity.Name);
                return  GetTransferredSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MoveToLabSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.PendingForAnalysising, HttpContext.User.Identity.Name);
                return  GetLabbedSampledRequestAnalyzes();
            }
            return null;
        }

        /////////////////////////////////////////////////////////////////////////////////
        public ActionResult LoadTransactions(string SearchPattern, string DateRange)
        {
            PatientsRequestsAllViewModel PatientRequestStatus = new PatientsRequestsAllViewModel();
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
            PatientRequestStatus.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestTransactionsForChemist(SearchPattern, DateFrom, DateTo);
            return PartialView("_Transaction", PatientRequestStatus);
        }
	}
}