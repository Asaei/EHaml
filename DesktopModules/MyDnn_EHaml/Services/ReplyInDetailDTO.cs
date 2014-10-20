using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DotNetNuke.Entities.Users;

namespace MyDnn_EHaml.Services
{
    internal class ReplyInDetailDTO
    {
        public int Id { get; set; }
        public int SahebId { get; set; }
        public string SahebDisplayName { get; set; }

        public int Status { get; set; }

        public string ReadyToAction { get; set; }

        public string ModatZamaneAnjam { get; set; }

        public decimal? GeymateKol { get; set; }

        public string Pishbibni { get; set; }
        public string CreateDate { get; set; }

        public int IRTI { get; set; }
    }
}