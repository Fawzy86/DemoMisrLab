using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class DoctorsRefViewModel
    {
        public List<DoctorRef> DoctorsRefList = new List<DoctorRef>();
        public int? SelectedDoctorRefID { get; set; }

        public IEnumerable<SelectListItem> DoctorsRefIEnum
        {
            get
            {
                return new SelectList(DoctorsRefList, "DoctorRefID", "DoctorName");
            }
        }
    }
}