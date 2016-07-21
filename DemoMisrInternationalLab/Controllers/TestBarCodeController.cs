using MessagingToolkit.QRCode.Codec;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
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
       
	}
}