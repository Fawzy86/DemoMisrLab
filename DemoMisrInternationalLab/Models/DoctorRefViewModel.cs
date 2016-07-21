using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class DoctorRefViewModel
    {
        public DoctorRefViewModel()
        {
            DoctorsSpecializations = new DoctorsSpecializationsViewModel();
            Provinces = new ProvincesViewModel();
        }
        public int DoctorRefID { get; set; }

        [Required(ErrorMessage = "Doctor name is required")]
        
        public string DoctorName { get; set; }
        public Nullable<int> SpecialID { get; set; }
        public string Address { get; set; }
        public string Mobile { get; set; }
        public string Phone { get; set; }
        public DateTime InsertionDate { get; set; }
        public DoctorsSpecializationsViewModel DoctorsSpecializations { get; set; }

        public ProvincesViewModel Provinces { get; set; }

        public string SelectedCityID { get; set; }
    }
}