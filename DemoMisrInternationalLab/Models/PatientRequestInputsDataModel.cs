using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientRequestInputsDataModel
    {
        public PatientRequestInputsDataModel()
        {
            AnalyzesIDs = new List<int>();
        }
        public int RequestId { get; set; }
        public int? OrganizationID { get; set; }
        public int PatientID { get; set; }
        public int? DoctorRefID { get; set; }
        public List<int> AnalyzesIDs { get; set; }
        public string Comment { get; set; }
        public string Priority { get; set; }
        public decimal ExtraDiscount { get; set; }
        public decimal ExtraCost { get; set; }
        public decimal PaidAmount { get; set; }
        public decimal TotalOrganizationCost { get; set; }
        public decimal TotalPatientCost { get; set; }
        public string AttachmentSession { get; set; }
    }
}