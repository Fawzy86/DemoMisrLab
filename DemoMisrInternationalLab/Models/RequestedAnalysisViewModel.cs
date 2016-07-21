using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class RequestedAnalysisViewModel
    {
        public Analysis RequestedAnalysis { get; set; }
        public decimal Rate { get; set; }
        public decimal Disc { get; set; }
        public decimal Extra { get; set; }
        public decimal SubTotal { get; set; }
    }
}