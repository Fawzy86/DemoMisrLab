using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class AnalysisViewModel
    {
        public AnalysisViewModel()
        {
            Analysis = new Analysis();
        }
        public Analysis Analysis { get; set; }
        public string AnalysisDisplayName { get; set; }
    }
}