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
            PatientRequestAnalyzes = new List<PatientRequest_PatientRequestAnalysis_LastStatus>();
            SelectedRequestAnalyzesIDs = new List<int>();
        }

        public List<PatientRequest_PatientRequestAnalysis_LastStatus> PatientRequestAnalyzes { get; set; }
        public List<int> SelectedRequestAnalyzesIDs { get; set; }
    }
}