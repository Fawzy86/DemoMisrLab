//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DemoMisrInternationalLab.Models.EntityModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class DeviceAnalysi
    {
        public int DeviceAnalysisId { get; set; }
        public int RequestedAnalysisId { get; set; }
        public int DeviceId { get; set; }
        public int EmployeeId { get; set; }
        public System.DateTime ReceiveDate { get; set; }
        public Nullable<int> PlanId { get; set; }
    
        public virtual Device Device { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual PatientRequestAnalysi PatientRequestAnalysi { get; set; }
    }
}
