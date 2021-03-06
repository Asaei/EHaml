﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Asaei.Interfaces;
using Asaei.Partials;

namespace Asaei
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
}