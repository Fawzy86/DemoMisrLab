using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class UnitsViewModel
    {
        public List<Unit> UnitsList = new List<Unit>();

        public int? SelectedUnitId { get; set; }

        public IEnumerable<SelectListItem> UnitsIEnum
        {
            get
            {
                return new SelectList(UnitsList, "UnitId", "UnitName");
            }
        }
    }
}