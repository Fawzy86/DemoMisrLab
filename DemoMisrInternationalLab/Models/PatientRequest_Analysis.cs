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
    
    public partial class PatientRequest_Analysis
    {
        public System.DateTime RequestDate { get; set; }
        public int PatientID { get; set; }
        public int EmployeeID { get; set; }
        public string Comment { get; set; }
        public Nullable<int> DoctorRefID { get; set; }
        public string Priority { get; set; }
        public Nullable<int> OrganizationID { get; set; }
        public string RequestedRefID { get; set; }
        public string AttachmentSession { get; set; }
        public int RequestedAnalysisID { get; set; }
        public int RequestID { get; set; }
        public int AnalysisID { get; set; }
        public System.DateTime AnalysisRequestDate { get; set; }
        public int RequestAnalysisEmployeeID { get; set; }
        public string RunNumber { get; set; }
        public string AnalysisCode { get; set; }
        public string AnalysisName { get; set; }
        public string NormalRange { get; set; }
        public int SampleTypeID { get; set; }
        public decimal MinimumValue { get; set; }
        public decimal MaximumValue { get; set; }
        public decimal CostPrice { get; set; }
        public Nullable<decimal> ExtraDiscount { get; set; }
        public Nullable<decimal> ExtraCost { get; set; }
        public Nullable<decimal> TotalPatientCost { get; set; }
        public Nullable<decimal> TotalOrganizationCost { get; set; }
        public string RequestNumber { get; set; }
        public string SampleType { get; set; }
    }
}
