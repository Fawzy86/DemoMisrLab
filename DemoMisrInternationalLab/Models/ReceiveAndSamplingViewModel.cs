using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class ReceiveAndSamplingViewModel
    {
        public PatientsRequestsStatusViewModel PendingPatientRequest { get; set; }

        public PatientRequestAnalysisViewModel PendingRequestAnalyzes { get; set; }

        public List<PatientRequestAnalysi> SampledRequestAnalyzes { get; set; }
    }
}