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
    
    public partial class Analysis_Unit_Device_Sample
    {
        public int AnalysisID { get; set; }
        public string AnalysisCode { get; set; }
        public string AnalysisName { get; set; }
        public string NormalRange { get; set; }
        public decimal MinimumValue { get; set; }
        public decimal MaximumValue { get; set; }
        public decimal CostPrice { get; set; }
        public int DeviceId { get; set; }
        public string DeviceName { get; set; }
        public string DeviceDescription { get; set; }
        public bool IsDefalutUnitDevice { get; set; }
        public int SampleTypeID { get; set; }
        public string SampleType { get; set; }
        public int UnitId { get; set; }
        public string UnitName { get; set; }
        public string UnitDescription { get; set; }
    }
}
