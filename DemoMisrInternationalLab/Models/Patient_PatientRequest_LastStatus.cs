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
    
    public partial class Patient_PatientRequest_LastStatus
    {
        public System.DateTime RequestDate { get; set; }
        public int PatientRequestEmployeeID { get; set; }
        public string PatientRequestComment { get; set; }
        public Nullable<int> DoctorRefID { get; set; }
        public string Priority { get; set; }
        public Nullable<int> OrganizationID { get; set; }
        public string RequestedRefID { get; set; }
        public string AttachmentSession { get; set; }
        public int RequestStatusID { get; set; }
        public int RequestID { get; set; }
        public System.DateTime StatusDate { get; set; }
        public int PatientRequestStatusEmployeeID { get; set; }
        public string PatientRequestStatusComment { get; set; }
        public string StatusIdentifier { get; set; }
        public string StatusName { get; set; }
        public string Description { get; set; }
        public int PatientRequestStatusID { get; set; }
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
        public int ReferenceID { get; set; }
        public System.DateTime RegisteredDate { get; set; }
        public Nullable<System.DateTime> LastDataModified { get; set; }
        public Nullable<decimal> ExtraDiscount { get; set; }
        public Nullable<decimal> ExtraCost { get; set; }
        public Nullable<decimal> TotalPatientCost { get; set; }
        public Nullable<decimal> TotalOrganizationCost { get; set; }
    }
}
