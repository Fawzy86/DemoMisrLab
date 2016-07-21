using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class RequestedAnalyzesViewModel
    {
        public RequestedAnalyzesViewModel()
        {
            RequestedAnalyzes = new List<RequestedAnalysisViewModel>();
        }

        public List<RequestedAnalysisViewModel> RequestedAnalyzes { get; set; }
        public decimal TotalCost { get; set; }
        public decimal Paid { get; set; }
        public decimal Remain { get; set; }
    }
}