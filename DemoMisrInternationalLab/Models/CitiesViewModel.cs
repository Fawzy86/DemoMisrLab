using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class CitiesViewModel
    {
        public List<City> CitiesList = new List<City>();

        public int? SelectedCityID { get; set; }

        public IEnumerable<SelectListItem> CitiesIEnum
        {
            get
            {
                return new SelectList(CitiesList, "CityID", "CityName");
            }
        }
    }
}