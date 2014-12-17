using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using EHamlLibrary.DTOs;
using EHamlLibrary.Interfaces;

namespace EHamlLibrary
{
    public partial class Asaei_EHaml_ReplyToInquiry : IListableForDashboardMyReplyToInquiryList
    {
        private Utility.Utility _utility = new Utility.Utility();

        public List<ReplyToInquiryListDTO> GetMyReplyToInquiryList(int userId,
            DateTime minDateTime,DateTime maxDateTime, List<ReplyToInquiryListDTO> replyToInquiryListDto)
        {
            //For Zadghan
            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                replyToInquiryListDto.AddRange((from i in context.Asaei_EHaml_ReplyToInquiries
                    join j in context.Asaei_EHaml_Inquiries on i.InquiryId equals j.Id
                    where
                        i.InquiryType == "Zadghan" && i.ServentUserId == userId &&
                        j.TarikheEtebareEstelamMiladi.Value.Date > minDateTime &&
                        j.TarikheEtebareEstelamMiladi.Value.Date <= maxDateTime
                    select
                        new ReplyToInquiryListDTO()
                        {
                            InquiryId = j.Id,
                            SahebBarId = j.UserId,
                            JoziyatLink = _utility.GetLinkeJoziyateInquiry("Zadghan", j.Id),
                            SahebBarStatus = "وضعیت کاربر",
                            DisplayName =
                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                    (int) j.UserId).DisplayName,
                            InquiryType = j.InquiryType,
                            CreateDate = j.CreateDateShamsi,
                            ExpireDate = j.TarikheEtebareEstelamShamsi,
                            StartingPoint = j.OstaneMabda,
                            Destination = j.OstaneMagsad,
                            ActionDate = j.TarikheAgazeAmaliyatShamsi,
                            IsReallyNeed = j.HadafeShomaAzEstelam,
                            LoadType = j.NoeMahmoole,
                            EmptyingCharges = j.BaEhtesabeHazineyeTakhliyeDarMagsad == "بله",
                            NoVaTedadeVasileyeHaml = _utility.GetNoVaTedadeVasileyeHamlForReplyToInquiry(i.Id,context),
                            Status = i.Vaziyat,
                            FileArzesheBar =
                                string.Format("<A HREF=\"{0}\">فایل</A>", j.FormeVooroodeArzeshBarAsaseVasileyeHaml),
                            Company =
                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                    (int) j.UserId).Profile.GetPropertyValue("NameSherkat"),
                            ReplyToInquiryId = i.Id,
                            NazarSanji = _utility.GetVaziyateNazarSanjiyeKhadamatResanBeSahebBar(),
                            ModateAnjam = i.KoleModatZamaneHaml,
                            TedadePasokhHa = 20,
                        }).
                    ToList())
                    ;
                return replyToInquiryListDto;
            }
        }
    }
}