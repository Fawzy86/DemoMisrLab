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
    
    public partial class Status
    {
        public Status()
        {
            this.PatientRequestAnalysisStatus = new HashSet<PatientRequestAnalysisStatu>();
            this.PatientRequestStatus = new HashSet<PatientRequestStatu>();
        }
    
        public int StatusID { get; set; }
        public string StatusIdentifier { get; set; }
        public string StatusName { get; set; }
        public string Description { get; set; }
    
        public virtual ICollection<PatientRequestAnalysisStatu> PatientRequestAnalysisStatus { get; set; }
        public virtual ICollection<PatientRequestStatu> PatientRequestStatus { get; set; }
    }
}
