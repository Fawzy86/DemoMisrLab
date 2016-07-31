using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel
    {
        public Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel()
        {
            PatientRequestAnalysis = new Patient_PatientRequest_PatientRequestAnalysis_LastStatus();
            Devices = new List<Device>();
            DefaultDevice = new Device();
        }
        public Patient_PatientRequest_PatientRequestAnalysis_LastStatus PatientRequestAnalysis { get; set; }

        public Device DefaultDevice { get; set; }

        public List<Device> Devices { get; set; }

    }
}