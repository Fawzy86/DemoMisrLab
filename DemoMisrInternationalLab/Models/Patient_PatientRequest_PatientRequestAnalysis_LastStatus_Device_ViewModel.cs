using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel
    {
        public Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel()
        {
            Analysis = new Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device();
            AnalysisResults = new List<AnalysisResult_Details>();
            AnalysisResultsDetails = new List<AnalysisResultDetailsViewModel>();
            RelatedAnalyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel>();
        }
        public Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device Analysis { get; set; }

        public List<AnalysisResult_Details> AnalysisResults { get; set; }

        public List<AnalysisResultDetailsViewModel> AnalysisResultsDetails { get; set; }

        public bool IsEditable { get; set; }

        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device_ViewModel> RelatedAnalyzes { get; set; }



    }
}