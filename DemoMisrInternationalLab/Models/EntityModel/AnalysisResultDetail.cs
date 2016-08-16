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
    
    public partial class AnalysisResultDetail
    {
        public AnalysisResultDetail()
        {
            this.RequestedAnalysisResults = new HashSet<RequestedAnalysisResult>();
        }
    
        public int AnalysisDetailId { get; set; }
        public int AnalysisId { get; set; }
        public string ResultTitle { get; set; }
        public string Description { get; set; }
        public string UnitOfMeasure { get; set; }
        public string MinimumValue { get; set; }
        public string MaximumValue { get; set; }
        public string MaleNormalRange { get; set; }
        public string FemaleNormalRange { get; set; }
        public string DataType { get; set; }
        public string SectionTitle { get; set; }
    
        public virtual Analysis Analysis { get; set; }
        public virtual ICollection<RequestedAnalysisResult> RequestedAnalysisResults { get; set; }
    }
}