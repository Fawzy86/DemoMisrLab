using DemoMisrInternationalLab.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Security
{
    public class AuthorizeRolesAttribute : AuthorizeAttribute
    {
        private readonly string[] userAssignedRoles;
        public AuthorizeRolesAttribute(params string[] roles)
        {
            this.userAssignedRoles = roles;
        }
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            if (String.IsNullOrWhiteSpace(httpContext.User.Identity.Name))
            {
                return false;
            }
            foreach (var role in userAssignedRoles)
            {
                if (role.ToLower().Trim() == "all")
                {
                    return true;
                }
               /* bool authorize = DbFunctions.GetUserInRole(httpContext.User.Identity.Name, roles);
                if (authorize)
                {
                    return true;
                }*/
                string UserRole = DbFunctions.GetUserRole(httpContext.User.Identity.Name);
                if (UserRole.ToLower() == "admin" || role.Trim() == UserRole)
                {
                    return true;
                }
            }
            return false;
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            /*if (String.IsNullOrWhiteSpace(httpContext.User.Identity.Name))
            {
                return false;
            }*/
            if (String.IsNullOrWhiteSpace(filterContext.HttpContext.User.Identity.Name))
            {
                filterContext.Result = new RedirectResult("~/Account/Login");
            }
            else
            {
                filterContext.Result = new RedirectResult("~/Home/UnAuthorized");
            }
        }
    }
}