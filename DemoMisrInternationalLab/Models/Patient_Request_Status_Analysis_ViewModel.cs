using DemoMisrInternationalLab.Models.EntityModel;
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
            PatientRequestAnalyzesWithStatuses = new List<PatientRequest_Analysis_Status_ViewModel>();
            PatientRequestPayments = new List<PatientRequest_Payment>();
            PatientRequestAllStatuses = new List<Patient_PatientRequest_AllStatuses>();
        }
        public Patient_PatientRequest_LastStatus PatientRequestStatus { get; set; }
        public List<Patient_PatientRequest_AllStatuses> PatientRequestAllStatuses { get; set; }
        public List<PatientRequest_Analysis> PatientRequestAnalysis { get; set; }
        public List<PatientRequest_Analysis_Status_ViewModel> PatientRequestAnalyzesWithStatuses { get; set; }
        public List<PatientRequest_Payment> PatientRequestPayments { get; set; }
        public string PatientFullName { get; set; }
        public string PriorityOrder { get; set; }
        public decimal Paid { get; set; }
        public decimal TotalDue { get; set; }

    }
}