using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Utilities;
using System.Web.Security;

namespace DemoMisrInternationalLab.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = DbFunctions.Login(model.UserName, model.Password);
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(user.UserName, model.RememberMe);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                   // ModelState.AddModelError("", "Invalid username or password.");
                    ViewBag.ErrorMessage = "Invalid username or password";
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [Authorize]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

      
    }
}