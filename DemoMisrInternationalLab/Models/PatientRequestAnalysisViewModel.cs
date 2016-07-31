using DemoMisrInternationalLab.Models.EntityModel;
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
            PatientRequestAnalyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel>();
            SelectedRequestAnalyzesIDs = new List<int>();
        }

        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel> PatientRequestAnalyzes { get; set; }
        public List<int> SelectedRequestAnalyzesIDs { get; set; }
    }
}