using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientRequest_Analyzes_History_ViewModel
    {
        public PatientRequest_Analyzes_History_ViewModel()
        {
            CurrentRequestAnalyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
            HistoryRequestAnalyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
        }
        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> CurrentRequestAnalyzes { get; set; }
        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> HistoryRequestAnalyzes { get; set; }

    }
}