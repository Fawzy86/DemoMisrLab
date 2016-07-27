using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientsRequestsAllViewModel
    {
        public PatientsRequestsAllViewModel()
        {
            PatientRequestStatusWithAnalyzes = new List<Patient_Request_Status_Analysis_ViewModel>();
            SelectedPatientsRequestIDs = new List<int>();
        }
        public List<Patient_Request_Status_Analysis_ViewModel> PatientRequestStatusWithAnalyzes { get; set; }

        public List<int> SelectedPatientsRequestIDs { get; set; }
    }
}