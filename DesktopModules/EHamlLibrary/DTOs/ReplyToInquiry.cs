using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EHamlLibrary.DTOs
{
    public class ReplyToInquiry
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
        public string NazarSanji { get; set; }
        public string InquiryType { get; set; }
    }
}