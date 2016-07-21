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
    
    public partial class Analysis
    {
        public Analysis()
        {
            this.PackageCostLists = new HashSet<PackageCostList>();
            this.PatientRequestAnalysis = new HashSet<PatientRequestAnalysi>();
        }
    
        public int AnalysisID { get; set; }
        public string AnalysisCode { get; set; }
        public string AnalysisName { get; set; }
        public string NormalRange { get; set; }
        public int SampleTypeID { get; set; }
        public decimal MinimumValue { get; set; }
        public decimal MaximumValue { get; set; }
        public decimal CostPrice { get; set; }
    
        public virtual SampleType SampleType { get; set; }
        public virtual ICollection<PackageCostList> PackageCostLists { get; set; }
        public virtual ICollection<PatientRequestAnalysi> PatientRequestAnalysis { get; set; }
    }
}