using System.Linq;

namespace EHamlLibrary.Utility
{
    public class Utility
    {
        public int GetTedadePasohkhaForInquiry(long inquiryId, EHamlDataClassesDataContext context)
        {
            int result = 0;

            result = (from i in context.Asaei_EHaml_ReplyToInquiries
                where i.InquiryId == inquiryId
                select i).Count();

            return result;
        }

        public int GetTedadeNazareKoliyeKhoobForSahebBar(int userId, EHamlDataClassesDataContext context)
        {
            return 20;
        }

        public int GetTedadeNazareKoliyeBadForSahebBar(int currentUserId, EHamlDataClassesDataContext context)
        {
            return 10;
        }

        public string GetTedadeVasileyeHamleMoredeNiyaz(long id, EHamlDataClassesDataContext context)
        {
            string result = string.Empty;
            var vasileyeHamleMoredeNiyaz = (from i in context.Asaei_EHaml_NoVaTedadeVasileyeMoredeNiyazs
                where i.InquiryID == id
                select i).ToList();

            if (vasileyeHamleMoredeNiyaz.Count > 0)
            {
                foreach (var item in vasileyeHamleMoredeNiyaz)
                {
                    result += string.Format("{0} ({1} دستگاه)", item.VasileName, item.Tedad);
                }
            }

            return result;
        }

        public string GetNoVaTedadeVasileyeHamlForInquiry(long id, EHamlDataClassesDataContext context)
        {
            string result = string.Empty;

            var noVaTedadeVasileyeHamlList = from i in context.Asaei_EHaml_Inquiries
                join j in context.Asaei_EHaml_NoVaTedadeVasileyeMoredeNiyazs
                    on i.Id equals j.InquiryID
                select new
                {
                    NoeVasileyeHaml = j.VasileName,
                    TedadeVasileyeHaml = j.Tedad
                };

            foreach (var item in noVaTedadeVasileyeHamlList)
            {
                result += item.NoeVasileyeHaml + "(دستگاه " + item.TedadeVasileyeHaml + ")";
            }

            return result;
        }

        public string GetLinkeJoziyateInquiry(string inquiryType, long id)
        {
            string result = string.Empty;
            switch (inquiryType)
            {
                case "Inquiry_Zadghan":
                    result = string.Format("/default.aspx?tabid=2172&InquiryId={0}&ForView=Yes" , id);
                    break;
                case "Inquiry_Zadghal":
                    result = string.Format("/default.aspx?tabid=2173&InquiryId={0}&ForView=Yes" , id);
                    break;
                case "Inquiry_ZDF":
                    result = string.Format("/default.aspx?tabid=2174&InquiryId={0}&ForView=Yes" , id);
                    break;
                case "Inquiry_HS":
                    result = string.Format("/default.aspx?tabid=2175&InquiryId={0}&ForView=Yes" , id);
                    break;
                case "Inquiry_Zaban":
                    result = string.Format("/default.aspx?tabid=2176&InquiryId={0}&ForView=Yes" , id);
                    break;
            }
            return result;
        }

        public string IsInquiryZadghanHasFormeVooroodeArzeshBarAsaseVasileyeHaml(string baEhtesabeBimeyeMasooliyat,
            string formeVooroodeArzeshBarAsaseVasileyeHaml)
        {
            string result = string.Empty;
            if (baEhtesabeBimeyeMasooliyat == "بله")
            {
                result = string.Format("<A HREF=\"{0}\">فایل</A>", formeVooroodeArzeshBarAsaseVasileyeHaml);
            }

            return result;
        }
    }
}