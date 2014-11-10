using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Modules.Dashboard.Components.Portals;

namespace Asaei_EHaml
{
    public partial class Asaei_EHaml_Inquiry : IListableForViewInquiryList
    {
        public List<InquiryListForViewInquiryListDTO> InquiryListForViewInquiryList(string inquiryType)
        {
            using (EHamlDBEntities entities = new EHamlDBEntities())
            {
                List<InquiryListForViewInquiryListDTO> result = null;
                if (inquiryType == "Zadghan")
                {
                    
                    result =
                        (from i in entities.Asaei_EHaml_Inquiry
                            where i.InquiryType == "Zadghan"
                            select new InquiryListForViewInquiryListDTO()
                            {
                                TedadePasokhha = 3,
                                NazareKoliyeKhoob = 20,
                                NazareKoliyeBad = 11,
                                Id = i.Id,
                                Khatarnak = i.NoeMahmoole.Contains("IMDG"),
                                Rank = 3,
                                Power = 4,
                                Status = "خوب",
                                InquiryType = i.InquiryType,
                                CreateDate = i.CreateDateShamsi,
                                ExpireDate = i.TarikheEtebareEstelamShamsi,
                                StartingPoint = i.OstaneMabda,
                                Destination = i.OstaneMagsad,
                                ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                IsReallyNeed = i.HadafeShomaAzEstelam,
                                LoadType = i.NoeMahmoole,
                                EmptyingCharges = i.BaEhtesabeHazineyeTakhliyeDarMagsad,
                                NoVaTedadeVasileyeHaml = i.NoeVasileyeMoredeNiyaz,
                                WithInsurance = i.BaEhtesabeBimeyeMasooliyat,
                                FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", i.FormeVooroodeArzeshBarAsaseVasileyeHaml),
                                VazneKol = "ندارد",
                            }).ToList();
                }

                return result;
            }
        }
    }

    public interface IListableForViewInquiryList
    {
        List<InquiryListForViewInquiryListDTO> InquiryListForViewInquiryList(string inquiryType);
    }

    public class InquiryListForViewInquiryListDTO
    {
        public object TedadePasokhha { get; set; }
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
        public object EmptyingCharges { get; set; }
        public string NoVaTedadeVasileyeHaml { get; set; }
        public string WithInsurance { get; set; }
        public string FileArzesheBar { get; set; }
        public string VazneKol { get; set; }
    }
}