using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientRequestAnalysisViewModel
    {
        public PatientRequestAnalysisViewModel()
        {
            PatientRequestAnalyzes = new List<PatientRequestAnalysi>();
            SelectedRequestAnalyzesIDs = new List<int>();
        }
        public List<PatientRequestAnalysi> PatientRequestAnalyzes { get; set; }
        public List<int> SelectedRequestAnalyzesIDs { get; set; }
    }
}