using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PlanViewModel
    {
        public PlanViewModel()
        {
            Plan = new Plan_Device_Unit();
            Analyzes = new List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device>();
        }
        public Plan_Device_Unit Plan { get; set; }
        public List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device> Analyzes { get; set; }
    }
}