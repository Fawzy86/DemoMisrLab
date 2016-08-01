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
            ReceivedAnalyzes.PatientRequestAnalyzes = DbFunctions.GetReceivedAnalyzesWithDevices(Resources.Status.AnalysisMovedToLab);
            ViewBag.RejectionReasons = DbFunctions.GetRejectionReasons();
            ViewBag.NotDeliveredReasons = DbFunctions.GetNotDeliveredReasons();
            return PartialView("_ReceivedAnalyzes", ReceivedAnalyzes);
        }

        [HttpPost]
        public ActionResult ReceiveAnalysis(string RequestedAnalysisId, string DeviceId)
        {
            DbFunctions.ReceiveAnalysisOnDevice(Convert.ToInt32(RequestedAnalysisId), Convert.ToInt32(DeviceId), HttpContext.User.Identity.Name);
            return LoadReceivedAnalyzes(null, null);
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

        public ActionResult LoadDevicesWithAnalyzes(int UnitId)
        {
            UnitViewModel WorkUnitDevices = new UnitViewModel();
            if (UnitId != 0)
            {
                WorkUnitDevices = DbFunctions.GetUnitDevices(UnitId);
            }
            return PartialView("_AnalyzesAndDevices", WorkUnitDevices);
        }

        [HttpPost]
        public ActionResult MoveAnalyzesToAnotherDevice(FormCollection form, UnitViewModel model, string RequestedAnalyzesIds, string SourceDeviceId, string DestinationDeviceId)
        {
            if (!String.IsNullOrWhiteSpace(RequestedAnalyzesIds) && !String.IsNullOrWhiteSpace(SourceDeviceId) && !String.IsNullOrWhiteSpace(DestinationDeviceId))
            {
                List<int> _RequestedAnalyzesIdsList = new List<int>();
                var RequestedAnalyzesIdsArray = RequestedAnalyzesIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var requestedAnalysis in RequestedAnalyzesIdsArray)
                {
                    var RequestedAnalysisArray = requestedAnalysis.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                    if (RequestedAnalysisArray.Count() > 1)
                    {
                        _RequestedAnalyzesIdsList.Add(Convert.ToInt32(RequestedAnalysisArray[1]));
                    }
                    else
                    {
                        _RequestedAnalyzesIdsList.Add(Convert.ToInt32(RequestedAnalysisArray[0]));
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

                DbFunctions.MoveAnalyzesToAnotherDevice(_RequestedAnalyzesIdsList, _SourceDeviceId, _DestinationDeviceId);
            //    return LoadDevicesWithAnalyzes(model.Unit.UnitId);
            }
            return null;
        }





        
	}
}