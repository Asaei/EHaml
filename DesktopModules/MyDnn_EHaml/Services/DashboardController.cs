using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Remoting.Contexts;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;



using Telerik.Web.Zip;



namespace MyDnn_EHaml.Services
{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class DashboardController : DnnApiController
    {
        private Util _util = new Util();


        [HttpGet]
        public HttpResponseMessage MyinquirysReplyListThatIApproveGozaresh(int IRTI_Id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var list = (from i in context.MyDnn_EHaml_GozareshTs
                    where i.InquiryReplyToInquiry_Id == IRTI_Id
                    select new GozareshListItemForSahebDTO()
                    {
                        Id = i.Id,
                        Name = _util.GetServantUserByInquiryReplyToInquiryId(IRTI_Id),
                        Matn = i.Message.Substring(20) + " ...",
                        Tarikh = i.Date
                    }).ToList();

                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
        }


        [HttpGet]
        public HttpResponseMessage InquiryListThatIReplyAndAccept()
        {
            List<MyInquirysReplyJft> myInquirysReplies = new List<MyInquirysReplyJft>();
            int userId = _util.GetUserEHamlUserIdByPortalId(this.UserInfo.UserID);
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                myInquirysReplies = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                    join k in context.MyDnn_EHaml_Inquiries on i.InquiryId equals k.Id
                    where
                        i.Status == 1 &&
                        j.MyDnn_EHaml_User_Id == userId
                    select
                        new MyInquirysReplyJft()
                        {
                            Id = i.Id,
                            CreateDate = i.CreateDate.ToShortDateString(),
                            StartingPoint = k.StartingPoint,
                            Destination = k.Destination,
                            JoziyatLink = _util.CreateJoziyateEstelamLink(k.Id, k.InquiryType),
                            NameKhedmatresan = _util.GetNameKhadamatResan((int) k.MyDnn_EHaml_User_Id),
                            Power = _util.GetUserPower((int) k.MyDnn_EHaml_User_Id),
                            Rank = _util.GetUserRank((int) k.MyDnn_EHaml_User_Id),
                            irti = i.Id,
                            NazareKoliyeKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) k.MyDnn_EHaml_User_Id),
                            NazareKoliyeBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) k.MyDnn_EHaml_User_Id),
                            KhadamatresanId = k.MyDnn_EHaml_User_Id,
                            NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiKhadamatBeSaheb(i.Id),
                        }).ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, myInquirysReplies);
        }

        [HttpGet]
        public HttpResponseMessage InquiryListThatIReplyAndAcceptForGozaresh()
        {
            List<MyInquirysReplyJft> myInquirysReplies = new List<MyInquirysReplyJft>();
            int userId = _util.GetUserEHamlUserIdByPortalId(this.UserInfo.UserID);
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                myInquirysReplies = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                    join k in context.MyDnn_EHaml_Inquiries on i.InquiryId equals k.Id
                    where
                        i.Status == 1 &&
                        j.MyDnn_EHaml_User_Id == userId
                    select
                        new MyInquirysReplyJft()
                        {
                            Id = i.Id,
                            InquiryType = k.InquiryType,
                            LoadType = k.LoadType,
                            CreateDate = i.CreateDate.ToShortDateString(),
                            StartingPoint = k.StartingPoint,
                            Destination = k.Destination,
                            JoziyatLink = _util.CreateJoziyateEstelamLink(k.Id, k.InquiryType),
                            NameKhedmatresan = _util.GetNameKhadamatResan((int) k.MyDnn_EHaml_User_Id),
                            Power = _util.GetUserPower((int) k.MyDnn_EHaml_User_Id),
                            Rank = _util.GetUserRank((int) k.MyDnn_EHaml_User_Id),
                            irti = i.Id,
                            NazareKoliyeKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) k.MyDnn_EHaml_User_Id),
                            NazareKoliyeBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) k.MyDnn_EHaml_User_Id),
                            KhadamatresanId = k.MyDnn_EHaml_User_Id,
                            NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiKhadamatBeSaheb(i.Id),
                            ActionDate = j.ZamaneAmadegiBarayeShooroo,
                            ZamaneAmadegiBarayeShooroo = j.ZamaneAmadegiBarayeShooroo.Value.ToShortDateString(),
                            NameSahebBar =
                                UserController.GetUserById(this.PortalSettings.PortalId, _util.GetSahebUserByIRTI(i.Id))
                                    .DisplayName,
                        }).ToList();

                foreach (MyInquirysReplyJft item in myInquirysReplies)
                {
                    string date = "تاریخ " + item.ActionDate.Value.ToShortDateString();
                    if (item.InquiryType == "Hl")
                    {
                        string type = _util.GeTypeInFarsi(item.InquiryType);
                        item.Mohtava = "(" +
                                       item.Id + ") " + type + " | از:" +
                                       item.StartingPoint.Replace(":", "(") +
                                       " به:" + item.Destination.Replace(":", "(") + "| محموله:" + " - ";
                    }
                    if (item.InquiryType == "Tj" || item.InquiryType == "Ts")
                    {
                        string type = _util.GeTypeInFarsi(item.InquiryType);
                        item.Mohtava = "(" +
                                       item.Id + ") " + type + " | از:" +
                                       item.StartingPoint.Replace(":", "(") +
                                       " به:" + " - (" + "| محموله:" + " - ";
                    }
                    else if (item.InquiryType == "Tr")
                    {
                        string type = _util.GeTypeInFarsi(item.InquiryType);
                        item.Mohtava = "(" +
                                       item.Id + ") " + type + " ، ";
                    }
                    else
                    {
                        string type = _util.GeTypeInFarsi(item.InquiryType);

                        item.Mohtava = "(" +
                                       item.Id + ") " + type + " | از:" +
                                       item.StartingPoint.Replace(":", "(") +
                                       " به:" + item.Destination.Replace(":", "(") + "| محموله:" + item.LoadType;
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, myInquirysReplies);
            }
        }

        [HttpGet]
        public HttpResponseMessage BankTransActionList()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var transList = (from i in context.MyDnn_EHaml__Banks
                    //join j in context.MyDnn_EHaml_BankTransactionDetails on i.MyDnn_EHaml_BankTransactionDetail_Id
                    //    equals j.Id
                    where i.EHaml_User_Id == UserController.GetCurrentUserInfo().UserID
                    select
                        new bankListDTO()
                        {
                            Id = i.Id,
                            Babate = i.Description,
                            Megdar = (i.Amount),
                            //Status = j.Status,
                            Zaman = i.Date,
                            Noesh = i.Type
                        }).ToList();

                Util _util = new Util();
                foreach (var dto in transList)
                {
                    dto.Link = _util.GetTransactionDescriptionEdame(dto.Id, dto.Babate);
                }

                //+ _util.GetTransactionDescriptionEdame(i.Id,i.Description),


                return Request.CreateResponse(HttpStatusCode.OK, transList);
            }
        }

        [HttpGet]
        public HttpResponseMessage EterazRaEmalKon(int id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var trans = (from i in context.MyDnn_EHaml_BankTransactionDetails
                    where i.InquiryReplyToInquiry_Id == id
                    select i).FirstOrDefault();
                trans.Status = 2;
                context.SubmitChanges();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetInquiryListThatIReplyForBedehkari()
        {
            List<InquiryListItemJft> inquiryList = new List<InquiryListItemJft>();

            string nahveyeBarkhord = _util.getNahveyeBarkhordBaBedehkari();

            int tedadHadeAxar = _util.getTedadeAmaliyateMojaz();

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int eHamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Zadghan" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        StatusPR = _util.GetUserStatus(_util.GetSahebUserByInquiryId(i.Id), 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        Status = n.Status.ToString(),
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());


                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Zadghal" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        Status = n.Status.ToString(),
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Zaban" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Rl" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());


                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Dn" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Dl" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "ZDF" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Dghco" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Hl" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Tj" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Tk" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Ts" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "Tr" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 && v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "ChandVajhiSabok" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    join v in context.MyDnn_EHaml_BankTransactionDetails on n.Id equals v.InquiryReplyToInquiry_Id
                    where
                        i.InquiryType == "ChandVajhiSangin" && h.MyDnn_EHaml_User_Id == eHamlUserId && n.Status == 1 &&
                        v.Status != 2
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                    }).ToList());

                //List<InquiryListItemJft> newOne = new List<InquiryListItemJft>();
                //foreach (InquiryListItemJft inquiryListItemJft in inquiryList)
                //{
                //    if (context.naz)
                //    {

                //    }
                //}
            }

            if (nahveyeBarkhord == "TedadeAmaliyat")
            {
                var returnItems = inquiryList.OrderByDescending(x => x.ActionDate).Take(tedadHadeAxar);
                return Request.CreateResponse(HttpStatusCode.OK, returnItems);
            }
            else
            {
                var returnItems = inquiryList.OrderByDescending(x => x.ActionDate).Take(tedadHadeAxar);
                return Request.CreateResponse(HttpStatusCode.OK, returnItems);
            }
        }

        [HttpGet]
        public List<MyInquirysReplyJft> MyinquirysReplyList(int inquiryID)
        {
            List<MyInquirysReplyJft> myInquirysReplies = new List<MyInquirysReplyJft>();


            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                var inquiry = (from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == inquiryID
                    select i).Single();

                if (inquiry.InquiryType != "Bazdid")
                {
                    myInquirysReplies = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        where i.InquiryId == inquiryID
                        select
                            new MyInquirysReplyJft()
                            {
                                inqId = i.InquiryId,
                                Id = i.Id,
                                StatusPR = _util.GetUserStatus(_util.GetServantUserByInquiryReplyToInquiryId(i.Id), 0),
                                DisplayName = UserController.GetUserById(0, (int) (from k in context.MyDnn_EHaml_Users
                                    where k.Id == j.MyDnn_EHaml_User_Id
                                    select k.PortalUserId).Single()).DisplayName,
                                GeymateKol = j.GeymateKol.ToString(),
                                ZamaneAmadegiBarayeShooroo = j.ZamaneAmadegiBarayeShooroo.Value.Date.ToShortDateString(),
                                Status = i.Status,
                                CreateDate = i.CreateDate.Date.ToShortDateString(),
                                ModateAnjameAmaliyat = j.KoleModatZamaneHaml,
                                Pishbini = j.Pishbini,
                                Power = _util.GetUserPower((int) j.MyDnn_EHaml_User_Id),
                                Rank = _util.GetUserRank((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliKhoob = _util.GetNazareKoliKhoobSahebBeKhadamat((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliBad = _util.GetNazareKoliBadSahebBeKhadamat((int) j.MyDnn_EHaml_User_Id),
                                VaziyatePaziresh = i.Status.ToString(),
                                NameKhedmatresan = _util.GetNameKhadamatResan((int) j.MyDnn_EHaml_User_Id),
                            }).ToList();
                }
                else
                {
                    myInquirysReplies = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        where i.InquiryId == inquiryID
                        select
                            new MyInquirysReplyJft()
                            {
                                Id = i.Id,
                                StatusPR = _util.GetUserStatus(_util.GetServantUserByInquiryReplyToInquiryId(i.Id), 0),
                                DisplayName = UserController.GetUserById(0, (int) (from k in context.MyDnn_EHaml_Users
                                    where k.Id == j.MyDnn_EHaml_User_Id
                                    select k.PortalUserId).Single()).DisplayName,
                                GeymateKol = j.GeymateKol.ToString(),
                                Status = i.Status,
                            }).ToList();
                }
            }


            //UserController.GetUserById(0, (from k in context.MyDnn_EHaml_Users
            //                   where j.Id == j.MyDnn_EHaml_User_Id
            //                   select i.Id).Single()).DisplayName,
            //               GeymateKol = j.GeymateKol.ToString(),
            foreach (MyInquirysReplyJft myInquirysReplyJft in myInquirysReplies)
            {
                if (!(myInquirysReplyJft.Status == 1))
                {
                    myInquirysReplyJft.DisplayName = "***";
                }
            }

            foreach (MyInquirysReplyJft myInquirysReplyJft in myInquirysReplies)
            {
                if ((myInquirysReplyJft.DisplayName != "***"))
                {
                    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
                    using (
                        DataClassesDataContext context =
                            new DataClassesDataContext(Config.GetConnectionString()))
                    {
                        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
                            join j in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals j.ReplyToInquiryId
                            where j.Id == myInquirysReplyJft.Id
                            select i).Single();

                        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry = (
                            from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            where i.Id == myInquirysReplyJft.Id
                            select i).Single();

                        if (
                            !context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats.Any(
                                i =>
                                    i.Inquiry_Id == inquiryReplyToInquiry.InquiryId &&
                                    i.ReplyToInquiry_Id == inquiryReplyToInquiry.ReplyToInquiryId)
                            )
                        {
                            if (
                                (DateTime.Parse(myInquirysReplyJft.ZamaneAmadegiBarayeShooroo).AddDays(
                                    Convert.ToDouble(replyToInquiry.KoleModatZamaneHaml))
                                    .AddDays(_util.GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji())).Date <=
                                DateTime.Now)
                            {
                                myInquirysReplyJft.NazarSanji = "Yes";
                            }
                            else
                            {
                                myInquirysReplyJft.NazarSanji = "No";
                            }
                        }
                        else
                        {
                            myInquirysReplyJft.NazarSanji = "SherkatKarde";
                        }
                    }
                }
            }

            return myInquirysReplies;
        }

        [HttpGet]
        public HttpResponseMessage GetInquiryListThatIReply(int UserId, int ModuleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(ModuleId);
            string value = setting["grideMoredeNazarVaseDashboardKhedmatgozar"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            List<InquiryListItemJft> inquiryList = new List<InquiryListItemJft>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int eHamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Zadghan" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select
                        new InquiryListItemJft()
                        {
                            Id = i.Id,
                            SahebId = _util.GetSahebUserByInquiryId(i.Id),
                            JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghan"),
                            StatusPR = _util.GetUserStatus(_util.GetSahebUserByInquiryId(i.Id), 1),
                            DisplayName =
                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                    (int) j.PortalUserId).DisplayName,
                            InquiryType = i.InquiryType,
                            CreateDate = i.CreateDate.Value.ToShortDateString(),
                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                            IsTender = i.IsTender,
                            StartingPoint = i.StartingPoint,
                            Destination = i.Destination,
                            ActionDate = i.ActionDate.Value.ToShortDateString(),
                            IsReallyNeed = i.IsReallyNeed,
                            LoadType = i.LoadType,
                            EmptyingCharges = k.EmptyingCharges,
                            NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                            Status = n.Status.ToString(),
                            FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                            IRTI = n.Id,
                            NazarSanji = "False",
                            ModateAnjam = h.KoleModatZamaneHaml,
                            TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                        }).
                    ToList())
                    ;


                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Zadghal" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghal"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        Status = n.Status.ToString(),
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False"
                        ,
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Zaban" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zaban"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());

                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Rl" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Rl"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());


                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Dn" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dn"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Dl" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dl"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "ZDF" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ZDF"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Dghco" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dghco"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Hl" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Hl"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Tj" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tj"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Tk" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tk"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Ts" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Ts"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "Tr" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tr"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                        TedadePasokhHa = _util.GetTedadePasokhHayeResideBarayeYekEstelam(i.Id),
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "ChandVajhiSabok" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSabok"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                    }).ToList());
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join n in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals n.InquiryId
                    join k in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join h in context.MyDnn_EHaml_ReplyToInquiries on n.ReplyToInquiryId equals h.Id
                    where
                        i.InquiryType == "ChandVajhiSangin" && h.MyDnn_EHaml_User_Id == eHamlUserId &&
                        i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        SahebId = _util.GetSahebUserByInquiryId(i.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSangin"),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        Status = n.Status.ToString(),
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        IRTI = n.Id,
                        NazarSanji = "False",
                        ModateAnjam = h.KoleModatZamaneHaml,
                    }).ToList());
            }
            //            foreach (InquiryListItemJft inquiryListItemJft in inquiryList)
            //            {
            //                if (inquiryListItemJft.Status == "2")
            //                {
            //                    if (DateTime.Parse(inquiryListItemJft.ExpireDate).Date < DateTime.Now.Date)
            //                    {
            //                        inquiryListItemJft.Status = "پذیرفته نشد";
            //                    }
            //                    else
            //                    {
            //                        inquiryListItemJft.Status = "در حال بررسی";
            //                    }
            //                }
            //                else
            //                {
            //                    if (inquiryListItemJft.Status == "0")
            //                    {
            //                        inquiryListItemJft.Status = "پذیرفته نشد";
            //                    }
            //                    else
            //                    {
            //                        inquiryListItemJft.Status = "پذیرفته شد";
            //                        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry = null;
            //                        using (
            //                            DataClassesDataContext context =
            //                                new DataClassesDataContext(Config.GetConnectionString()))
            //                        {
            //                            inquiryReplyToInquiry = (
            //                                from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
            //                                where i.Id == inquiryListItemJft.IRTI
            //                                select i).Single();
            //
            //                            MyDnn_EHaml_ReplyToInquiry replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
            //                                where i.Id == inquiryReplyToInquiry.ReplyToInquiryId
            //                                select i).Single();
            //
            //                            if (
            //                                !context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs.Any(
            //                                    i =>
            //                                        i.Inquiry_Id == inquiryReplyToInquiry.InquiryId &&
            //                                        i.ReplyToInquiry_Id == inquiryReplyToInquiry.ReplyToInquiryId)
            //                                )
            //                            {
            //                                if ((
            //                                    (replyToInquiry.ZamaneAmadegiBarayeShooroo.Value.AddDays(
            //                                        Convert.ToInt32(replyToInquiry.KoleModatZamaneHaml))
            //                                        .AddDays(_util.GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji())).Date <=
            //                                    DateTime.Now.Date))
            //                                {
            //                                    inquiryListItemJft.NazarSanji = "True";
            //                                }
            //                            }
            //                            else
            //                            {
            //                                inquiryListItemJft.NazarSanji = "SherkatKarde";
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            foreach (var i in inquiryList)
            {
                i.InquiryType = _util.GeTypeInFarsiRealShort(i.InquiryType);
            }

            return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
        }

        [HttpGet]
        public HttpResponseMessage GetUserInfo(int id)
        {
            MyUserInfo myUserInfo = null;
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == id
                    select i).Single();

                MyDnn_EHaml_User dnnEHamlUser = (from i in context.MyDnn_EHaml_Users
                    where i.Id == inquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                UserInfo info = UserController.GetUserById(this.PortalSettings.PortalId, (int) dnnEHamlUser.PortalUserId);

                myUserInfo = new MyUserInfo()
                {
                    DisplayName = info.DisplayName,
                    Phone = info.Profile.Telephone,
                    CellPhone = info.Profile.Cell,
                    Email = info.Email
                };
            }
            return Request.CreateResponse(HttpStatusCode.OK, myUserInfo);
        }

        [HttpGet]
        public HttpResponseMessage MyinquirysList(int UserId, int ModuleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(ModuleId);
            string value = setting["grideMoredeNazarVaseDashboardSaheb"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            int ehamlUserIdAsli = _util.GetUserEHamlUserIdByPortalId(UserId);
            //            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                //                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                //                    where i.PortalUserId == this.UserInfo.UserID
                //                    select i.Id).Single();

                int ehamlUserId = int.MaxValue;

                //                    if (inquiryTypeForList == "Zadghan")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghan" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //&& (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zadghan" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zadghan" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghan"),
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Zadghal")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghal" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zadghal" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zadghal" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghal"),
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Zaban")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zaban" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zaban" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zaban"),
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zaban"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Rl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Rl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Rl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Rl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Rl"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dn")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dn" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dn" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dn"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dn"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dl"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ZDF")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ZDF" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ZDF" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ZDF"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ZDF"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dghco")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dghco" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dghco" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dghco"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dghco"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Hl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Hl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Hl"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hs" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Hl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hs"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Hs"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tj")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tj" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tj" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tj"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tj"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tk")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tk" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tk" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tk"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tk"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Ts")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Ts" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Ts" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Ts"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Ts"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tr")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tr" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tr" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tr"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tr"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = "",
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSabok")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSabok" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSabok"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSangin")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSangin" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSangin"),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Bazdid")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Bazdid" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                    //                    && (
                    //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                    //                        where c.InquiryId == i.Id &&
                    //                              i.InquiryType == "Bazdid" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                    //                        select c).Count() < 3 && !(
                    //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                    //                            where z.InquiryId == i.Id &&
                    //                                  i.InquiryType == "Bazdid" && z.Status == 2 &&
                    //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                    //                            select z).Any()
                    //&& i.ExpireDate.Value.Date > minDateTime && i.ExpireDate.Value.Date <= maxDateTime
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Bazdid"),
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = "",
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = "",
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                foreach (var item in inquiryList)
                {
                    item.InquiryType = _util.GeTypeInFarsiRealShort(item.InquiryType);
                }
                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
            }
        }

        [HttpGet]
        public HttpResponseMessage MyinquirysListSuc(int UserId)
        {
            int ehamlUserIdAsli = _util.GetUserEHamlUserIdByPortalId(UserId);
            //            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                //                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                //                    where i.PortalUserId == this.UserInfo.UserID
                //                    select i.Id).Single();
                //                int ehamlUserId = int.MaxValue;
                //                    if (inquiryTypeForList == "Zadghan")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghan" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //&& (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zadghan" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zadghan" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghan"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
//                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                    }));
                //                                    }
                //                                    else if (inquiryTypeForList == "Zadghal")
                //                                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghal" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zadghal" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zadghal" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghal"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Zaban")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zaban" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Zaban" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zaban"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zaban"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Rl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Rl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Rl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Rl"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Rl"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dn")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dn" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dn" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dn"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dn"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dl"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dl"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ZDF")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ZDF" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ZDF" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ZDF"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ZDF"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dghco")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dghco" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Dghco" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dghco"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Dghco"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Hl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hl" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Hl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hl"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Hl"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hs on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hs" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Hl" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hs"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Hs"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tj")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tj" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tj" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tj"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tj"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tk")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tk" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tk" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tk"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tk"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Ts")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Ts" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Ts" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Ts"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Ts"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tr")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tr" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Tr" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tr"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Tr"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = "",
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSabok")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSabok" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSabok"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSangin")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSangin" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
                        //                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "ChandVajhiSangin"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Bazdid")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
                    join b in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals b.InquiryId
                    join f in context.MyDnn_EHaml_ReplyToInquiries on b.ReplyToInquiryId equals f.Id
                    join j in context.MyDnn_EHaml_Users on f.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Bazdid" && i.MyDnn_EHaml_User_Id == ehamlUserIdAsli
                        //                    && (
                        //                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                        where c.InquiryId == i.Id &&
                        //                              i.InquiryType == "Bazdid" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        //                        select c).Count() < 3 && !(
                        //                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                        //                            where z.InquiryId == i.Id &&
                        //                                  i.InquiryType == "Bazdid" && z.Status == 2 &&
                        //                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                        //                            select z).Any()
                          && b.Status == 1
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
                            select c).Count(),
                        NazareKoliyeKhoob =
                            _util.GetNazareKoliKhoobSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int) f.MyDnn_EHaml_User_Id).ToString(),
                        Id = i.Id,
                        NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamat(b.Id),
                        JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Bazdid"),
                        irti = b.Id,
                        rId = f.Id,
                        KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        Khatarnak = false,
                        Rank = _util.GetUserRank((int) f.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) f.MyDnn_EHaml_User_Id),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = "",
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = "",
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                        NameKhedmatresan = _util.GetNameKhadamatResan((int) f.MyDnn_EHaml_User_Id),
                    }));
                foreach (var item in inquiryList)
                {
                    item.InquiryType = _util.GeTypeInFarsiRealShort(item.InquiryType);
                }
                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
            }
        }

        [HttpGet]
        public HttpResponseMessage MyReplyDetail(int irti)
        {
            int sahebId = _util.GetSahebUserByIRTI(irti);
            string sahebDisplay =
                new DotNetNuke.Entities.Users.UserController().GetUser(this.PortalSettings.PortalId, sahebId)
                    .DisplayName;
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                List<ReplyInDetailDTO> dto = new List<ReplyInDetailDTO>();
                dto = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                    where i.Id == irti
                    select new ReplyInDetailDTO()
                    {
                        Id = j.Id,
                        IRTI = i.Id,
                        Status = _util.GetVaziyateInRely((int) i.ReplyToInquiryId),
                        SahebId = sahebId,
                        SahebDisplayName = sahebDisplay,
                        ReadyToAction = j.ZamaneAmadegiBarayeShooroo.Value.ToShortDateString(),
                        ModatZamaneAnjam = j.KoleModatZamaneHaml,
                        GeymateKol = j.GeymateKol,
                        Pishbibni = j.Pishbini,
                        CreateDate = j.CreateDate.ToShortDateString(),
                    }).ToList();

                return Request.CreateResponse(HttpStatusCode.OK, dto);
            }
        }

        [HttpGet]
        public HttpResponseMessage BaPishnahadMovafegamPasEmalKon(int irti)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
                    (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        where i.Id == irti
                        select i).Single();

                MyDnn_EHaml_ReplyToInquiry replyToInquiry =
                    (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        where i.Id == inquiryReplyToInquiry.Id
                        select j).Single();

                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                inquiryReplyToInquiry.Status = 1;

                context.SubmitChanges();

                var myInquiry = (from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == inquiryReplyToInquiry.InquiryId
                    select i).Single();


                myInquiry.ServantUserId = replyToInquiry.MyDnn_EHaml_User_Id;
                myInquiry.AcceptedDate = DateTime.Now;
                context.SubmitChanges();

                _util.TanzimeBedehkariyeUser((int) user.PortalUserId, myInquiry.AcceptedDate);


                long mablag = (long) _util.MakeKhadamatresanBedehkar(inquiryReplyToInquiry,
                    (int) user.PortalUserId,
                    (_util.GetDarsad(replyToInquiry.GeymateKol, replyToInquiry.ReplyToInquiryType)),
                    _util.getUserTakhfif(user.PortalUserId),
                    0);

                string content = _util.ContentForEtelaresaniTaeedReply(context, irti.ToString(), mablag);

                _util.EtelaresaniForTaeedReply(irti, content);

                return Request.CreateResponse(HttpStatusCode.OK, 1);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetGrideMoredeNazarVaseDashboardSaheb(int moduleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            string value = setting["grideMoredeNazarVaseDashboardSaheb"].ToString();

            int result = 0;

            if (value == "استعلامات قبلی")
            {
                result = 0;
            }
            else if (value == "استعلامات فعال")
            {
                result = 2;
            }
            else if (true)
            {
                result = 1;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        public HttpResponseMessage GetGrideMoredeNazarVaseDashboardElamiyeSaheb(int moduleId)
        {
            string value = string.Empty;
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            if (setting["grideMoredeNazarVaseDashboardElamiyeSaheb"] != null)
            {
                value = setting["grideMoredeNazarVaseDashboardElamiyeSaheb"].ToString();
            }


            int result = 0;

            if (value == "استعلامات قبلی")
            {
                result = 0;
            }
            else if (value == "استعلامات فعال")
            {
                result = 2;
            }
            else if (true)
            {
                result = 1;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        [HttpGet]
        public HttpResponseMessage GetGrideMoredeNazarVaseDashboardElamiyeServent(int moduleId)
        {
            string value = string.Empty;
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            if (setting["grideMoredeNazarVaseDashboardElamiyeServent"] != null)
            {
                value = setting["grideMoredeNazarVaseDashboardElamiyeServent"].ToString();
            }

            int result = 0;

            if (value == "استعلامات قبلی")
            {
                result = 0;
            }
            else if (value == "استعلامات فعال")
            {
                result = 2;
            }
            else if (true)
            {
                result = 1;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        public HttpResponseMessage GetGrideMoredeNazarVaseDashboardServant(int moduleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            string value = setting["grideMoredeNazarVaseDashboardKhedmatgozar"].ToString();

            int result = 0;

            if (value == "استعلامات قبلی")
            {
                result = 0;
            }
            else if (value == "استعلامات فعال")
            {
                result = 2;
            }
            else if (true)
            {
                result = 1;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

    }

    public class ElamiyeListItemJftGeneral
    {
        public int Id { get; set; }

        public DateTime CreateDate { get; set; }

        public string Vasile { get; set; }

        public DateTime ZamaneAmadegi { get; set; }

        public DateTime ExpireDate { get; set; }

        public int TedadePasohkha { get; set; }
        public string ElamiyeType { get; set; }
        public string ElamiyeTypeEN { get; set; }
    }
}

public class UserListItem
{
    public string DisplayName { get; set; }
    public int? Id { get; set; }
}

public class GozareshListItemForSahebDTO
{
    public int Id { get; set; }
    public int Name { get; set; }
    public string Matn { get; set; }
    public DateTime? Tarikh { get; set; }
}

public class bankListDTO
{
    public long Id { get; set; }
    public string Babate { get; set; }
    public int? Megdar { get; set; }
    public byte? Status { get; set; }
    public DateTime? Zaman { get; set; }
    public byte? Noesh { get; set; }
    public string Link { get; set; }
}

public class MyUserInfo
{
    public string DisplayName { get; set; }
    public string Phone { get; set; }
    public string CellPhone { get; set; }
    public string Email { get; set; }
}


public class MyInquirysReplyJft
{
    public int Id { get; set; }
    public string GeymateKol { get; set; }
    public string ZamaneAmadegiBarayeShooroo { get; set; }
    public string DisplayName { get; set; }
    public byte? Status { get; set; }
    public string NazarSanji { get; set; }
    public string StatusPR { get; set; }
    public DateTime Tarikh { get; set; }
    public string Mohtava { get; set; }
    public string CreateDate { get; set; }
    public string ModateAnjameAmaliyat { get; set; }
    public string Pishbini { get; set; }

    public int Power { get; set; }

    public double Rank { get; set; }
    public int NazareKoliKhoob { get; set; }
    public int NazareKoliBad { get; set; }
    public string VaziyatePaziresh { get; set; }
    public string NameKhedmatresan { get; set; }

    public int? inqId { get; set; }
    public string StartingPoint { get; set; }

    public string Destination { get; set; }

    public string JoziyatLink { get; set; }

    public int irti { get; set; }

    public int NazareKoliyeKhoob { get; set; }

    public int NazareKoliyeBad { get; set; }

    public int? KhadamatresanId { get; set; }

    public int NazarSanjiVaziyat { get; set; }

    public string InquiryType { get; set; }
    public DateTime? ActionDate { get; set; }
    public string LoadType { get; set; }

    public string NameSahebBar { get; set; }
}


