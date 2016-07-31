using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class ProvincesViewModel
    {
        public List<Province> ProvincesList = new List<Province>();

        public int? SelectedProvinceID { get; set; }

        public IEnumerable<SelectListItem> ProvincesIEnum
        {
            get
            {
                return new SelectList(ProvincesList, "ProvinceID", "ProvinceName");
            }
        }
    }
}