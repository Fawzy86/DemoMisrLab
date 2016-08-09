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
            PatientsRequestsAllViewModel PendingPatientRequest = new PatientsRequestsAllViewModel();
       //     PendingPatientRequest.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestWithStatus(Resources.Status.PendingForSamplingForReporting);
       //     return PartialView("_ReceivePatientRequest", PendingPatientRequest);
            return null;
        }
	}
}