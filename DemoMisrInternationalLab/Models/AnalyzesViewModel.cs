using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMisrInternationalLab.Models
{
    public class AnalyzesViewModel
    {
        public List<AnalysisViewModel> AnalyzesList = new List<AnalysisViewModel>();

        public List<Int32> SelectedAnalyzesIDs { get; set; }

        public MultiSelectList AnalyzesIEnum
        {
            get
            {
                return new MultiSelectList(AnalyzesList, "Analysis.AnalysisID", "AnalysisDisplayName");
            }
        }
    }
}