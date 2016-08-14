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
            Device = new EntityModel.Device();
            Unit = new EntityModel.Unit();
            Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus>();
        }
        public Device Device { get; set; }

        public Unit Unit { get; set; }
        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus> Analyzes { get; set; }
    }
}