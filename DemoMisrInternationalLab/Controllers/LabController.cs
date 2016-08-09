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
            ReceivedAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.AnalysisMovedToLab);
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
                    if (RequestedAnalysisIdArray.Count() > 1)
                    {
                        RequestedAnalyzesIdsList.Add(Convert.ToInt32(RequestedAnalysisIdArray[1]));
                    }
                    else
                    {
                        RequestedAnalyzesIdsList.Add(Convert.ToInt32(RequestedAnalysisIdArray[0]));
                    }
                }

                int _DestinationDeviceId = 0;
                var DestinationDeviceIdArray = DeviceId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                if (DestinationDeviceIdArray.Count() > 1)
                {
                    _DestinationDeviceId = Convert.ToInt32(DestinationDeviceIdArray[1]);
                }
                else
                {
                    _DestinationDeviceId = Convert.ToInt32(DestinationDeviceIdArray[0]);
                }
                DeviceViewModel Device = new DeviceViewModel();
                Device.Analyzes = (from a in model.ReceivedAnalyzes
                                   where RequestedAnalyzesIdsList.Contains(a.PatientRequestAnalysis.RequestedAnalysisID)
                                   select a.PatientRequestAnalysis).ToList();
                Device.Device = (from d in model.Devices
                                 where d.Device.DeviceId == _DestinationDeviceId
                                 select d.Device).SingleOrDefault();
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
                        DeviceId = childModel.Device.DeviceId,
                        RakeNumber = RakeNumber,
                        RequestedAnalysisId = deviceAnalysis.RequestedAnalysisID,
                    });
                }
                DbFunctions.RunTestPlan(DeviceAnalyzes, HttpContext.User.Identity.Name);
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
            Analyzes = DbFunctions.GetAnalysisForCaptureResult(Convert.ToInt32(PlanId));
            return PartialView("_CaptureResult", Analyzes);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveAnalysisReslut(FormCollection form, PlansViewModel model, string PlanId, string RequestedAnalysisId, string Result)
        {
            if (!String.IsNullOrWhiteSpace(PlanId) && !String.IsNullOrWhiteSpace(RequestedAnalysisId) && !String.IsNullOrWhiteSpace(Result))
            {
                List<string> ResultList = Result.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                DbFunctions.SaveResultForRequestedAnalysis(Convert.ToInt32(RequestedAnalysisId), ResultList, HttpContext.User.Identity.Name);
                PlanViewModel PlanView = DbFunctions.GetPlanDetails(Convert.ToInt32(PlanId));
                if (PlanView.IsOpened)
                {
                    return Content(PlanId);
                }
                else
                {
                    return null;
                }
            }
            return null;
        }


        #endregion

    }
}