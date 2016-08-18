﻿using DemoMisrInternationalLab.Models.EntityModel;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientRequestViewModel
    {
        public PatientRequestViewModel()
        {
            PatientInfo = new PatientInfoViewModel();
            MatchingPatients = new List<PatientRequest>();
            DoctorsRef = new DoctorsRefViewModel();
            Analyzes = new AnalyzesViewModel();
            RequestPriority = Resources.Priority.Low;
            Organizations = new OrganizationsViewModel();
        }
        public PatientInfoViewModel PatientInfo { get; set; }
        public List<PatientRequest> MatchingPatients { get; set; }

        public DoctorsRefViewModel DoctorsRef { get; set; }

        public AnalyzesViewModel Analyzes { get; set; }

        public OrganizationsViewModel Organizations { get; set; }

        public string RequestPriority { get; set; }
        public decimal ExtraDiscount { get; set; }
        public decimal ExtraCost { get; set; }
        public decimal PaidAmount { get; set; }
        public decimal TotalAfterCharges { get; set; }

        private decimal _Remain;
        public decimal Remain { get; set; }
        public decimal NewPaymentAmount { get; set; }
        public string AttachmentSession { get; set; }

        public int RequestId { get; set; }
        
    }
}