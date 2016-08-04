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
                DbFunctions.ReceiveAnalysisOnDevice(Convert.ToInt32(RequestedAnalysisId), HttpContext.User.Identity.Name);
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


        ////////////////////////////////////////////////////////////////////////////////////////////////

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
        public ActionResult MoveAnalyzesToAnotherDevice(FormCollection form, UnitViewModel model, string DeviceAnalyzesIds, string SourceDeviceId, string DestinationDeviceId, bool IsOverhead)
        {
            if (!String.IsNullOrWhiteSpace(DeviceAnalyzesIds) && !String.IsNullOrWhiteSpace(SourceDeviceId) && !String.IsNullOrWhiteSpace(DestinationDeviceId))
            {
                List<int> _DeviceAnalyzesIdsList = new List<int>();
                var DeviceAnalyzesIdsArray = DeviceAnalyzesIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var deviceAnalysisId in DeviceAnalyzesIdsArray)
                {
                    var DeviceAnalysisIdArray = deviceAnalysisId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                    if (DeviceAnalysisIdArray.Count() > 1)
                    {
                        _DeviceAnalyzesIdsList.Add(Convert.ToInt32(DeviceAnalysisIdArray[1]));
                    }
                    else
                    {
                        _DeviceAnalyzesIdsList.Add(Convert.ToInt32(DeviceAnalysisIdArray[0]));
                    }
                }

                int _SourceDeviceId = 0;
                var SourceDeviceIdArray = SourceDeviceId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                if (SourceDeviceIdArray.Count() > 1)
                {
                    _SourceDeviceId = Convert.ToInt32(SourceDeviceIdArray[1]);
                }
                else
                {
                    _SourceDeviceId = Convert.ToInt32(SourceDeviceIdArray[0]);
                }

                int _DestinationDeviceId = 0;
                var DestinationDeviceIdArray = DestinationDeviceId.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                if (DestinationDeviceIdArray.Count() > 1)
                {
                    _DestinationDeviceId = Convert.ToInt32(DestinationDeviceIdArray[1]);
                }
                else
                {
                    _DestinationDeviceId = Convert.ToInt32(DestinationDeviceIdArray[0]);
                }

                var DestinationDevice = DbFunctions.GetDevice(_DestinationDeviceId);
                if (DestinationDevice != null)
                {
                    if (DestinationDevice.Device.Capacity >= DestinationDevice.Analyzes.Count + _DeviceAnalyzesIdsList.Count || IsOverhead)
                    {
                        DbFunctions.MoveAnalyzesToAnotherDevice(_DeviceAnalyzesIdsList, _SourceDeviceId, _DestinationDeviceId, HttpContext.User.Identity.Name);
                        return LoadUnitAndDevices(model.Unit.UnitId);
                      //  return Content(model.Unit.UnitId.ToString());
                    }
                    else
                    {
                        UnitViewModel UnitView = DbFunctions.GetUnitDevices(DestinationDevice.Device.UnitId);
                        ViewBag.Message = String.Format("The device \"{0}\" capcity is \"{1}\" and there is no more space to receive any analysis right now, " +
                            "so please decide what you want to do", DestinationDevice.Device.DeviceName, DestinationDevice.Device.Capacity);

                        ViewBag.SelectedDeviceAnalyzesIds = String.Join(",", _DeviceAnalyzesIdsList);
                        ViewBag.SelectedSourceDeviceId = _SourceDeviceId.ToString();
                        ViewBag.SelectedDestinationDeviceId = _DestinationDeviceId.ToString();
                        return PartialView("_MoveAnalysisToDeviceConfirmation", UnitView);
                    }
                }
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RunTest(FormCollection form, UnitViewModel model, string DeviceId)
        {
            if (!String.IsNullOrWhiteSpace(DeviceId))
            {
                DeviceViewModel Device = DbFunctions.RunTestPlan(Convert.ToInt32(DeviceId));
                return PartialView("_DevicePlanAnalyzes", Device);
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmRunTest(FormCollection form, DeviceViewModel model)
        {
            if (model != null)
            {
                List<int> DeviceAnalyzesIds = model.Analyzes.Select(a => a.DeviceAnalysisId).ToList();
                DbFunctions.ConfirmTestPlan(DeviceAnalyzesIds, model.Device.DeviceId, HttpContext.User.Identity.Name);
                return LoadUnitAndDevices(model.Device.UnitId);
            }
            return null;
        }



        public ActionResult GetPlans(string SearchPattern, string DateRange)
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
            Plans = DbFunctions.GetPlans(SearchPattern, DateFrom, DateTo);
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



        public ActionResult LoadAnalyzesForCaptureResult()
        {
            List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
            Analyzes = DbFunctions.GetAnalysisForCaptureResult();
            return PartialView("_CaptureResult", Analyzes);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveAnalysisReslut(FormCollection form, List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> model, string RequestedAnalysisId, string Result)
        {
            if (!String.IsNullOrWhiteSpace(RequestedAnalysisId) && !String.IsNullOrWhiteSpace(Result))
            {
                List<string> ResultList = Result.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                DbFunctions.SaveResultForRequestedAnalysis(Convert.ToInt32(RequestedAnalysisId), ResultList, HttpContext.User.Identity.Name);
                return LoadAnalyzesForCaptureResult();
            }
            return null;
        }

        
	}
}