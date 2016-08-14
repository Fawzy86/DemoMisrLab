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
    [AuthorizeRoles("DoctorAnalytic")]
    public class LabController : Controller
    {
        //
        // GET: /Preservation/
        public ActionResult Index()
        {
            return View();
        }

        #region ReceiveAnalysis
        public ActionResult LoadReceivedAnalyzes(string SearchPattern, string DateRange)
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


            PatientRequestAnalysisViewModel ReceivedAnalyzes = new PatientRequestAnalysisViewModel();
            ReceivedAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.PendingForAnalysising);
            ViewBag.RejectionReasons = DbFunctions.GetRejectionReasons();
            ViewBag.NotDeliveredReasons = DbFunctions.GetNotDeliveredReasons();
            return PartialView("_ReceivedAnalyzes", ReceivedAnalyzes);
        }

        [HttpPost]
        public ActionResult ReceiveAnalysis(string RequestedAnalysisId)
        {
            if (!String.IsNullOrWhiteSpace(RequestedAnalysisId))
            {
                DbFunctions.ReceiveAnalysisOnUnit(Convert.ToInt32(RequestedAnalysisId), HttpContext.User.Identity.Name);
                return LoadReceivedAnalyzes(null, null);
            }
            return null;
        }

        [HttpPost]
        public ActionResult RejectAnalysis(string RequestedAnalysisId, string RejectionId)
        {
            DbFunctions.RejectAnalysis(Convert.ToInt32(RequestedAnalysisId), Convert.ToInt32(RejectionId), HttpContext.User.Identity.Name);
            return LoadReceivedAnalyzes(null, null);
        }

        [HttpPost]
        public ActionResult NotDeliveredAnalysis(string RequestedAnalysisId, string RejectionId)
        {
            DbFunctions.NotDeliveredAnalysis(Convert.ToInt32(RequestedAnalysisId), Convert.ToInt32(RejectionId), HttpContext.User.Identity.Name);
            return LoadReceivedAnalyzes(null, null);
        }

        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////////

        #region Work units
        public ActionResult LoadWorkUnits()
        {
            UnitsViewModel WorkUnits = new UnitsViewModel();
            WorkUnits.UnitsList = DbFunctions.GetUnits();
            return PartialView("_WorkUnit", WorkUnits);
        }

        public ActionResult LoadUnitAndDevices(int UnitId)
        {
            UnitViewModel WorkUnitDevices = new UnitViewModel();
            if (UnitId != 0)
            {
                WorkUnitDevices = DbFunctions.GetUnitDevices(UnitId);
            }
            return PartialView("_UnitsAndDevices", WorkUnitDevices);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RunTest(FormCollection form, UnitViewModel model, string DeviceId, string RequestedAnalyzesIds)
        {
            if (!String.IsNullOrWhiteSpace(RequestedAnalyzesIds))
            {
                List<int> RequestedAnalyzesIdsList = new List<int>();
                var RequestedAnalyzesIdsArray = RequestedAnalyzesIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var requestedAnalysisId in RequestedAnalyzesIdsArray)
                {
                    var RequestedAnalysisIdArray = requestedAnalysisId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                    RequestedAnalyzesIdsList.Add(Convert.ToInt32(RequestedAnalysisIdArray[RequestedAnalysisIdArray.Length - 1]));
                }

                int _DestinationDeviceId = 0;
                var DestinationDeviceIdArray = DeviceId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                _DestinationDeviceId = Convert.ToInt32(DestinationDeviceIdArray[DestinationDeviceIdArray.Length - 1]);
                DeviceViewModel Device = new DeviceViewModel();
                Device.Analyzes = (from a in model.ReceivedAnalyzes
                                   where RequestedAnalyzesIdsList.Contains(a.PatientRequestAnalysis.RequestedAnalysisID)
                                   select a.PatientRequestAnalysis).ToList();
                Device.Device = (from d in model.Devices
                                 where d.Device.DeviceId == _DestinationDeviceId
                                 select d.Device).SingleOrDefault();
                Device.Unit = model.Unit;
                //  DeviceViewModel Device = DbFunctions.RunTestPlan(Convert.ToInt32(DeviceId));
                  return PartialView("_DevicePlanAnalyzes", Device);
            }
            return null;
        }

        [HttpPost]
      //  [ValidateAntiForgeryToken]
        public ActionResult ConfirmRunTest(FormCollection form, UnitViewModel parentModel, DeviceViewModel childModel)
        {
            if (childModel != null)
            {
                List<Models.EntityModel.DeviceAnalysi> DeviceAnalyzes = new List<Models.EntityModel.DeviceAnalysi>();
                int RakeNumber = 0;
                foreach (var deviceAnalysis in childModel.Analyzes)
                {
                    ++RakeNumber;
                    DeviceAnalyzes.Add(new Models.EntityModel.DeviceAnalysi()
                    {
                        RakeNumber = RakeNumber,
                        RequestedAnalysisId = deviceAnalysis.RequestedAnalysisID,
                    });
                }
                DbFunctions.RunTestPlan(DeviceAnalyzes, childModel.Unit.UnitId, childModel.Device.DeviceId, HttpContext.User.Identity.Name);
                return Content(String.Join(",", DeviceAnalyzes.Select(a => a.RequestedAnalysisId)));
            }
            return null;
        }

        #endregion


        /////////////////////////////////////////////////////////////////////////////////////////

        #region Plans
        public ActionResult GetPlans(string SearchPattern,string SearchType, string DateRange)
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
            List<PlanViewModel> Plans = new List<PlanViewModel>();
            Plans = DbFunctions.GetPlans(SearchPattern, SearchType, DateFrom, DateTo);
            return PartialView("_FilteredPlans", Plans);
        }


        public ActionResult GetPlanDetails(int PlanId)
        {
            if (PlanId != 0)
            {
                var Plan = DbFunctions.GetPlanDetails(PlanId);
                return PartialView("_PlanDetails", Plan);
            }
            return null;
        }

        #endregion

        /////////////////////////////////////////////////////////////////////////////////////////

        #region Capute Result

        public ActionResult GetOpenedPlans()
        {
            PlansViewModel Plans = new PlansViewModel();
            Plans.PlansList = DbFunctions.GetOpenedPlans();
            return PartialView("_OpenedPlans", Plans);
        }

        public ActionResult LoadAnalyzesForCaptureResult(string PlanId)
        {
            List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
            Analyzes = DbFunctions.GetAnalyzesForCaptureResult(Convert.ToInt32(PlanId));
            return PartialView("_CaptureResult", Analyzes);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveAnalysisReslut(FormCollection form, PlansViewModel model,List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> childModel, string RequestedAnalysisId)
        {
            if (model != null && childModel != null && childModel.Any() && !String.IsNullOrWhiteSpace(RequestedAnalysisId))
            {
                int _RequestedAnalysisId = Convert.ToInt32(RequestedAnalysisId);
                var RequestAnalysis = (from p in childModel
                                       where p.Analysis.RequestedAnalysisID == _RequestedAnalysisId
                                       select p).SingleOrDefault();
                if (RequestAnalysis != null)
                {
                    DbFunctions.SaveResultForRequestedAnalysis(_RequestedAnalysisId, RequestAnalysis.AnalysisResultsDetails, HttpContext.User.Identity.Name);
                    PlanViewModel PlanView = DbFunctions.GetPlanDetails(RequestAnalysis.Analysis.PlanId);
                    if (PlanView.IsOpened)
                    {
                        // List<DemoMisrInternationalLab.Models.Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>
                        return Content(RequestAnalysis.Analysis.PlanId.ToString());
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            return null;
        }


        #endregion

    }
}