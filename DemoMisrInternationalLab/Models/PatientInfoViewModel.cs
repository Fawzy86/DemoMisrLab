using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientInfoViewModel
    {
        public PatientInfoViewModel()
        {
            Provinces = new ProvincesViewModel();
        }
        public int PatientID { get; set; }
        [Required]
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        [Required]
        public string LastName { get; set; }

        [Required]
        public string Gender { get; set; }
        public string Address { get; set; }
        public ProvincesViewModel Provinces { get; set; }
        public string SelectedCityID { get; set; }
        public string NationalID { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> BirthDate { get; set; }

        [Required]
        [Range(0, 120, ErrorMessage = "Age must be between 0 and 120")]
        public string Age { get; set; }
        public string BirthMonth { get; set; }
        public string BirthYear { get; set; }
        public string Phone { get; set; }

        public string Mobile { get; set; }

        public string Email { get; set; }
        public int OrganizationID { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public System.DateTime RegisteredDate { get; set; }
        public int? ReferenceID { get; set; }
    }
}