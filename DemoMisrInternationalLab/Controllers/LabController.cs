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
        public ActionResult ReceivedAnalysis(string RequestedAnalysisId, string DeviceId)
        {
            DbFunctions.ReceiveAnalysisOnDevice(Convert.ToInt32(RequestedAnalysisId), Convert.ToInt32(DeviceId), HttpContext.User.Identity.Name);
            return LoadReceivedAnalyzes(null, null);
        }
	}
}