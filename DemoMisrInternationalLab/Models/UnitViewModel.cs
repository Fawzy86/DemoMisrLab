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
        }
        public Unit Unit { get; set; }
        public List<DeviceViewModel> Devices { get; set; }
    }
}