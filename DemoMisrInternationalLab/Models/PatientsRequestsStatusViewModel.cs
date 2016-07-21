using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientsRequestsStatusViewModel
    {
        public PatientsRequestsStatusViewModel()
        {
            PatientRequestStatusWithAnalyzes = new List<Patient_Request_Status_Analysis_ViewModel>();
        }
        public List<Patient_Request_Status_Analysis_ViewModel> PatientRequestStatusWithAnalyzes { get; set; }
    }
}