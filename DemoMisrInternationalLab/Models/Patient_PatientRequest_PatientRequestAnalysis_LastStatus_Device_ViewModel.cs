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
        }
        public Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device Analysis { get; set; }
    }
}