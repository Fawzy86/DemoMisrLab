using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class CustomerCareViewModel
    {
        public CustomerCareViewModel()
        {
            IndividualPatientRequest = new PatientRequestViewModel();
            ContractPatientRequest = new PatientRequestViewModel();
            LabToLabPatientRequest = new PatientRequestViewModel();
            PatientsRequestStatus = new PatientsRequestsStatusViewModel();
        }
        public PatientRequestViewModel IndividualPatientRequest { get; set; }
        public PatientRequestViewModel ContractPatientRequest { get; set; }
        public PatientRequestViewModel LabToLabPatientRequest { get; set; }
        public PatientsRequestsStatusViewModel PatientsRequestStatus { get; set; }


    }
}