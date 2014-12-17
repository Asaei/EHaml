using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EHamlLibrary.DTOs
{

    
    public class InquiryListDTO
    {
        public int TedadePasokhha { get; set; }
        public int NazareKoliyeKhoob { get; set; }
        public int NazareKoliyeBad { get; set; }
        public long Id { get; set; }
        public bool Khatarnak { get; set; }
        public int Rank { get; set; }
        public int Power { get; set; }
        public string Status { get; set; }
        public string DisplayName { get; set; }
        public string InquiryType { get; set; }
        public string CreateDate { get; set; }
        public string ExpireDate { get; set; }
        public string IsTender { get; set; }
        public string StartingPoint { get; set; }
        public string Destination { get; set; }
        public string ActionDate { get; set; }
        public string IsReallyNeed { get; set; }
        public string LoadType { get; set; }
        public bool EmptyingCharges { get; set; }
        public string NoVaTedadeVasileyeHaml { get; set; }
        public bool WithInsurance { get; set; }
        public string FileArzesheBar { get; set; }
        public string VazneKol { get; set; }
        public string ReplyUrl { get; set; }
        public string JoziyatLink { get; set; }
        public string Company { get; set; }
        public int ReplyToInquiryId { get; set; }
        public string VaziyateNazarSanji { get; set; }
    }
}