using DemoMisrInternationalLab.Models;
using DemoMisrInternationalLab.Security;
using DemoMisrInternationalLab.Utilities;
using MessagingToolkit.QRCode.Codec;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    [AuthorizeRoles("Chemist")]
    public class ChemistController : Controller
    {
        //
        // GET: /ReceiveAndSample/
        public ActionResult Index()
        {
            return View();
        }

        #region Receive & Sample
        public ActionResult GetPendingPatientRequest()
        {
            PatientsRequestsAllViewModel PendingPatientRequest = new PatientsRequestsAllViewModel();
            PendingPatientRequest.PatientRequestStatusWithAnalyzes =  DbFunctions.GetPatientsRequestWithStatus(Resources.Status.PendingForSampling);
            return PartialView("_ReceivePatientRequest", PendingPatientRequest);
        }

        public ActionResult GetPendingRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel PendingRequestAnalyzes = new PatientRequestAnalysisViewModel();
            PendingRequestAnalyzes.PatientRequestAnalyzes =  DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.PendingForSampling);
            return PartialView("_PendingAnalyzesForSampling", PendingRequestAnalyzes);
        }

        public ActionResult GetSampledRequestAnalyzesAfterReceive()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes =  DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.ReceivedForSampling);
            return PartialView("_SampledAnalyzesAfterReceive", SampledRequestAnalyzes);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ReceiveSelectedPatientsRequest(FormCollection form, PatientsRequestsAllViewModel model)
        {
            if (model.SelectedPatientsRequestIDs != null && model.SelectedPatientsRequestIDs.Any())
            {
                 DbFunctions.ReceivePatientRequest(model.SelectedPatientsRequestIDs, HttpContext.User.Identity.Name);
                return   GetPendingPatientRequest();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SampleSelectedRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {
            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {
                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.ReceivedForSampling, HttpContext.User.Identity.Name);
                //return RedirectToAction("GetBarcodesToPrint", new { RequestedAnalyzesIds = String.Join(",", model.SelectedRequestAnalyzesIDs) });
                return GetBarcodesToPrint(String.Join(",", model.SelectedRequestAnalyzesIDs));
            }
            else
            {
                return null;
            }
        }

        public ActionResult GetBarcodesToPrint(string RequestedAnalyzesIds)
        {
            if (!String.IsNullOrWhiteSpace(RequestedAnalyzesIds))
            {
                var RequestedAnalyzesIdsList = RequestedAnalyzesIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(r => Convert.ToInt32(r)).ToList();
                List<Patient_PatientRequest_PatientRequestAnalysis_LastStatus_ViewModel> RequestedAnalyzes = DbFunctions.GetAnalyzesDetails(RequestedAnalyzesIdsList);
                if (RequestedAnalyzes != null && RequestedAnalyzes.Any())
                {
                    QRCodeEncoder Encoder = null;
                    StringBuilder BarcodeData = null;
                    List<BarcodeViewModel> BarcodesList = new List<BarcodeViewModel>();
                    foreach (var analyzes in RequestedAnalyzes)
                    {
                        Encoder = new QRCodeEncoder();
                        BarcodeData = new StringBuilder();
                        string PatientName = analyzes.PatientRequestAnalysis.FirstName + " " + analyzes.PatientRequestAnalysis.MiddleName + " " + analyzes.PatientRequestAnalysis.LastName;
                        BarcodeData.Append(PatientName + Environment.NewLine);
                        string Age = analyzes.PatientRequestAnalysis.BirthDate != null ? (DateTime.Now.Year - Convert.ToDateTime(analyzes.PatientRequestAnalysis.BirthDate).Year).ToString() : String.Empty;
                        BarcodeData.Append(analyzes.PatientRequestAnalysis.Gender + Environment.NewLine);
                        BarcodeData.Append(Age + Environment.NewLine);
                        BarcodeData.Append(analyzes.PatientRequestAnalysis.AnalysisCode + Environment.NewLine);
                        BarcodeData.Append(analyzes.PatientRequestAnalysis.RequestNumber + " : " + analyzes.PatientRequestAnalysis.RunNumber + Environment.NewLine);
                        BarcodeData.Append(analyzes.PatientRequestAnalysis.SampleType);
                        var Img = Encoder.Encode(BarcodeData.ToString());
                        using (MemoryStream Stream = new MemoryStream())
                        {
                            Img = new System.Drawing.Bitmap(Img, new System.Drawing.Size(75, 75));
                            Img.Save(Stream, System.Drawing.Imaging.ImageFormat.Png);
                            Stream.Close();
                            byte[] ImageByteArray = Stream.ToArray();
                            string ImageBase64Data = Convert.ToBase64String(ImageByteArray);
                            string ImageDataURL = string.Format("data:image/png;base64,{0}", ImageBase64Data);
                            BarcodesList.Add(new BarcodeViewModel()
                            {
                                BarcodeImageData = ImageDataURL,
                                AnalysisCode = analyzes.PatientRequestAnalysis.AnalysisCode,
                                PatientName = PatientName,
                                RequestNumber = analyzes.PatientRequestAnalysis.RequestNumber,
                                RunNumber = analyzes.PatientRequestAnalysis.RunNumber,
                                SampleType = analyzes.PatientRequestAnalysis.SampleType
                            });
                        }
                    }
                    return PartialView("_BarcodePrintPreview", BarcodesList);
                }
            }
            return null;
        }
        #endregion

        /// Preservation Actions//////////////////////////////////////////////////////////////////////////////////////////////

        #region Preservation
        public ActionResult GetSampledRequestAnalyzesForPreservation()
        {
            PatientRequestAnalysisViewModel SampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.ReceivedForSampling);
            return PartialView("_SampledAnalyzesForPreservation", SampledRequestAnalyzes);
        }

        public ActionResult GetSavedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel SavedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            SavedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.SavedByChemist);
            return PartialView("_SaveSamples", SavedSampledRequestAnalyzes);
        }

        public ActionResult GetTransferredSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel TransferredSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            TransferredSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.TransferredByChemist);
            return PartialView("_TransferredSamples", TransferredSampledRequestAnalyzes);
        }

        public ActionResult GetLabbedSampledRequestAnalyzes()
        {
            PatientRequestAnalysisViewModel LabbedSampledRequestAnalyzes = new PatientRequestAnalysisViewModel();
            LabbedSampledRequestAnalyzes.PatientRequestAnalyzes = DbFunctions.GetRequestAnalyzesWithStatus(Resources.Status.PendingForAnalysising);
            return PartialView("_SampledAnalyzesAfterReceive", LabbedSampledRequestAnalyzes);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.SavedByChemist, HttpContext.User.Identity.Name);
                return  GetSavedSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult TransferredSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.TransferredByChemist, HttpContext.User.Identity.Name);
                return  GetTransferredSampledRequestAnalyzes();
            }
            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MoveToLabSelectedSampledRequestAnalyzes(FormCollection form, PatientRequestAnalysisViewModel model)//, PatientRequestAnalysisViewModel model)
        {

            if (model.SelectedRequestAnalyzesIDs != null && model.SelectedRequestAnalyzesIDs.Any())
            {

                DbFunctions.UpdateRequestedAnalyzesStatus(model.SelectedRequestAnalyzesIDs, Resources.Status.PendingForAnalysising, HttpContext.User.Identity.Name);
                return  GetLabbedSampledRequestAnalyzes();
            }
            return null;
        }
        #endregion

        /////////////////////////////////////////////////////////////////////////////////

        #region Transactions
        public ActionResult LoadTransactions(string SearchPattern, string DateRange)
        {
            PatientsRequestsAllViewModel PatientRequestStatus = new PatientsRequestsAllViewModel();
            DateTime DateFrom = DateTime.Now.Date;
            DateTime DateTo = DateTime.Now.AddDays(1).Date;
            if (!String.IsNullOrWhiteSpace(DateRange))
            {
                string[] DateRangeArray = DateRange.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                DateTime.TryParse(DateRangeArray[0], out DateFrom);
                if (DateRangeArray.Length > 1)
                {
                    if (DateTime.TryParse(DateRangeArray[1], out DateTo))
                    {
                        DateTo = DateTo.AddDays(1).Date;
                    }
                }
            }
            PatientRequestStatus.PatientRequestStatusWithAnalyzes = DbFunctions.GetPatientsRequestTransactionsForChemist(SearchPattern, DateFrom, DateTo);
            return PartialView("_Transaction", PatientRequestStatus);
        }
        #endregion
    }
}