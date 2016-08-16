using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class BarcodeViewModel
    {
        public string AnalysisCode { get; set; }
        public string PatientName { get; set; }
        public string RequestNumber { get; set; }
        public string RunNumber { get; set; }
        public string BarcodeImageData { get; set; }
        public string SampleType { get; set; }

    }
}