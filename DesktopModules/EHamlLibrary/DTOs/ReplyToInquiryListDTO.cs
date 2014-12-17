using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EHamlLibrary.DTOs
{
    public class ReplyToInquiryListDTO
    {
        public long? InquiryId { get; set; }
        public long ReplyToInquiryId { get; set; }
        public string DisplayName { get; set; }
        public string StatusPerson { get; set; }
        public string GeymateKol { get; set; }
        public string ZamaneAmadegiBarayeShooroo { get; set; }
        public string Status { get; set; }
        public string CreateDate { get; set; }
        public string ModateAnjameAmaliyat { get; set; }
        public string Pishbini { get; set; }
        public int Power { get; set; }
        public int Rank { get; set; }
        public int NazareKoliKhoob { get; set; }
        public int NazareKoliBad { get; set; }
        public string VaziyatePaziresh { get; set; }
        public string NameKhedmatresan { get; set; }
        public string NameSahebBar { get; set; }
        public string NazarSanji { get; set; }
        public string InquiryType { get; set; }
        public int? SahebBarId { get; set; }
        public int? ServantId { get; set; }
        public string JoziyatLink { get; set; }
        public string SahebBarStatus { get; set; }
        public string ExpireDate { get; set; }
        public string StartingPoint { get; set; }
        public string Destination { get; set; }
        public string ActionDate { get; set; }
        public string IsReallyNeed { get; set; }
        public string LoadType { get; set; }
        public bool EmptyingCharges { get; set; }
        public string NoVaTedadeVasileyeHaml { get; set; }
        public string FileArzesheBar { get; set; }
        public string Company { get; set; }
        public string ModateAnjam { get; set; }
        public int TedadePasokhHa { get; set; }
        public string ReplyToInquiryCreateDate { get; set; }
    }
}