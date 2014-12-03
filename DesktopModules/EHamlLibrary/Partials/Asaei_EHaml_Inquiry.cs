﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Protocols;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Content.Common;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using EHamlLibrary.DTOs;
using EHamlLibrary.Interfaces;

namespace EHamlLibrary
{
    public partial class Asaei_EHaml_Inquiry : IListableForViewInquiryList, IListableForDashboardMyInquiryList
    {
        private Utility.Utility _utility = new Utility.Utility();
        private int _currentUserId = UserController.GetCurrentUserInfo().UserID;

        public List<InquiryListDTO> GetInquiryListForViewInquiryList(string inquiryType)
        {
            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                List<InquiryListDTO> result = new List<InquiryListDTO>();
                switch (inquiryType)
                {
                    case "Inquiry_Zadghan":

                        result =
                            (from i in context.Asaei_EHaml_Inquiries
                                where i.InquiryType == "Inquiry_Zadghan"
                                select new InquiryListDTO()
                                {
                                    TedadePasokhha = _utility.GetTedadePasohkhaForInquiry(i.Id, context),
                                    NazareKoliyeKhoob =
                                        _utility.GetTedadeNazareKoliyeKhoobForSahebBar(_currentUserId, context),
                                    NazareKoliyeBad =
                                        _utility.GetTedadeNazareKoliyeBadForSahebBar(_currentUserId, context),
                                    Id = i.Id,
                                    Khatarnak = i.NoeMahmoole.Contains("IMDG"),
                                    Rank = 20,
                                    Power = 10,
                                    Status = "خوب",
                                    CreateDate = i.CreateDateShamsi,
                                    StartingPoint = i.OstaneMabda,
                                    Destination = i.OstaneMagsad,
                                    ExpireDate = i.TarikheEtebareEstelamShamsi,
                                    ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                    LoadType = i.NoeMahmoole,
                                    NoVaTedadeVasileyeHaml = _utility.GetTedadeVasileyeHamleMoredeNiyaz(i.Id, context),
                                    VazneKol = "ندارد",
                                    ReplyUrl = "/default.aspx?tabid=2172&InquiryId=" + i.Id,
                                }).ToList();
                        break;
                    case "Inquiry_Zadghal":
                        result =
                            (from i in context.Asaei_EHaml_Inquiries
                                where i.InquiryType == "Inquiry_Zadghal"
                                select new InquiryListDTO()
                                {
                                    TedadePasokhha = _utility.GetTedadePasohkhaForInquiry(i.Id, context),
                                    NazareKoliyeKhoob =
                                        _utility.GetTedadeNazareKoliyeKhoobForSahebBar(_currentUserId, context),
                                    NazareKoliyeBad =
                                        _utility.GetTedadeNazareKoliyeBadForSahebBar(_currentUserId, context),
                                    Id = i.Id,
                                    Khatarnak = i.NoeMahmoole.Contains("IMDG"),
                                    Rank = 20,
                                    Power = 10,
                                    Status = "خوب",
                                    CreateDate = i.CreateDateShamsi,
                                    StartingPoint = i.OstaneMabda,
                                    Destination = i.OstaneMagsad,
                                    ExpireDate = i.TarikheEtebareEstelamShamsi,
                                    ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                    LoadType = i.NoeMahmoole,
                                    NoVaTedadeVasileyeHaml = "ندارد",
                                    VazneKol = "ندارد",
                                    ReplyUrl = "/default.aspx?tabid=2173&InquiryId=" + i.Id,
                                }).ToList();
                        break;
                    case "Inquiry_ZDF":
                        result =
                            (from i in context.Asaei_EHaml_Inquiries
                                where i.InquiryType == "Inquiry_ZDF"
                                select new InquiryListDTO()
                                {
                                    TedadePasokhha = _utility.GetTedadePasohkhaForInquiry(i.Id, context),
                                    NazareKoliyeKhoob =
                                        _utility.GetTedadeNazareKoliyeKhoobForSahebBar(_currentUserId, context),
                                    NazareKoliyeBad =
                                        _utility.GetTedadeNazareKoliyeBadForSahebBar(_currentUserId, context),
                                    Id = i.Id,
                                    Khatarnak = false,
                                    Rank = 20,
                                    Power = 10,
                                    Status = "خوب",
                                    CreateDate = i.CreateDateShamsi,
                                    StartingPoint = i.OstaneMabda,
                                    Destination = i.OstaneMagsad,
                                    ExpireDate = i.TarikheEtebareEstelamShamsi,
                                    ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                    LoadType = i.NoeMahmoole2,
                                    NoVaTedadeVasileyeHaml = "ندارد",
                                    VazneKol = i.VazneMahmooleKiloGeram,
                                    ReplyUrl = "/default.aspx?tabid=3173&InquiryId=" + i.Id,
                                }).ToList();
                        break;
                    case "Inquiry_HS":
                        result =
                            (from i in context.Asaei_EHaml_Inquiries
                                where i.InquiryType == "Inquiry_HS"
                                select new InquiryListDTO()
                                {
                                    TedadePasokhha = _utility.GetTedadePasohkhaForInquiry(i.Id, context),
                                    NazareKoliyeKhoob =
                                        _utility.GetTedadeNazareKoliyeKhoobForSahebBar(_currentUserId, context),
                                    NazareKoliyeBad =
                                        _utility.GetTedadeNazareKoliyeBadForSahebBar(_currentUserId, context),
                                    Id = i.Id,
                                    Khatarnak = false,
                                    Rank = 20,
                                    Power = 10,
                                    Status = "خوب",
                                    CreateDate = i.CreateDateShamsi,
                                    StartingPoint = i.OstaneMabda,
                                    Destination = i.OstaneMagsad,
                                    ExpireDate = i.TarikheEtebareEstelamShamsi,
                                    ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                    LoadType = "ندارد",
                                    NoVaTedadeVasileyeHaml = "ندارد",
                                    VazneKol = "ندارد",
                                    ReplyUrl = "/default.aspx?tabid=3174&InquiryId=" + i.Id,
                                }).ToList();
                        break;
                    case "Inquiry_Zaban":
                        result =
                            (from i in context.Asaei_EHaml_Inquiries
                                where i.InquiryType == "Inquiry_Zaban"
                                select new InquiryListDTO()
                                {
                                    TedadePasokhha = _utility.GetTedadePasohkhaForInquiry(i.Id, context),
                                    NazareKoliyeKhoob =
                                        _utility.GetTedadeNazareKoliyeKhoobForSahebBar(_currentUserId, context),
                                    NazareKoliyeBad =
                                        _utility.GetTedadeNazareKoliyeBadForSahebBar(_currentUserId, context),
                                    Id = i.Id,
                                    Khatarnak = false,
                                    Rank = 20,
                                    Power = 10,
                                    Status = "خوب",
                                    CreateDate = i.CreateDateShamsi,
                                    StartingPoint = i.OstaneMabda,
                                    Destination = i.OstaneMagsad,
                                    ExpireDate = i.TarikheEtebareEstelamShamsi,
                                    ActionDate = i.TarikheAgazeAmaliyatShamsi,
                                    LoadType = i.NoeMahmoole2,
                                    NoVaTedadeVasileyeHaml = "ندارد",
                                    VazneKol = "ندارد",
                                    ReplyUrl = "/default.aspx?tabid=3175&InquiryId=" + i.Id,
                                }).ToList();
                        break;
                }

                return result;
            }
        }

        public List<InquiryListDTO> GetMyInquiryList(int userId, DateTime minDate, DateTime maxDate,
            List<InquiryListDTO> inquiryListDto)
        {
            List<InquiryListDTO> result = new List<InquiryListDTO>();

            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                //For Zadghan
                result.AddRange(
                    (from i in context.Asaei_EHaml_Inquiries
                     where i.InquiryType == "Inquiry_Zadghan" && i.UserId == userId
                          && i.TarikheEtebareEstelamMiladi.Value.Date > minDate &&
                          i.TarikheEtebareEstelamMiladi.Value.Date <= maxDate
                    select new InquiryListDTO()
                    {
                        Id = i.Id,
                        JoziyatLink = _utility.GetLinkeJoziyateInquiry(i.InquiryType,i.Id),
                        TedadePasokhha = 20,
                        NazareKoliyeKhoob = 20,
                        NazareKoliyeBad = 10,
                        Khatarnak = i.NoeMahmoole.Contains("IMDG"),
                        Rank = 20,
                        Power = 10,
                        // TODO
                        Status = "وضعیت کاربر",
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId, userId)
                                .DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDateMiladi.Value.ToShortDateString(),
                        ExpireDate = i.TarikheEtebareEstelamMiladi.Value.ToShortDateString(),
                        StartingPoint = i.OstaneMabda,
                        Destination = i.OstaneMagsad,
                        ActionDate = i.TarikheAgazeAmaliyatMiladi.Value.ToShortDateString(),
                        IsReallyNeed = i.HadafeShomaAzEstelam,
                        LoadType = i.NoeMahmoole,
                        EmptyingCharges = i.BaEhtesabeHazineyeTakhliyeDarMagsad == "بله",
                        NoVaTedadeVasileyeHaml = _utility.GetNoVaTedadeVasileyeHamlForInquiry(i.Id, context),
                        WithInsurance = i.BaEhtesabeBimeyeMasooliyat == "بله",
                        FileArzesheBar = _utility.IsInquiryZadghanHasFormeVooroodeArzeshBarAsaseVasileyeHaml
                        (i.BaEhtesabeBimeyeMasooliyat,i.FormeVooroodeArzeshBarAsaseVasileyeHaml),
                        Company = "",
                        VazneKol = ""
                    }).ToList());
                return result;
            }
        }
    }
}