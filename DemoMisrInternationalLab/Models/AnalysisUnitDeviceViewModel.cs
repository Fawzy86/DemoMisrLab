using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class AnalysisUnitDeviceViewModel
    {
        public AnalysisUnitDeviceViewModel()
        {
            Analysis = new Analysis();
            Unit = new Unit();
            Devices = new List<Device>();
        }
        public Analysis Analysis { get; set; }

        public Unit Unit { get; set; }

        public List<Device> Devices { get; set; }
    }
}