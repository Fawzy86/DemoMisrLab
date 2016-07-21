using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class Patient_Request_Status_Analysis_ViewModel
    {
        public Patient_Request_Status_Analysis_ViewModel()
        {
            PatientRequestStatus = new Patient_PatientRequest_LastStatus();
            PatientRequestAnalysis = new List<PatientRequest_Analysis>();
        }
        public Patient_PatientRequest_LastStatus PatientRequestStatus { get; set; }
        public List<PatientRequest_Analysis> PatientRequestAnalysis { get; set; }
        public string PatientFullName { get; set; }
        public string PriorityOrder { get; set; }
    }
}