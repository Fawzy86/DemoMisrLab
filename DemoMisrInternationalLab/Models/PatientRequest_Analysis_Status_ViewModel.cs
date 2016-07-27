using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMisrInternationalLab.Models
{
    public class PatientRequest_Analysis_Status_ViewModel
    {
        public PatientRequest_Analysis_Status_ViewModel()
        {
            PatientRequestAnalysisStatuses = new List<PatientRequestAnalysis_AllStatuses>();
            PatientRequestAnalysisLastStatus = new PatientRequestAnalysis_AllStatuses();
        }
        List<PatientRequestAnalysis_AllStatuses> _PatientRequestAnalysisStatuses;
        public List<PatientRequestAnalysis_AllStatuses> PatientRequestAnalysisStatuses
        {
            get { return _PatientRequestAnalysisStatuses; }

            set
            {
                _PatientRequestAnalysisStatuses = value;
                SetTheDates();
            }
        }

        public PatientRequestAnalysis_AllStatuses PatientRequestAnalysisLastStatus { get; set; }

        public DateTime? SampledDate { get; set; }
        public DateTime? TransferredDate { get; set; }
        public DateTime? PreservationDate { get; set; }
        public DateTime? LabbedDate { get; set; }

        private void SetTheDates()
        {
            if (_PatientRequestAnalysisStatuses != null && _PatientRequestAnalysisStatuses.Any())
            {
                var LabbedStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.AnalysisMovedToLab).FirstOrDefault();
                if (LabbedStatus != null)
                {
                    LabbedDate = LabbedStatus.StatusDate;
                }

                var SampledStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.AnalysisSampled).FirstOrDefault();
                if (SampledStatus != null)
                {
                    SampledDate = SampledStatus.StatusDate;
                }

                var TransferredStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.AnalysisTransferred).FirstOrDefault();
                if (TransferredStatus != null)
                {
                    TransferredDate = TransferredStatus.StatusDate;
                }

                var SavedStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.AnalysisSaved).FirstOrDefault();
                if (SavedStatus != null)
                {
                    PreservationDate = SavedStatus.StatusDate;
                }
            }

        }
        
    }
}