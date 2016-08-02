using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class DeviceViewModel
    {
        public DeviceViewModel()
        {
            Device = new Device();
            Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device>();
        }
        public Device Device { get; set; }
        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device> Analyzes { get; set; }
    }
}