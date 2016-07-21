using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace DemoMisrInternationalLab.Models
{
    public class DoctorsSpecializationsViewModel
    {
        public List<DoctorSpecialization> DoctorsSpecializationsList = new List<DoctorSpecialization>();
        [Required(ErrorMessage = "Please select doctor specialization")]
        public Int32 SelectedDoctorSpecializationID { get; set; }

        public IEnumerable<SelectListItem> DoctorsSpecializationsIEnum
        {
            get
            {
                return new SelectList(DoctorsSpecializationsList, "SpecialID", "SpecialName");
            }
        }
    }
}