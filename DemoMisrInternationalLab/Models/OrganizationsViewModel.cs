using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class OrganizationsViewModel
    {
        public List<Organization> OrganizationsList = new List<Organization>();

        [Required(ErrorMessage="Select from the list")]
        public int SelectedOrganizationID { get; set; }

        public SelectList OrganizationsIEnum
        {
            get
            {
                return new SelectList(OrganizationsList, "OrganizationID", "OrganizationName");
            }
        }
    }
}