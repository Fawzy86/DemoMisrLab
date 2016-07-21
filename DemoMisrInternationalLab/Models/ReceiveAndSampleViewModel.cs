using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class ReceiveAndSampleViewModel
    {
        public ReceiveAndSampleViewModel()
        {
            PendingPatientsRequests = new List<Patient_Request_Status_Analysis_ViewModel>();
            PendingAnalyzesForSampling = new List<PatientRequestAnalysi>();
            SampledAnalyzes = new List<PatientRequestAnalysi>();
        }
        public List<Patient_Request_Status_Analysis_ViewModel> PendingPatientsRequests { get; set; }
        public int[] SelectedPatientsRequestIDs { get; set; }
        public List<PatientRequestAnalysi> PendingAnalyzesForSampling { get; set; }
        public List<PatientRequestAnalysi> SampledAnalyzes { get; set; }
        public int[] SelectedAnalyzesIDs { get; set; }
    }
}