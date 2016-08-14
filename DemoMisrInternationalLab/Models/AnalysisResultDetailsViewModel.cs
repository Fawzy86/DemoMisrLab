using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class AnalysisResultDetailsViewModel
    {
        public AnalysisResultDetailsViewModel()
        {
            ResultDetails = new EntityModel.AnalysisResultDetail();
        }
        public EntityModel.AnalysisResultDetail ResultDetails { get; set; }
        public string ResultValue { get; set; }
    }
}