using DemoMisrInternationalLab.Models.EntityModel;
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
            AnalysisResults = new List<RequestedAnalysisResult>();
        }
        List<PatientRequestAnalysis_AllStatuses> _PatientRequestAnalysisStatuses;
        public List<PatientRequestAnalysis_AllStatuses> PatientRequestAnalysisStatuses
        {
            get { return _PatientRequestAnalysisStatuses; }

            set
            {
                _PatientRequestAnalysisStatuses = value;
                SetStartDates();
            }
        }

        public PatientRequestAnalysis_AllStatuses PatientRequestAnalysisLastStatus { get; set; }


        public List<RequestedAnalysisResult> AnalysisResults { get; set; }


        
        public string StartSampledDate { get; set; }
        public string EndSampledDate { get; set; }

        public string StartTransferredDate { get; set; }
        public string EndTransferredDate { get; set; }

        public string StartPreservationDate { get; set; }
        public string EndPreservationDate { get; set; }

        public string StartLabbedDate { get; set; }
        public string EndLabbedDate { get; set; }
        private void SetStartDates()
        {
            if (_PatientRequestAnalysisStatuses != null && _PatientRequestAnalysisStatuses.Any())
            {
                var LabReceiveStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.ReceivedForAnalysising).FirstOrDefault();
                if (LabReceiveStatus != null)
                {
                    EndLabbedDate = LabReceiveStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                }

                var LabbedStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.PendingForAnalysising).FirstOrDefault();
                if (LabbedStatus != null)
                {
                    StartLabbedDate = LabbedStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                }

                var SampledStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.ReceivedForSampling).FirstOrDefault();
                if (SampledStatus != null)
                {
                    StartSampledDate = SampledStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    var NextStatus = _PatientRequestAnalysisStatuses.OrderBy(s => s.StatusDate).Where(s => s.StatusDate > SampledStatus.StatusDate).FirstOrDefault();
                    if (NextStatus != null)
                    {
                        EndSampledDate = NextStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    }
                    else
                    {
                        EndSampledDate = "Pending";
                    }
                }

                var TransferredStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.TransferredByChemist).FirstOrDefault();
                if (TransferredStatus != null)
                {
                    StartTransferredDate = TransferredStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    var NextStatus = _PatientRequestAnalysisStatuses.OrderBy(s => s.StatusDate).Where(s => s.StatusDate > TransferredStatus.StatusDate).FirstOrDefault();
                    if (NextStatus != null)
                    {
                        EndTransferredDate = NextStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    }
                    else
                    {
                        EndTransferredDate = "Pending";
                    }
                }

                var SavedStatus = _PatientRequestAnalysisStatuses.Where(s => s.StatusIdentifier == Resources.Status.SavedByChemist).FirstOrDefault();
                if (SavedStatus != null)
                {
                    StartPreservationDate = SavedStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    var NextStatus = _PatientRequestAnalysisStatuses.OrderBy(s => s.StatusDate).Where(s => s.StatusDate > SavedStatus.StatusDate).FirstOrDefault();
                    if (NextStatus != null)
                    {
                        EndPreservationDate = NextStatus.StatusDate.ToString("dd/MM/yyyy hh:mm tt");
                    }
                    else
                    {
                        EndPreservationDate = "Pending";
                    }
                }
                ///// set the pass values
                string DefaultPassValue = "Passed";
                if (StartPreservationDate == null)
                {
                    if (StartLabbedDate != null)
                    {
                        StartPreservationDate = DefaultPassValue;
                        EndPreservationDate = DefaultPassValue;
                    }
                }
                if (StartTransferredDate == null)
                {
                    if (StartPreservationDate != null)
                    {
                        StartTransferredDate = DefaultPassValue;
                        EndTransferredDate = DefaultPassValue;
                    }
                }
            }
        }

        
    }
}