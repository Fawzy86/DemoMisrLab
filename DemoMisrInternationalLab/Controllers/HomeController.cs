using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    [AuthorizeRoles("All")]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
          //  return View();
          //  return View("Dashboard");
            return View("Navigation");
        }

        public ActionResult Dashboard()
        {     //  return View();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult UnAuthorized()
        {
            return View();
        }
    }
}