using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class UnitViewModel
    {
        public UnitViewModel()
        {
            Unit = new Unit();
            Devices = new List<DeviceViewModel>();
            ReceivedAnalyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel>();
        }
        public Unit Unit { get; set; }
        public List<DeviceViewModel> Devices { get; set; }

        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel> ReceivedAnalyzes { get; set; }
    }
}