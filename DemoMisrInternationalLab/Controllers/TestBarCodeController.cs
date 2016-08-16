using DemoMisrInternationalLab.Models;
using MessagingToolkit.QRCode.Codec;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Controllers
{
    public class TestBarCodeController : Controller
    {
        //
        // GET: /TestBarCode/
        public ActionResult Index()
        {
            
            return View();
        }
        public void GetBarcodeImage(string valueToEncode)
        {
            //Create an instance of BarcodeProfessional class
           /* using (Neodynamic.Web.MVC.Barcode.BarcodeProfessional bcp = new
                            Neodynamic.Web.MVC.Barcode.BarcodeProfessional())
            {
                
                //Set the desired barcode type or symbology
                bcp.Symbology = Neodynamic.Web.MVC.Barcode.Symbology.QRCode;
                //Set value to encode
                bcp.Code = valueToEncode;
                //Generate barcode image
                byte[] imgBuffer = bcp.GetBarcodeImage(
                             System.Drawing.Imaging.ImageFormat.Png);
                //Write image buffer to Response obj
                System.Web.HttpContext.Current.Response.ContentType = "image/png";
                System.Web.HttpContext.Current.Response.BinaryWrite(imgBuffer);
            }*/
            QRCodeEncoder Encoder = new QRCodeEncoder();
            var Img = Encoder.Encode(valueToEncode);
            using (MemoryStream  Stream = new MemoryStream())
            {
                Img.Save(Stream, System.Drawing.Imaging.ImageFormat.Png);
                Stream.Close();
                byte[] ImageByteArray = Stream.ToArray();
                //Write image buffer to Response obj
                System.Web.HttpContext.Current.Response.ContentType = "image/png";
                System.Web.HttpContext.Current.Response.BinaryWrite(ImageByteArray);
            }
        }

        public ActionResult GetBarcodesToPrintss()
        {
            QRCodeEncoder Encoder = new QRCodeEncoder();
            var Img = Encoder.Encode("Name: Amr Adel\nAge: 30\nAddress: El maadi\ndate: 2016-07-03\nCost: 500");
            using (MemoryStream Stream = new MemoryStream())
            {
                Img = new System.Drawing.Bitmap(Img, new System.Drawing.Size(20, 20));
                Img.Save(Stream, System.Drawing.Imaging.ImageFormat.Png);
                Stream.Close();
                byte[] ImageByteArray = Stream.ToArray();
                string imageBase64Data = Convert.ToBase64String(ImageByteArray);
                string imageDataURL = string.Format("data:image/png;base64,{0}", imageBase64Data);
                BarcodeViewModel barcodeData = new BarcodeViewModel()
                {
                    BarcodeImageData = imageDataURL,
                    PatientName = "Ahmed",
                    RequestNumber = "AA-102",
                    RunNumber = "1"
                };
                List<BarcodeViewModel> ImagesScr = Enumerable.Repeat(barcodeData, 5).ToList();
                return PartialView("_BarcodePrintPreview", ImagesScr);
              //  ViewBag.ImagesData = ImagesScr;
                //Write image buffer to Response obj
                //System.Web.HttpContext.Current.Response.ContentType = "image/png";
                //System.Web.HttpContext.Current.Response.BinaryWrite(ImageByteArray);
            }
        }

        public ActionResult GetBarcodesToPrint()
        {
            QRCodeEncoder Encoder = null;
            StringBuilder BarcodeData = null;
            List<BarcodeViewModel> BarcodesList = new List<BarcodeViewModel>();

            Encoder = new QRCodeEncoder();
            BarcodeData = new StringBuilder();
            string PatientName = "ahmed " + " Mohamed " + " fw";
            BarcodeData.Append(PatientName + Environment.NewLine);
            BarcodeData.Append("CCCCCode fo analyssi" + Environment.NewLine);
            BarcodeData.Append("QQ-123" + " : " + "123" + Environment.NewLine);
            BarcodeData.Append("Blood");
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
                    AnalysisCode = "a",
                    PatientName = PatientName,
                    RequestNumber = "B",
                    RunNumber = "C",
                    SampleType = "blood"
                });
            }

            return PartialView("_BarcodePrintPreview", BarcodesList);
        }
	}
}