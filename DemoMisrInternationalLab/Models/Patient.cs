//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DemoMisrInternationalLab.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Patient
    {
        public Patient()
        {
            this.PatientRequests = new HashSet<PatientRequest>();
        }
    
        public int PatientID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public string Address { get; set; }
        public Nullable<int> CityID { get; set; }
        public string NationalID { get; set; }
        public Nullable<System.DateTime> BirthDate { get; set; }
        public string Mobile { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public int EmployeeID { get; set; }
        public int ReferenceID { get; set; }
        public System.DateTime RegisteredDate { get; set; }
        public Nullable<System.DateTime> LastDataModified { get; set; }
    
        public virtual City City { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual ICollection<PatientRequest> PatientRequests { get; set; }
    }
}
