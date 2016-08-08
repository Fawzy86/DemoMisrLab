using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class PlansViewModel
    {
        public List<DevicePlan> PlansList = new List<DevicePlan>();

        public int? SelectedPlanId { get; set; }

        public IEnumerable<SelectListItem> PlansIEnum
        {
            get
            {
                return new SelectList(PlansList, "PlanId", "PlanNumber");
            }
        }
    }
}