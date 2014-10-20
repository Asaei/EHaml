using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using Microsoft.VisualBasic;
using MyDnn_EHaml.ServiceReference1;
using MyDnn_EHaml_Bank = MyDnn_EHaml.DataClassesDataContext;
using MyDnn_EHaml_BankTransactionDetail =
    MyDnn_EHaml.MyDnn_EHaml_BankTransactionDetail;
using MyDnn_EHaml_Inquiry_ReplyToInquiry =
    MyDnn_EHaml.MyDnn_EHaml_Inquiry_ReplyToInquiry;
using MyDnn_EHaml_User = MyDnn_EHaml.MyDnn_EHaml_User;
using MyDnn_EHaml__Bank = MyDnn_EHaml.MyDnn_EHaml__Bank;


namespace MyDnn_EHaml
{
    public class Util : System.Web.UI.Page
    {
        public int GetUserPower(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i2 in context.MyDnn_EHaml_UserRanks
                    where i2.MyDnn_EHaml_User_Id == EuserId
                    select i2.Power).SingleOrDefault();
            }
        }

        public double GetUserRank(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i2 in context.MyDnn_EHaml_UserRanks
                    where i2.MyDnn_EHaml_User_Id == EuserId
                    select i2.Quality).SingleOrDefault();
            }
        }

        public int UserId
        {
            get { return UserController.GetCurrentUserInfo().UserID; }
        }

        public int PortalId
        {
            get { return PortalController.GetCurrentPortalSettings().PortalId; }
        }

        public string IsUserOk(int userId, int userType)
        {
            string result = string.Empty;

            if (this.UserId == -1)
            {
                result = "LoginNakarde";
            }
            else if (this.UserId > -1)
            {
                UserInfo userInfo = UserController.GetUserById(this.PortalId, userId);

                using (DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_User myDnnEHamlUser = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == userId
                        select i).Single();

                    if (!(bool) myDnnEHamlUser.IsApprove)
                    {
                        result = "ApproveNashode";
                    }
                    else
                    {
                        int vaziyateSubBoodaneKarbar = IsThisUserIsValidSubscribe(userId, userType);
                        if (vaziyateSubBoodaneKarbar != 9)
                        {
                            if (vaziyateSubBoodaneKarbar == 1)
                            {
                                return "SubscribeNistMamooli";
                            }
                            else if (vaziyateSubBoodaneKarbar == 2)
                            {
                                if (userType == 0)
                                {
                                    return "SubscribeNistAvaziK";
                                }
                                else
                                {
                                    return "SubscribeNistAvaziS";
                                }
                            }
                        }
                        else if (!GetUserVaziyateBedehkari(userId))
                        {
                            result = "Bedehkare";
                        }
                        else
                        {
                            result = "OK";
                        }
                    }
                }
            }
            return result;
        }

        private bool GetUserVaziyateBedehkari(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                string nahveyeBarkhordBaBedehkara = getNahveyeBarkhordBaBedehkari();

                if (nahveyeBarkhordBaBedehkara == "TedadeAmaliyat")
                {
                    int tedadeAmaliyateMojaz = getTedadeAmaliyateMojaz();
                    if (GetUserTedadeAmaliyateInBedehkari(userId) > -1 &&
                        (!(GetUserTedadeAmaliyateInBedehkari(userId) < tedadeAmaliyateMojaz)) &&
                        getUserMizaneBedehkari(userId) != int.MinValue)
                    {
                        if (getUserMizaneBedehkari(userId) < 0)
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    else
                    {
                        return true;
                    }
                }
                else
                {
                    int tedadeRoozMojazBadAzAvalinBedehkari = getTedadeRoozeMojazeBadAzBedehkari();
                    if (
                        (((GetUserTarikheAvalineBedehkari(userId)).AddDays(tedadeRoozMojazBadAzAvalinBedehkari) >
                          DateTime.Now)) && getUserMizaneBedehkari(userId) != int.MinValue)
                    {
                        if (getUserMizaneBedehkari(userId) < 0)
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    else
                    {
                        return true;
                    }
                }
            }
        }

        private DateTime GetUserTarikheAvalineBedehkari(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (DateTime) (from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                    where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)
                    select i.TarikheShoorooeBedehkari
                    ).Single();
            }
        }

        private decimal GetUserTedadeAmaliyateInBedehkari(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User_VaziyateBedehkari bedehkari =
                    (from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                        where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)
                        select i).SingleOrDefault();

                if (bedehkari != null)
                {
                    return (decimal) bedehkari.TedadeAmaliyateShameleBedehkari;
                }
                else
                {
                    return -1;
                }
            }
        }


        private int IsThisUserIsValidSubscribe(int userId, int userType)
        {
            MyDnn_EHaml_Subscription subscription = GetUserLastSubscription(GetUserEHamlUserIdByPortalId(userId),
                userType);
            if (subscription != null)
            {
                if (subscription.ExpireDate.Value.Date > DateTime.Now.Date)
                {
                    return 9;
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                return 2;

            }
        }

        private MyDnn_EHaml_Subscription GetUserLastSubscription(int userId, int userType)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                IQueryable<MyDnn_EHaml_Subscription> subscription = (from i in context.MyDnn_EHaml_Subscriptions
                    where i.MyDnn_EHaml_User_Id == userId && i.UserType == userType
                    select i);
                return subscription.ToList().LastOrDefault();
            }
        }

        public string EtelaresaniForTaeedReply(int replyId, string content)
        {
            // ToDo: 1- ersale email    2-ersale notification    3-ersale SMS

            DotNetNuke.Services.Mail.MailFormat _mailFormat = DotNetNuke.Services.Mail.MailFormat.Html;
            bool SMTPEnableSSL = DotNetNuke.Entities.Host.Host.GetHostSettingsDictionary()["SMTPEnableSSL"] == "Y";

            string txtTitle = CurrentTxtOnvaneTaeidPishnahad();

            UserInfo user = UserController.GetUserById(this.PortalId, GetSahebUserByInquiryReplyToInquiryId(replyId));
            SendMail("info@ehaml.ir", user.Email, "", "", "info@ehaml.ir",
                DotNetNuke.Services.Mail.MailPriority.Normal,
                txtTitle,
                _mailFormat,
                System.Text.Encoding.UTF8, content, "", "", "", "", SMTPEnableSSL);


//            string smsContent = ContentForEtelaresaniTaeedReplySMS(new DataClassesDataContext(),
//                replyId.ToString());
//            SendSMS("09125574453", smsContent);

            return string.Empty;
        }

        private void SendSMS(string userCell, string content)
        {
            SendSoapClient sms = new SendSoapClient();

            var to = new ArrayOfString();
            to.Add(userCell);

            var rec = new ArrayOfLong();

            byte[] status = null;

            //sms.SendSms("h012", "h012", to, "50002603300008", content, false, "", ref rec, ref status);
        }

        public int GetSahebUserByInquiryReplyToInquiryId(int replyId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int userId = (int) (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join x in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals x.Id
                    join j in context.MyDnn_EHaml_Users on x.MyDnn_EHaml_User_Id equals j.Id
                    where i.Id == replyId
                    select j.PortalUserId).Single();

                return userId;
            }
        }

        public int GetSahebUserByIRTI(int id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int userId = (int) (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_Inquiries on i.InquiryId equals j.Id
                    join x in context.MyDnn_EHaml_Users on j.MyDnn_EHaml_User_Id equals x.Id
                    where i.Id == id
                    select x.PortalUserId).Single();

                return userId;
            }
        }

        public string EtelaresaniForReplyToInquiry(int inquiryId, string content)
        {
            DotNetNuke.Services.Mail.MailFormat _mailFormat = DotNetNuke.Services.Mail.MailFormat.Html;
            bool SMTPEnableSSL = DotNetNuke.Entities.Host.Host.GetHostSettingsDictionary()["SMTPEnableSSL"] == "Y";

            UserInfo user = UserController.GetUserById(this.PortalId, GetSahebUserByIRTI(inquiryId));

            // ToDo: 1- ersale email    2-ersale notification    3-ersale SMS

            string txtTitle = CurrentTxtOnvanePishnahad();

            SendMail("info@ehaml.ir", user.Email, "", "", "info@ehaml.ir",
                DotNetNuke.Services.Mail.MailPriority.Normal, txtTitle,
                _mailFormat,
                System.Text.Encoding.UTF8, content, "", "", "", "", SMTPEnableSSL);

//            string smsContent = ContentForEtelaresaniReplyToInquirySMS(new DataClassesDataContext(), inquiryId.ToString())
//            SendSMS("09125574453", smsContent);

            return string.Empty;
        }

        public int GetSahebUserByInquiryId(int inquiryId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int userId = (int) (from i in context.MyDnn_EHaml_Inquiries
                    join j in context.MyDnn_EHaml_Users
                        on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.Id == inquiryId
                    select j.PortalUserId).Single();

                return userId;
            }
        }

        public string SendMail(string MailFrom, string MailTo, string Cc, string Bcc, string ReplyTo,
            DotNetNuke.Services.Mail.MailPriority Priority, string Subject,
            DotNetNuke.Services.Mail.MailFormat BodyFormat, System.Text.Encoding BodyEncoding,
            string Body,
            string SMTPServer, string SMTPAuthentication, string SMTPUsername, string SMTPPassword,
            bool SMTPEnableSSL)
        {
            string rslt = string.Empty;

            //Note: DNN 5.3.0 - DNN 5.5.0 SendMail overload which includes Attachments parameter as string array
            //ignore passed in ReplyTo parameter substituting it with MailFrom parameter value. Only the overload with
            //Attachments as generic list of System.Net.Mail.Attachment honors the ReplyTo parameter.

            System.Collections.Generic.List<System.Net.Mail.Attachment> attachments =
                new System.Collections.Generic.List<System.Net.Mail.Attachment>();

            try
            {
                rslt = DotNetNuke.Services.Mail.Mail.SendMail(MailFrom, MailTo, Cc, Bcc, ReplyTo, Priority, Subject,
                    BodyFormat, BodyEncoding, Body,
                    attachments, "", "", "", "", SMTPEnableSSL);
            }
            catch (Exception ex)
            {
                if ((ex.InnerException != null))
                {
                    rslt = string.Concat(ex.Message, Microsoft.VisualBasic.ControlChars.CrLf, ex.InnerException.Message);
                }
                else
                {
                    rslt = ex.Message;
                }
            }
            return rslt;
        }

        public string GeTypeInFarsiReal(string inquiryType)
        {
            string result = string.Empty;
            switch (inquiryType)
            {
                case "Zadghan":
                    result = "حمل جاده ای";
                    break;
                case "Zadghal":
                    result = "حمل جاده ای";
                    break;
                case "Zaban":
                    result = "حمل جاده ای";
                    break;
                case "Rl":
                    result = "حمل ریلی";
                    break;
                case "Dn":
                    result = "حمل دریایی";
                    break;
                case "Dl":
                    result = "حمل دریایی";
                    break;
                case "ZDF":
                    result = "حمل جاده ای";
                    break;
                case "Dghco":
                    result = "حمل دریایی";
                    break;
                case "Hl":
                    result = "حمل هوایی";
                    break;
                case "Tj":
                    result = "تخلیه/بارگیری";
                    break;
                case "Tk":
                    result = "تخلیه/بارگیری";
                    break;
                case "Ts":
                    result = "تخلیه/بارگیری ";
                    break;
                case "Tr":
                    result = "ترخیص";
                    break;
                case "ChandVajhiSabok":
                    result = "حمل چند وجهی سبک";
                    break;
                case "ChandVajhiSangin":
                    result = "حمل چند وجهی سنگین";
                    break;
                case "Bazdid":
                    result = "بازدید مسیر";
                    break;
            }
            return result;
        }
        public string GeTypeInFarsiRealShort(string inquiryType)
        {
            string result = string.Empty;
            switch (inquiryType)
            {
                case "Zadghan":
                    result = " جاده ای";
                    break;
                case "Zadghal":
                    result = " جاده ای";
                    break;
                case "Zaban":
                    result = " جاده ای";
                    break;
                case "Rl":
                    result = " ریلی";
                    break;
                case "Dn":
                    result = " دریایی";
                    break;
                case "Dl":
                    result = " دریایی";
                    break;
                case "ZDF":
                    result = " جاده ای";
                    break;
                case "Dghco":
                    result = " دریایی";
                    break;
                case "Hl":
                    result = " هوایی";
                    break;
                case "Tj":
                    result = "تخلیه/بارگیری";
                    break;
                case "Tk":
                    result = "تخلیه/بارگیری";
                    break;
                case "Ts":
                    result = "تخلیه/بارگیری ";
                    break;
                case "Tr":
                    result = "ترخیص";
                    break;
                case "ChandVajhiSabok":
                    result = " چند وجهی سبک";
                    break;
                case "ChandVajhiSangin":
                    result = " چند وجهی سنگین";
                    break;
                case "Bazdid":
                    result = "بازدید مسیر";
                    break;
            }
            return result;
        }

        public string GeTypeInFarsi(string inquiryType)
        {
            string result = string.Empty;
            switch (inquiryType)
            {
                case "Zadghan":
                    result = "استعلام زدغن";
                    break;
                case "Zadghal":
                    result = "استعلام زدغل";
                    break;
                case "Zaban":
                    result = "استعلام زبن";
                    break;
                case "Rl":
                    result = "استعلام رل";
                    break;
                case "Dn":
                    result = "استعلام دن";
                    break;
                case "Dl":
                    result = "استعلام دل";
                    break;
                case "ZDF":
                    result = "استعلام زدف";
                    break;
                case "Dghco":
                    result = "استعلام دغک";
                    break;
                case "Hl":
                    result = "استعلام هل";
                    break;
                case "Tj":
                    result = "استعلام تج";
                    break;
                case "Tk":
                    result = "استعلام تک";
                    break;
                case "Ts":
                    result = "استعلام تس";
                    break;
                case "Tr":
                    result = "استعلام تر";
                    break;
                case "ChandVajhiSabok":
                    result = "استعلام چند وجهی سبک";
                    break;
                case "ChandVajhiSangin":
                    result = "استعلام چند وجهی سنگین";
                    break;
                case "Bazdid":
                    result = "بازدید";
                    break;
            }
            return result;
        }

        public string ContentForEtelaresaniReplyToInquiry(DataClassesDataContext context, string irtiId)
        {
            string matneAsli = CurrentTxtMatnePishnahad();

            var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                where i.Id == Convert.ToInt32(irtiId)
                select i).Single();

            var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                where i.Id == irti.ReplyToInquiryId
                select i).Single();

            var myInquiryList = from i in context.MyDnn_EHaml_Inquiries
                where i.Id == Convert.ToInt32(irti.InquiryId)
                select
                    new
                    {
                        Id = i.Id,
                        Type = i.InquiryType,
                        Date = getActionDateForMatnEtelaResani(i.ActionDate),
                        Mabda = i.StartingPoint ?? "",
                        Magsad = i.Destination ?? "",
                        Mahmoole = i.LoadType ?? "",
                    };

            string etelaateInquiry = string.Empty;
            foreach (var item in myInquiryList)
            {
                string date = "تاریخ " + item.Date;
                string type = GeTypeInFarsi(item.Type);
                etelaateInquiry = (
                    "ردیف: " + item.Id + " - " + type + " ، " + date + "| از: " + item.Mabda +
                    " به: " + item.Magsad + " | محموله:" + item.Mahmoole);
            }

//            string header =string.Format(
//                @"<div style=' text-align: right; font-family: tahoma;direction: rtl;'>{0}:</div><br>",
//                CurrentTxtOnvanePishnahad());

            matneAsli = matneAsli.Replace("[JoziyateEstelam]", etelaateInquiry);
            matneAsli = matneAsli.Replace("[AddressSite]", @"<a href=""www.ehaml.com"">سایت</a>");
            matneAsli = matneAsli.Replace("[TarikheDaryaftePishnahad]", rti.CreateDate.ToShortDateString());

            string content =
                string.Format(@"<div style='text-align: right;font-family: tahoma;direction: rtl;'>{0}</div>",
                    matneAsli);
            return content;
        }

        public string ContentForEtelaresaniReplyToInquirySMS(DataClassesDataContext context, string irtiId)
        {
            string matneAsli = CurrentTxtMatnePishnahadSMS();

            var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                where i.Id == Convert.ToInt32(irtiId)
                select i).Single();

            var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                where i.Id == irti.ReplyToInquiryId
                select i).Single();

            var myInquiryList = from i in context.MyDnn_EHaml_Inquiries
                where i.Id == Convert.ToInt32(irti.InquiryId)
                select
                    new
                    {
                        Id = i.Id,
                        Type = i.InquiryType,
                        Date = getActionDateForMatnEtelaResani(i.ActionDate),
                        Mabda = i.StartingPoint ?? "",
                        Magsad = i.Destination ?? "",
                        Mahmoole = i.LoadType ?? "",
                    };

            string etelaateInquiry = string.Empty;
            foreach (var item in myInquiryList)
            {
                string date = "تاریخ " + item.Date;
                string type = GeTypeInFarsi(item.Type);
                etelaateInquiry = (
                    "ردیف: " + item.Id + " - " + type + " ، " + date + "| از: " + item.Mabda +
                    " به: " + item.Magsad + " | محموله:" + item.Mahmoole);
            }

            //            string header =string.Format(
            //                @"<div style=' text-align: right; font-family: tahoma;direction: rtl;'>{0}:</div><br>",
            //                CurrentTxtOnvanePishnahad());

            matneAsli = matneAsli.Replace("[JoziyateEstelam]", etelaateInquiry);
            matneAsli = matneAsli.Replace("[AddressSite]", @"<a href=""www.ehaml.com"">سایت</a>");
            matneAsli = matneAsli.Replace("[TarikheDaryaftePishnahad]", rti.CreateDate.ToShortDateString());

            string content =
                string.Format(@"<div style='text-align: right;font-family: tahoma;direction: rtl;'>{0}</div>",
                    matneAsli);
            return content;
        }

        private string getActionDateForMatnEtelaResani(DateTime? actionDate)
        {
            DateTime? datetime = actionDate;

            if (!datetime.HasValue)
            {
                return "";
            }
            else
            {
                return datetime.Value.ToShortDateString();
            }
        }


        public string ContentForEtelaresaniTaeedReply(DataClassesDataContext context, string irtiId,
            long mablag)
        {
            Util util = new Util();
            using (context)
            {
                var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.Id == Convert.ToInt32(irtiId)
                    select i).Single();

                var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                    where i.Id == irti.ReplyToInquiryId
                    select i).Single();

                string matneAsli = CurrentTxtMatneTaeidPishnahad();

                MyDnn_EHaml_Inquiry inquiry =
                    (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        join x in context.MyDnn_EHaml_Inquiries on i.InquiryId equals x.Id
                        where i.Id == Convert.ToInt32(irtiId)
                        select x).Single();


                var myInquiryList = from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == Convert.ToInt32(inquiry.Id)
                    select
                        new
                        {
                            Id = i.Id,
                            Type = i.InquiryType,
                            Date = getActionDateForMatnEtelaResani(rti.ZamaneAmadegiBarayeShooroo),
                            Mabda = i.StartingPoint ?? "",
                            Magsad = i.Destination ?? "",
                            Mahmoole = i.LoadType ?? "",
                        };

                string etelaateInquiry = string.Empty;
                foreach (var item in myInquiryList)
                {
                    string date = "تاریخ " + item.Date;
                    string type = GeTypeInFarsi(item.Type);
                    etelaateInquiry = (type + " ، " + date + "| از: " + item.Mabda +
                                       " به: " + item.Magsad + " | محموله:" + item.Mahmoole);
                }


                //                string header =
                //                    @"<div style=' text-align: right; font-family: tahoma;direction: rtl;'>دریافت پاسخ جدید از یک صاحب بار برای  تایید پاسخ شما به استعلام:</div><br>";

                //matneAsli = matneAsli.Replace("[JoziyateEstelam]", etelaateInquiry);
                //matneAsli = matneAsli.Replace("[AddressSite]", @"<a href=""www.ehaml.com"">سایت</a>");
                //matneAsli = matneAsli.Replace("[TarikheTaeedPishnahad]", inquiry.AcceptedDate.Value.ToShortDateString());

                //Util util = new Util();

                string MizaneBedehKari =
                    util.getUserMizaneBedehkari(util.GetServantUserByInquiryReplyToInquiryId(Convert.ToInt32(irtiId)))
                        .ToString();
                //string khatePayin = "شما به موجب این تایید مبلغ [mablageTaeid] ریال بدهکار شدید.<br>تراز مالی شما در سابت [TarazeMali] ریال میباشد.";
                //khatePayin = khatePayin.Replace("[mablageTaeid]", mablag.ToString());
                //khatePayin = khatePayin.Replace("[TarazeMali]", MizaneBedehKari);

                //string content =
                //    string.Format(@"<div style='text-align: right;font-family: tahoma;direction: rtl;'>{0}<br>{1}</div>",
                //        matneAsli, khatePayin);

                string content =
                    string.Format(
                        "<p align='center' dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'>بسم الله الرحمن الرحيم</span></p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'><img height='97' src='http://ehaml.ir/Portals/0/Logo.png' style='line-height: 1.6em;' width='144' /></span></p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'><strong>کاربر گرامي؛ ([UserName])</strong></span></p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'>پاسخ استعلام شما با مشخصات ذيل مورد تاييد صاحب بار مربوطه قرار گرفته و اطلاعات تماسي شما براي ايشان ارسال شده است.</span></p> <table align='right' border='1' cellpadding='0' cellspacing='0' dir='rtl'> <tbody> <tr> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>شماره استعلام</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>نام استعلام</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>تاريخ تاييد</span></p> </td> </tr> <tr> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>[EsteLamId]</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>[EstelamName]</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>[TarikheTaeed]</span></p> </td> </tr> </tbody> </table> <div style='clear:both;'>&nbsp;</div> <p dir='RTL'>&nbsp;</p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'>صورتحساب بدهکاري شما به موجب اين تاييديه بدين شرح مي باشد:</span></p> <table align='right' border='1' cellpadding='0' cellspacing='0' dir='rtl'> <tbody> <tr> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>شماره استعلام</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>ميزان بدهکاري(ريال)</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>تاريخ بدهکاري</span></p> </td> </tr> <tr> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'><span style='text-align: center;'>[EsteLamId]</span></span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>[MizaneBedehkari]</span></p> </td> <td style='width:213px;'> <p dir='RTL' style='text-align: center;'><span style='font-family:tahoma,geneva,sans-serif;'>[TarikheBedehkari]</span></p> </td> </tr> </tbody> </table> <div style='clear:both;'>&nbsp;</div> <div style='clear: both; text-align: right;'><strong><span style='font-family:tahoma,geneva,sans-serif;'>.ريال ميباشد&nbsp;[TarazeMali] هم اکنون تراز مالي شما در سايت</span></strong></div> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'><span style='line-height: 1.6em;'>لطفا براي آگاهي بيشتر به داشبرد شخصي خود در</span><a href='http://ehaml.ir' style='font-family: tahoma, geneva, sans-serif; line-height: 1.6em;'>سايت</a><strong style='font-family: tahoma, geneva, sans-serif; line-height: 1.6em;'><u>&nbsp;</u></strong><span style='line-height: 1.6em;'>مراجه نماييد.</span></span></p> <p dir='RTL'>&nbsp;</p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'><strong>راه هاي تماس با ما:</strong></span></p> <p dir='RTL'><span style='font-family:tahoma,geneva,sans-serif;'>تلفن:88803015 021 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;پست الکترونيکي:<span dir='LTR'>info@ehaml.ir</span></span></p> <p><span style='font-family:tahoma,geneva,sans-serif;'>&quot;</span></p>");

                content = content.Replace("[UserName]",
                    UserController.GetUserById(0, util.GetServantUserByInquiryReplyToInquiryId(Convert.ToInt32(irtiId)))
                        .DisplayName);
                content = content.Replace("[EsteLamId]", inquiry.Id.ToString());
                content = content.Replace("[EstelamName]", etelaateInquiry);
                content = content.Replace("[TarikheTaeed]", inquiry.AcceptedDate.Value.ToShortDateString());
                content = content.Replace("[MizaneBedehkari]", mablag.ToString());
                content = content.Replace("[TarikheBedehkari]", inquiry.AcceptedDate.Value.ToShortDateString());
                content = content.Replace("[TarazeMali]", MizaneBedehKari);
                return content;
            }
        }

        public string ContentForEtelaresaniTaeedReplySMS(DataClassesDataContext context, string irtiId)
        {
            using (context)
            {
                var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.Id == Convert.ToInt32(irtiId)
                    select i).Single();

                var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                    where i.Id == irti.ReplyToInquiryId
                    select i).Single();

                string matneAsli = CurrentTxtMatneTaeidPishnahad();

                MyDnn_EHaml_Inquiry inquiry =
                    (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        join x in context.MyDnn_EHaml_Inquiries on i.InquiryId equals x.Id
                        where i.Id == Convert.ToInt32(irtiId)
                        select x).Single();


                var myInquiryList = from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == Convert.ToInt32(inquiry.Id)
                    select
                        new
                        {
                            Id = i.Id,
                            Type = i.InquiryType,
                            Date = getActionDateForMatnEtelaResani(rti.ZamaneAmadegiBarayeShooroo),
                            Mabda = i.StartingPoint ?? "",
                            Magsad = i.Destination ?? "",
                            Mahmoole = i.LoadType ?? "",
                        };

                string etelaateInquiry = string.Empty;
                foreach (var item in myInquiryList)
                {
                    string date = "تاریخ " + item.Date;
                    string type = GeTypeInFarsi(item.Type);
                    etelaateInquiry = (
                        "ردیف: " + item.Id + " - " + type + " ، " + date + "| از: " + item.Mabda +
                        " به: " + item.Magsad + " | محموله:" + item.Mahmoole);
                }


                //                string header =
                //                    @"<div style=' text-align: right; font-family: tahoma;direction: rtl;'>دریافت پاسخ جدید از یک صاحب بار برای  تایید پاسخ شما به استعلام:</div><br>";

                matneAsli = matneAsli.Replace("[JoziyateEstelam]", etelaateInquiry);
                matneAsli = matneAsli.Replace("[AddressSite]", @"<a href=""www.ehaml.com"">سایت</a>");
                matneAsli = matneAsli.Replace("[TarikheTaeedPishnahad]", inquiry.AcceptedDate.Value.ToShortDateString());

                string content =
                    string.Format(@"<div style='text-align: right;font-family: tahoma;direction: rtl;'>{0}</div>",
                        matneAsli);
                return content;
            }
        }

        public double GetDarsad(decimal? geymateKol, string inquiryType)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                double darsad = (int) (from i in context.MyDnn_EHaml_DarsadePoorsants
                    where i.InquiryType == inquiryType
                    select i.DarsadePoorsant).Single();

                return (double) ((double) geymateKol*((double) darsad/(double) 100));
            }
        }

        public int? MakeKhadamatresanBedehkar(MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry, int portalUserId,
            double mablageBedehkari, int userTakhfif, int type)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_BankTransactionDetail detail =
                    new MyDnn_EHaml_BankTransactionDetail();

                detail.InquiryReplyToInquiry_Id = inquiryReplyToInquiry.Id;
                detail.Khadamatresan_EHaml_User_Id = portalUserId;
                detail.Status = 3;

                context.MyDnn_EHaml_BankTransactionDetails.InsertOnSubmit(detail);
                context.SubmitChanges();

                MyDnn_EHaml__Bank bank = new MyDnn_EHaml__Bank();

                if (type > 0)
                {
                    bank.Type = 1;
                }
                else
                {
                    bank.Type = 0;
                }
                if (userTakhfif > 0)
                {
                    bank.Amount = (int?) (mablageBedehkari*(userTakhfif));
                }
                else
                {
                    bank.Amount = (int?) mablageBedehkari;
                }


                bank.EHaml_User_Id = portalUserId;
                bank.Description = "بابت انجام کار به عنوان خدمت رسان(اعلامیه)";
                bank.MyDnn_EHaml_BankTransactionDetail_Id = detail.Id;
                bank.Date = DateTime.Now.Date;
                context.MyDnn_EHaml__Banks.InsertOnSubmit(bank);
                context.SubmitChanges();

                return bank.Amount;
            }
        }

        public int getUserTakhfif(int? portalUserId)
        {
            return 0;
        }

        public double GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int tedaderooz = Convert.ToInt32((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadeRoozBadAzEtmameKarBarayeNemayesheNazarSanji"
                    select i.SettingValue).Single());

                return tedaderooz;
            }
        }

        public int GetServantUserByInquiryReplyToInquiryId(int inquiryReplyToInquiryId)
        {
            int serventUserId = 0;
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                serventUserId = (int) (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                    join x in context.MyDnn_EHaml_Users on j.MyDnn_EHaml_User_Id equals x.Id
                    where i.Id == inquiryReplyToInquiryId
                    select x.PortalUserId).Single();
                return serventUserId;
            }
        }

        public int GetUserEHamlUserIdByPortalId(int userId)
        {
            if (userId == -1)
            {
                return -1;
            }
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == userId
                    select i.Id).Single();
                return ehamlUserId;
            }
        }

        public DateTime? Calculate(int planId, DateTime now)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_SubscriptionPlan plan = (from i in context.MyDnn_EHaml_SubscriptionPlans
                    where i.Id == planId
                    select i).Single();

                return now.AddDays((double) plan.DayCount);
            }
        }

        public void MakeThisUserOk(int userId, string userStatus, string returnUrl, int userType)
        {
            Session["FinalReturnTabId"] = returnUrl;
            //ToDo Erjae karbar ba tavajoh be moshkeli ke dare be safeye monasebesh ya in ke peygame monaseb ro behesh neshoon bedim
            if (userStatus == "SubscribeNist")
            {
                HttpContext.Current.Response.Redirect("/default.aspx?tabid=" +
                                                      PortalController.GetPortalSettingAsInteger("SubscriptionTabId",
                                                          PortalId, -1) + "&type=" + userType);
            }
            else if (userStatus == "Bedehkare")
            {
                HttpContext.Current.Response.Redirect("/default.aspx?tabid=" +
                                                      PortalController.GetPortalSettingAsInteger("TasviyeTabId",
                                                          PortalId, -1) + "&type=" + userType);
            }
        }

        public void TanzimeBedehkariyeUser(int userId, DateTime? acceptedDate)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                string nahveheBarkhord = getNahveyeBarkhordBaBedehkari();

                if (nahveheBarkhord == "TedadeAmaliyat")
                {
                    if (
                        !context.MyDnn_EHaml_User_VaziyateBedehkaris.Any(
                            x => x.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)))
                    {
                        MyDnn_EHaml_User_VaziyateBedehkari bedehkari =
                            new MyDnn_EHaml_User_VaziyateBedehkari();
                        bedehkari.MyDnn_EHaml_User_Id = GetUserEHamlUserIdByPortalId(userId);
                        bedehkari.TedadeAmaliyateShameleBedehkari = 1;
                        context.MyDnn_EHaml_User_VaziyateBedehkaris.InsertOnSubmit(bedehkari);
                        context.SubmitChanges();
                    }
                    else
                    {
                        MyDnn_EHaml_User_VaziyateBedehkari bedehkari = (
                            from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                            where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)
                            select i).Single();

                        bedehkari.TedadeAmaliyateShameleBedehkari += 1;
                        context.SubmitChanges();
                    }
                }
                else
                {
                    if (
                        !context.MyDnn_EHaml_User_VaziyateBedehkaris.Any(
                            x => x.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)))
                    {
                        MyDnn_EHaml_User_VaziyateBedehkari bedehkari =
                            new MyDnn_EHaml_User_VaziyateBedehkari();
                        bedehkari.MyDnn_EHaml_User_Id = GetUserEHamlUserIdByPortalId(userId);
                        bedehkari.TarikheShoorooeBedehkari = acceptedDate;

                        context.MyDnn_EHaml_User_VaziyateBedehkaris.InsertOnSubmit(bedehkari);
                        context.SubmitChanges();
                    }
                    else
                    {
                        MyDnn_EHaml_User_VaziyateBedehkari bedehkari = (
                            from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                            where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(userId)
                            select i).Single();
                        if (bedehkari.TarikheShoorooeBedehkari == new DateTime(9999, 9, 9))
                        {
                            bedehkari.TarikheShoorooeBedehkari = acceptedDate;
                            context.SubmitChanges();
                        }
                    }
                }
            }
        }

        public static string GetCurrentKendoTheme()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                string result = (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentKendoTheme"
                    select i.SettingValue).Single();

                return "~/DesktopModules/MyDnn_EHaml/Styles/" + result;
            }
        }

        public string getNahveyeBarkhordBaBedehkari()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "NahveyeBarkhordBaBedehkari"
                    select i.SettingValue
                    ).Single();
            }
        }

        public void BarkhordBaBedehkari()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                List<MyDnn_EHaml_User_VaziyateBedehkari> list = null;
                string NahveyeBarkhordBaBedehkari = getNahveyeBarkhordBaBedehkari();
                int tedadeAmaliyateMojaz = getTedadeAmaliyateMojaz();
                int tedadRoozBadAzAvalinBedehkari = getTedadeRoozeMojazeBadAzBedehkari();

                if (NahveyeBarkhordBaBedehkari == "TedadeAmaliyat")
                {
                    list =
                        (from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                            where i.TedadeAmaliyateShameleBedehkari >= tedadeAmaliyateMojaz
                            select i).ToList();

                    string content = @"<div><h4>کاربر گرامی [DisplayName]</h4><p>
                                        مطابق قوانین سایت مهلت استفاده شما از امکانات در حالت بدهکاری به پایان رسیده است.
                                        هم اکنون مهلت استفاده از امکانات [Tedad] بار بعد از اولین بدهکاری شماست.
                                        میزان بدهکاری شما هم اکنون معادل [MizaneBedehkari] ریال می باشد.
                                        لطفآ برای تسویه حساب از طریق لینک زیر اقدام نمایید.
                                        </p>
                                        <a href=[LinkeTasviyeHesab]>تسویه حساب</a>
                                        </div>";

                    SendMailToBedehkarhaForTasviye(content, list, "TedadeAmaliyat");
                }
                else
                {
                    list = (from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                        where
                            i.TarikheShoorooeBedehkari.Value.AddDays(tedadRoozBadAzAvalinBedehkari).Date >=
                            DateTime.Now.Date
                        select i).ToList();

                    //Todo

                    string content = @"<div><h4>کاربر گرامی [DisplayName]</h4><p>
                                        مطابق قوانین سایت مهلت استفاده شما از امکانات در حالت بدهکاری به پایان رسیده است.
                                        هم اکنون مهلت استفاده از امکانات [TedadRooz] روز بعد از اولین بدهکاری شماست.
                                        میزان بدهکاری شما هم اکنون معادل [MizaneBedehkari] ریال می باشد.
                                        لطفآ برای تسویه حساب از طریق لینک زیر اقدام نمایید.
                                        </p>
                                        <a href=[LinkeTasviyeHesab]>تسویه حساب</a>
                                        </div>";

                    SendMailToBedehkarhaForTasviye(content, list, "");
                }
            }
        }


        private void SendMailToBedehkarhaForTasviye(string content,
            List<MyDnn_EHaml_User_VaziyateBedehkari> list, string type)
        {
            foreach (MyDnn_EHaml_User_VaziyateBedehkari item in list)
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    UserInfo userInfo = UserController.GetUserById(this.PortalId,
                        (int) (from i in context.MyDnn_EHaml_Users
                            where i.Id == item.MyDnn_EHaml_User_Id
                            select i.PortalUserId).Single());
                    long userMizaneBedehkari = getUserMizaneBedehkari(userInfo.UserID);

                    string mailContent = string.Empty;

                    if (userMizaneBedehkari < 0)
                    {
                        if (type == "TedadeAmaliyat")
                        {
                            mailContent =
                                content.Replace("[DisplayName]", userInfo.DisplayName)
                                    .Replace("[Tedad]", getTedadeAmaliyateMojaz().ToString())
                                    .Replace("[LinkeTasviyeHesab]",
                                        PortalController.GetPortalSettingAsInteger("SubscriptionTabId", this.PortalId,
                                            -1)
                                            .ToString())
                                    .Replace("[MizaneBedehkari]", userMizaneBedehkari.ToString());
                        }
                        else
                        {
                            mailContent =
                                content.Replace("[DisplayName]", userInfo.DisplayName)
                                    .Replace("[TedadRooz]", getTedadeRoozeMojazeBadAzBedehkari().ToString())
                                    .Replace("[LinkeTasviyeHesab]",
                                        PortalController.GetPortalSettingAsInteger("SubscriptionTabId", this.PortalId,
                                            -1)
                                            .ToString())
                                    .Replace("[MizaneBedehkari]", userMizaneBedehkari.ToString());
                        }


                        DotNetNuke.Services.Mail.MailFormat _mailFormat = DotNetNuke.Services.Mail.MailFormat.Html;
                        bool SMTPEnableSSL =
                            DotNetNuke.Entities.Host.Host.GetHostSettingsDictionary()["SMTPEnableSSL"] == "Y";

                        SendMail("info@ehaml.ir", userInfo.Email, "", "", "info@ehaml.ir",
                            DotNetNuke.Services.Mail.MailPriority.Normal, "فرا رسیدن وقت تسویه",
                            _mailFormat,
                            System.Text.Encoding.UTF8, mailContent, "", "", "", "", SMTPEnableSSL);
                    }
                }
            }
        }

        public long getUserMizaneBedehkari(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml__Bank bank = (from i in context.MyDnn_EHaml__Banks
                    where i.EHaml_User_Id == (userId)
                    select i).FirstOrDefault();

                int bedehkari = 0;
                int varizi = 0;

                if (bank != null)
                {
                    if (context.MyDnn_EHaml__Banks.Any(x => x.Type == 0 && x.EHaml_User_Id == userId))
                    {
                        bedehkari = (int) (from i in context.MyDnn_EHaml__Banks
                            join j in context.MyDnn_EHaml_BankTransactionDetails on
                                i.MyDnn_EHaml_BankTransactionDetail_Id
                                equals j.Id
                            where i.EHaml_User_Id == userId && j.Status != 0 && i.Type == 0
                            select i.Amount).Sum();
                    }

                    if ((from i in context.MyDnn_EHaml__Banks
                        where i.EHaml_User_Id == userId && i.Type > 0
                        select i).Any())

                    {
                        varizi = (int) (from i in context.MyDnn_EHaml__Banks
                            where i.EHaml_User_Id == userId && i.Type > 0
                            select i.Amount).Sum();
                    }
                    else
                    {
                        varizi = 0;
                    }


                    return (varizi - bedehkari);
                }
                else
                {
                    return int.MinValue;
                }
            }
        }

        private int getTedadeRoozeMojazeBadAzBedehkari()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return Convert.ToInt32((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadRoozBadAzAvalinBedehkari"
                    select i.SettingValue).Single());
            }
        }

        public int getTedadeAmaliyateMojaz()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return Convert.ToInt32((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadAmaliyateBadAzAvalinBedehkari"
                    select i.SettingValue).Single());
            }
        }

        public void TasviyeKonInKarBarRa(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml__Bank bank = (from i in context.MyDnn_EHaml__Banks
                    where i.EHaml_User_Id == (userId)
                    select i).FirstOrDefault();

                if (bank != null)
                {
                    var result = (from i in context.MyDnn_EHaml__Banks
                        join j in context.MyDnn_EHaml_BankTransactionDetails on i.MyDnn_EHaml_BankTransactionDetail_Id
                            equals j.Id
                        where i.EHaml_User_Id == userId && j.Status != 0 && i.Type == 0
                        select i.Amount).Sum();

                    int bedehkari = (int) (result);

                    bank = new MyDnn_EHaml__Bank();
                    bank.Amount = bedehkari;
                    bank.EHaml_User_Id = GetUserEHamlUserIdByPortalId(userId);
                    bank.Approve = true;
//                    bank.Date = DateTime.Now;
                    bank.Description = "پرداخت جهت تسویه از طریق درگاه بانگ";
                    bank.Type = 2;

                    context.MyDnn_EHaml__Banks.InsertOnSubmit(bank);
                    context.SubmitChanges();

                    MyDnn_EHaml_User_VaziyateBedehkari vaziyateBedehkari =
                        (from i in context.MyDnn_EHaml_User_VaziyateBedehkaris
                            where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId(this.UserId)
                            select i).Single();
                    string nahveyeBarkhord = getNahveyeBarkhordBaBedehkari();
                    if (nahveyeBarkhord == "TedadeAmaliyat")
                    {
                        vaziyateBedehkari.TedadeAmaliyateShameleBedehkari = 0;
                    }
                    else
                    {
                        vaziyateBedehkari.TarikheShoorooeBedehkari = new DateTime(9999, 9, 9);
                    }

                    context.SubmitChanges();
                }
            }
        }

        private static void UpdateCurrentLabelFontSize(string LabelFontSize, DataClassesDataContext context)
        {
            var CurrentLabelFontSize = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentLabelFontSize"
                select i).Single();
            CurrentLabelFontSize.SettingValue = LabelFontSize;
            context.SubmitChanges();
        }

        private static void UpdateCureentLableFontColor(Color LabelFontColor, DataClassesDataContext context)
        {
            var CureentLableFontColor = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CureentLableFontColor"
                select i).Single();
            CureentLableFontColor.SettingValue = ColorTranslator.ToHtml(LabelFontColor);
            context.SubmitChanges();
        }

        private static void UpdateFontLabel(string FontLabel, DataClassesDataContext context)
        {
            var CurentLabelFont = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurentLabelFont"
                select i).Single();
            CurentLabelFont.SettingValue = FontLabel;
            context.SubmitChanges();
        }

        private static void UpdateKendoTheme(string KendoTheme, DataClassesDataContext context)
        {
            var Kendo = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentKendoTheme"
                select i).Single();
            Kendo.SettingValue = KendoTheme;
            context.SubmitChanges();
        }

        public string getCurrentlabelFontName()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurentLabelFont"
                    select i.SettingValue).Single();
            }
        }

        public string getCurrentKendoTheme()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentKendoTheme"
                    select i.SettingValue).Single();
            }
        }

        public string getCurrentTextBoxFontName()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxFont"
                    select i.SettingValue).Single();
            }
        }

        private static void UpdateTextBoxBackgroundColor(Color TextBoxBackgroundColor,
            DataClassesDataContext context)
        {
            var textboxBackgroundColor = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentTextBoxBackgroundColor"
                select i).Single();

            textboxBackgroundColor.SettingValue = ColorTranslator.ToHtml(TextBoxBackgroundColor);
            context.SubmitChanges();
        }

        private static void UpdateTextBoxFontColor(Color TextBoxFontColor, DataClassesDataContext context)
        {
            var textboxfontcolor = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentTextBoxFontColor"
                select i).Single();

            textboxfontcolor.SettingValue = ColorTranslator.ToHtml(TextBoxFontColor);
            context.SubmitChanges();
        }

        private static void UpdateCurrentTextBoxWidth(string TextBoxWidth, DataClassesDataContext context)
        {
            var textboxwidth = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentTextBoxWidth"
                select i).Single();
            textboxwidth.SettingValue = TextBoxWidth;
            context.SubmitChanges();
        }

        private static void UpdateCurrentTextboxHeight(string TextBoxHeight, DataClassesDataContext context)
        {
            var textboxheight = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentTextBoxHeight"
                select i).Single();
            textboxheight.SettingValue = TextBoxHeight;
            context.SubmitChanges();
        }

        private static void UpdateCurrentTextBoxFontSize(string TextBoxFontSize, DataClassesDataContext context)
        {
            var textboxfontsize = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "CurrentTextBoxFontSize"
                select i).Single();
            textboxfontsize.SettingValue = TextBoxFontSize;
            context.SubmitChanges();
        }

        public string GetTedadeRoozBarayeNemayeshDarListBadAzNemayesheNazarSanji()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji"
                    select i.SettingValue).Single();
            }
        }

        public void UpdateSettings(string KendoTheme, string FontLabel, string LabelFontSize, Color LabelFontColor,
            string TextBoxFontSize, Color TextBoxFontColor, Color TextBoxBackgroundColor, string TextBoxWidth,
            string TextBoxHeight, string NahveyeBarkhordBaBedehkarha, string NahveyeBarkhordBaBedehkarhaValue,
            string TedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji,
            string TedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji, NameValueCollection poorsantNameBValue,
            string ShomareTerminal, string ShomarePazirande, string KelideEkhtesasi, string AddressePazgashtAzBank,
            string txtOnvanePishnahad, string txtMatnePishnahad, string txtOnvaneTaeidPishnahad,
            string txtMatneTaeidPishnahad, string txtOnvaneEMailLinkeTaeed, string txtMatneEMailLinkeTaeed,
            string txtMatnePishnahadSMS, string txtMatneTaeidPishnahadSMS)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                UpdateKendoTheme(KendoTheme, context);

                UpdateFontLabel(FontLabel, context);

                UpdateCureentLableFontColor(LabelFontColor, context);

                UpdateCurrentLabelFontSize(LabelFontSize, context);

                UpdateCurrentTextBoxFontSize(TextBoxFontSize, context);

                UpdateCurrentTextboxHeight(TextBoxHeight, context);

                UpdateCurrentTextBoxWidth(TextBoxWidth, context);

                UpdateTextBoxFontColor(TextBoxFontColor, context);

                UpdateTextBoxBackgroundColor(TextBoxBackgroundColor, context);

                UpdateNahveyeBarkhordBaBedehkarha(NahveyeBarkhordBaBedehkarha, context);

                UpdateNahveyeBarkhordBaBedehkarhaValue(NahveyeBarkhordBaBedehkarha, NahveyeBarkhordBaBedehkarhaValue,
                    context);

                UpdateTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji(
                    TedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji, context);

                UpdateTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji(
                    TedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji, context);


                UpdatePoorsantTable(poorsantNameBValue, context);


                UpdateShomarePazirande(ShomarePazirande, context);
                UpdateKelideEkhtesasi(KelideEkhtesasi, context);
                UpdateAddressePazgashtAzBank(AddressePazgashtAzBank, context);

                UpdateTxtOnvanePishnahad(txtOnvanePishnahad, context);
                UpdateTxtMatnePishnahad(txtMatnePishnahad, context);

                UpdateTxtOnvaneTaeidPishnahad(txtOnvaneTaeidPishnahad, context);
                UpdateTxtMatneTaeidPishnahad(txtMatneTaeidPishnahad, context);

                UpdateTxtOnvaneEMailLinkeTaeed(txtOnvaneEMailLinkeTaeed, context);
                UpdateTxtMatneEMailLinkeTaeed(txtMatneEMailLinkeTaeed, context);

                UpdateTxtMatnePishnahadSMS(txtMatnePishnahadSMS, context);
                UpdateTxtMatneTaeidPishnahadSMS(txtMatneTaeidPishnahadSMS, context);
            }
        }

        private void UpdateTxtMatneTaeidPishnahadSMS(string txtMatneTaeidPishnahadSms,
            DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtMatneTaeidPishnahadSms"
                select i).Single();

            obj.SettingValue = txtMatneTaeidPishnahadSms;

            context.SubmitChanges();
        }

        private void UpdateTxtMatnePishnahadSMS(string txtMatnePishnahadSms, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtMatnePishnahadSms"
                select i).Single();

            obj.SettingValue = txtMatnePishnahadSms;

            context.SubmitChanges();
        }

        private void UpdateTxtMatneEMailLinkeTaeed(string txtMatneEMailLinkeTaeed, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtMatneEMailLinkeTaeed"
                select i).Single();

            obj.SettingValue = txtMatneEMailLinkeTaeed;

            context.SubmitChanges();
        }

        private void UpdateTxtOnvaneEMailLinkeTaeed(string txtOnvaneEMailLinkeTaeed,
            DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtOnvaneEMailLinkeTaeed"
                select i).Single();

            obj.SettingValue = txtOnvaneEMailLinkeTaeed;

            context.SubmitChanges();
        }

        private void UpdateTxtMatneTaeidPishnahad(string txtMatneTaeidPishnahad, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtMatneTaeidPishnahad"
                select i).Single();

            obj.SettingValue = txtMatneTaeidPishnahad;

            context.SubmitChanges();
        }

        private void UpdateTxtOnvaneTaeidPishnahad(string txtOnvaneTaeidPishnahad, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtOnvaneTaeidPishnahad"
                select i).Single();

            obj.SettingValue = txtOnvaneTaeidPishnahad;

            context.SubmitChanges();
        }

        private void UpdateTxtMatnePishnahad(string txtMatnePishnahad, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtMatnePishnahad"
                select i).Single();

            obj.SettingValue = txtMatnePishnahad;

            context.SubmitChanges();
        }

        private void UpdateTxtOnvanePishnahad(string txtOnvanePishnahad, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "txtOnvanePishnahad"
                select i).Single();

            obj.SettingValue = txtOnvanePishnahad;

            context.SubmitChanges();
        }

        private void UpdateAddressePazgashtAzBank(string addressePazgashtAzBank, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "AddressePazgashtAzBank"
                select i).Single();

            obj.SettingValue = addressePazgashtAzBank;

            context.SubmitChanges();
        }

        private void UpdateKelideEkhtesasi(string kelideEkhtesasi, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "KelideEkhtesasi"
                select i).Single();

            obj.SettingValue = kelideEkhtesasi;

            context.SubmitChanges();
        }

        private void UpdateShomarePazirande(string shomareTerminal, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "ShomarePazirande"
                select i).Single();

            obj.SettingValue = shomareTerminal;

            context.SubmitChanges();
        }

        private void UpdateShomareTerminal(string shomarePazirande, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "ShomareTerminal"
                select i).Single();

            obj.SettingValue = shomarePazirande;

            context.SubmitChanges();
        }

        private static void UpdatePoorsantTable(NameValueCollection poorsantNameBValue,
            DataClassesDataContext context)
        {
            foreach (string key in poorsantNameBValue)
            {
                string InquiryType = key;
                string DarsadePoorsant = poorsantNameBValue[key];

                var obj = (from i in context.MyDnn_EHaml_DarsadePoorsants
                    where i.InquiryType == InquiryType
                    select i).Single();

                obj.DarsadePoorsant = Convert.ToInt32(DarsadePoorsant);
                context.SubmitChanges();
            }
        }

        private void UpdateTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji(
            string tedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "TedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji"
                select i).Single();

            obj.SettingValue = tedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji;

            context.SubmitChanges();
        }

        private void UpdateTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji(
            string tedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji, DataClassesDataContext context)
        {
            var obj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "TedadeRoozBadAzEtmameKarBarayeNemayesheNazarSanji"
                select i).Single();

            obj.SettingValue = tedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji;

            context.SubmitChanges();
        }

        private static void UpdateNahveyeBarkhordBaBedehkarhaValue(string NahveyeBarkhordBaBedehkarha,
            string NahveyeBarkhordBaBedehkarhaValue, DataClassesDataContext context)
        {
            var obj = new MyDnn_EHaml_GeneralSetting();
            if (NahveyeBarkhordBaBedehkarha == "TedadeAmaliyat")
            {
                obj = (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadAmaliyateBadAzAvalinBedehkari"
                    select i).Single();
            }
            else
            {
                obj = (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "TedadRoozBadAzAvalinBedehkari"
                    select i).Single();
            }
            obj.SettingValue = NahveyeBarkhordBaBedehkarhaValue;
            context.SubmitChanges();
        }

        private void UpdateNahveyeBarkhordBaBedehkarha(string nahveyeBarkhordBaBedehkarha,
            DataClassesDataContext context)
        {
            var nahveyeBarkhordBaBedehkarhaObj = (from i in context.MyDnn_EHaml_GeneralSettings
                where i.SettingName == "NahveyeBarkhordBaBedehkari"
                select i).Single();

            nahveyeBarkhordBaBedehkarhaObj.SettingValue = nahveyeBarkhordBaBedehkarha;
            context.SubmitChanges();
        }

        public string getCurrentAddresseBazgashtAzBank()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "AddressePazgashtAzBank"
                    select i.SettingValue).Single();
            }
        }

        public string getCurrentKelideEkhtesasi()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "KelideEkhtesasi"
                    select i.SettingValue).Single();
            }
        }

        public string getCurrentShomarePazirande()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "ShomarePazirande"
                    select i.SettingValue).Single();
            }
        }

        public string getCurrentShomareTerminal()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "ShomareTerminal"
                    select i.SettingValue).Single();
            }
        }

        public void MackeUserSubscribe(int userType, int plan)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                int planId = plan;
                MyDnn_EHaml_Subscription subscription = new MyDnn_EHaml_Subscription();
                subscription.PaymentDate = DateTime.Now;
                subscription.MyDnn_EHaml_User_Id = GetUserEHamlUserIdByPortalId(UserId);
                subscription.SubscriptionPlan_Id = planId;
                if (planId < 5)
                {
                    subscription.ExpireDate = Calculate(planId, DateTime.Now);
                }
                subscription.UserType = (byte?) userType;

                context.MyDnn_EHaml_Subscriptions.InsertOnSubmit(subscription);
                context.SubmitChanges();
            }
        }

        public void MackeUserSubscribe2(int userType, int plan, int userId)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                int planId = plan;
                MyDnn_EHaml_Subscription subscription = new MyDnn_EHaml_Subscription();
                subscription.PaymentDate = DateTime.Now;
                subscription.MyDnn_EHaml_User_Id = GetUserEHamlUserIdByPortalId(userId);
                subscription.SubscriptionPlan_Id = planId;
                if (planId < 5)
                {
                    subscription.ExpireDate = Calculate(planId, DateTime.Now);
                }
                subscription.UserType = (byte?) userType;

                context.MyDnn_EHaml_Subscriptions.InsertOnSubmit(subscription);
                context.SubmitChanges();
            }
        }

        internal string GetUserStatus(int? userId, byte type)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var status = (from i in context.MyDnn_EHaml_UserRanks
                    where i.MyDnn_EHaml_User_Id == GetUserEHamlUserIdByPortalId((int) userId)
                          && i.Type == type
                    select i.Power + "|" + (i.Quality).ToString().Substring(0, 3)).SingleOrDefault();

                return status;
            }
        }

        public void SendAppLinkToUserMail(int userId, string linkAddress)
        {
            DotNetNuke.Services.Mail.MailFormat _mailFormat = DotNetNuke.Services.Mail.MailFormat.Html;
            bool SMTPEnableSSL =
                DotNetNuke.Entities.Host.Host.GetHostSettingsDictionary()["SMTPEnableSSL"] == "Y";
            UserInfo info = UserController.GetUserById(this.PortalId, userId);


            string mailContent = CurrentTxtMatneEMailLinkeTaeed();

            string realLink = string.Format(@"<a href=""{0}"">لینک فعال سازی</a>", linkAddress);
            mailContent = mailContent.Replace("[FaalsaziLink]", realLink);

            mailContent = string.Format(@"<div style=""text-align:right;font-family:tahoma;direction:rtl;"">{0}</div>",
                mailContent);

            SendMail("info@ehaml.ir", info.Email, "", "", "info@ehaml.ir",
                DotNetNuke.Services.Mail.MailPriority.Normal, CurrentTxtOnvaneEMailLinkeTaeed(),
                _mailFormat,
                System.Text.Encoding.UTF8, mailContent, "", "", "", "", SMTPEnableSSL);
        }

        public string getUserAppCode(int EHamlUserIdByPortalId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_Users
                    where i.Id == EHamlUserIdByPortalId
                    select i.AppCode).Single();
            }
        }

        //public int getGeymateKol(NameValueCollection collection)
        //{
        //    int getmayNahayi = 0;
        //    foreach (string key in collection)
        //    {
        //        int tedad = int.Parse(key);
        //        int geymatekol = tedad*int.Parse(collection[key]);
        //        getmayNahayi += geymatekol;
        //    }

        //    return getmayNahayi;
        //}

        //public int GetTedadeVasileyeHamFromString(string noeVasileyeHaml, string zadghan)
        //{
        //    string tedad = zadghan.Substring(zadghan.IndexOf("("))
        //}
        public string getPool(string pool)
        {
            return pool;
        }

        public int GetVaziyateInRely(int id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (int) (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.ReplyToInquiryId == id
                    select i.Status).Single();
            }
        }

        internal int GetTedadePasokhHayeResideBarayeYekEstelam(int inqId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.InquiryId == inqId
                    select i).Count();
            }
        }

        internal int GetNazareKoliBadKhadamatBeSaheb(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                    join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                    where h.MyDnn_EHaml_User_Id == EuserId
                          && g.NazareKoli == false
                    select g).Count();
            }
        }

        internal int GetNazareKoliBadSahebBeKhadamat(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from g in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                    join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                    where h.ServantUserId == EuserId
                          && g.NazareKoli == false
                    select g).Count();
            }
        }

        internal int GetNazareKoliKhoobKhadamatBeSaheb(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                    join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                    where h.MyDnn_EHaml_User_Id == EuserId
                          && g.NazareKoli == true
                    select g).Count();
            }
        }

        internal int GetNazareKoliKhoobSahebBeKhadamat(int EuserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var result = (from g in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                    join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                    where h.ServantUserId == EuserId
                          && g.NazareKoli == true
                    select g).Count();

                return result;
            }
        }

        public string GetNameKhadamatResan(int myDnnEHamlUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int userPortalId = (int) (from i in context.MyDnn_EHaml_Users
                    where i.Id == myDnnEHamlUserId
                    select i.PortalUserId).Single();
                UserInfo info = UserController.GetUserById(this.PortalId, userPortalId);
                if (!string.IsNullOrEmpty(info.Profile.GetPropertyValue("Company")) &&
                    !string.IsNullOrWhiteSpace(info.Profile.GetPropertyValue("Company")))
                {
                    return info.Profile.GetPropertyValue("Company");
                }
                else
                {
                    return info.DisplayName;
                }
            }
        }

        internal int GetVaziyateNazarSanjiSahebBeKhadamat(int irti)
        {
            int tedadroozbadazetmam = (int) GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji();

            int result = 0;
            using (var context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var irtiObj = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.Id == irti
                    select i).SingleOrDefault();

                bool isInThere = (from i in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                    where i.Inquiry_Id == irtiObj.InquiryId
                          && i.ReplyToInquiry_Id == irtiObj.ReplyToInquiryId
                    select i).Any();

                if (isInThere)
                {
                    result = 0;
                }
                else
                {
                    var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                        where i.Id == irtiObj.ReplyToInquiryId
                        select i).Single();

                    if (
                        rti.ZamaneAmadegiBarayeShooroo.Value.AddDays(Convert.ToDouble(rti.KoleModatZamaneHaml))
                            .AddDays(tedadroozbadazetmam) <= DateTime.Today.Date)
                    {
                        result = 1;
                    }
                    else
                    {
                        result = 2;
                    }
                }

                return result;
            }
        }

        internal int GetVaziyateNazarSanjiKhadamatBeSaheb(int irti)
        {
            int tedadroozbadazetmam = (int) GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji();

            int result = 0;
            using (var context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var irtiObj = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    where i.Id == irti
                    select i).SingleOrDefault();

                bool isInThere = (from i in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                    where i.Inquiry_Id == irtiObj.InquiryId
                          && i.ReplyToInquiry_Id == irtiObj.ReplyToInquiryId
                    select i).Any();

                if (isInThere)
                {
                    result = 0;
                }
                else
                {
                    var rti = (from i in context.MyDnn_EHaml_ReplyToInquiries
                        where i.Id == irtiObj.ReplyToInquiryId
                        select i).Single();

                    if (
                        rti.ZamaneAmadegiBarayeShooroo.Value.AddDays(Convert.ToDouble(rti.KoleModatZamaneHaml))
                            .AddDays(tedadroozbadazetmam) <= DateTime.Today.Date)
                    {
                        result = 1;
                    }
                    else
                    {
                        result = 2;
                    }
                }

                return result;
            }
        }

        public int GetVaziyateNazarSanjiSahebBeKhadamatElamiye(int erteid)
        {
            int tedadroozbadazetmam = (int) GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji();

            int result = 0;
            using (var context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var erteObj = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                    where i.Id == erteid
                    select i).SingleOrDefault();

                bool isInThere = (from i in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                    where i.ERTEID == erteObj.Id
                    select i).Any();

                if (isInThere)
                {
                    result = 0;
                }
                else
                {
                    string elamiyeType = erteObj.ElamiyeType;
                    if (elamiyeType.Contains("Jadei") || elamiyeType.Contains("جاده ای"))
                    {
                        var rteJ = (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis
                            where i.Id == erteObj.ReplyToElamiyeId
                            select i).Single();

                        DateTime zaman = DateTime.Parse(
                            rteJ.VasileyeHamleMoredeNiyaz.Substring(rteJ.VasileyeHamleMoredeNiyaz.LastIndexOf(",") + 1,
                                ((rteJ.VasileyeHamleMoredeNiyaz.LastIndexOf(")") - 2) -
                                 rteJ.VasileyeHamleMoredeNiyaz.LastIndexOf(",") + 1)).Replace("00:00:00", ""));

                        DateTime dateTime = Convert.ToDateTime(ConvertToPersian(zaman));

                        if (
                            (dateTime.AddDays(Convert.ToDouble(3)).AddDays(tedadroozbadazetmam)) <= DateTime.Today.Date)
                        {
                            result = 1;
                        }
                        else
                        {
                            result = 2;
                        }
                    }
                    else if (elamiyeType.Contains("Reyli") || elamiyeType.Contains("ریلی"))
                    {
                    }
                    else if (elamiyeType.Contains("Daryayi") || elamiyeType.Contains("دریایی"))
                    {
                    }
                }

                return result;
            }
        }

        public static DateTime MiladiBeShamsi(string zaman)
        {
            //var pc = new PersianCalendar();

            //return string.Format("{0}/{1}/{2}",
            //    pc.GetYear(dt),
            //    pc.GetMonth(dt).ToString("00"),
            //    pc.GetDayOfMonth(dt).ToString("00"));

            PersianCalendar persianCalendar = new PersianCalendar();

            DateTime dt = DateTime.Parse(zaman);

            DateTime dateTime = new DateTime(dt.Year, dt.Month, dt.Day, persianCalendar);
            return dateTime;
        } 
        public static DateTime ShamsiBeMiladi(string zaman)
        {
            //var pc = new PersianCalendar();

            //return string.Format("{0}/{1}/{2}",
            //    pc.GetYear(dt),
            //    pc.GetMonth(dt).ToString("00"),
            //    pc.GetDayOfMonth(dt).ToString("00"));

            System.Globalization.GregorianCalendar Calendar = new GregorianCalendar();

            DateTime dt = DateTime.Parse(zaman);

            DateTime dateTime = new DateTime(dt.Year, dt.Month, dt.Day, Calendar);
            return dateTime;
        }

        public static string ConvertToPersian(DateTime dt)
        {
            var pc = new PersianCalendar();

            return string.Format("{0}/{1}/{2}",
                pc.GetYear(dt),
                pc.GetMonth(dt).ToString(),
                pc.GetDayOfMonth(dt).ToString());
        }

        internal string CreateJoziyateEstelamLink(int inqId, string inqType)
        {
            string result = string.Empty;


            result =
                string.Format(
                    "/default.aspx?tabid={0}&mid={1}&ctl=ReplyToInquiry_{2}&InqId={3}&popUp=true", 113, 1433,
                    inqType, inqId);


            return result;
        }

        public int GetErtebateOomoomi(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int ertebatateOomoomi = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneSaheb(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.Ertebatat).Sum();
                    if (sum != null)
                        ertebatateOomoomi = (int) sum;
                }

                return ertebatateOomoomi;
            }
        }

        public static List<MyDnn_EHaml_NazarSanji_KhadamatBeSaheb> GetEUserNazarSanjiScoreBeOnvaneSaheb
            (int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var list = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_Inquiries on i.InquiryId equals j.Id
                    where j.MyDnn_EHaml_User_Id == eUserId
                    select i).ToList();

                var list2 = (from i in list
                    join j in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                        on i.InquiryId equals j.Inquiry_Id into StepOne
                    from c in StepOne
                    join k in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                        on c.ReplyToInquiry_Id equals k.ReplyToInquiry_Id
                    select c
                    ).ToList();

                return list2;
            }
        }

        public int GetPardakhteDaghigVaBeMoghe(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int pardakhteDaghigVaBeMoghe = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneSaheb(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.PardakhteDaghighVaBeMoghe).Sum();
                    if (sum != null)
                        pardakhteDaghigVaBeMoghe = (int) sum;
                }

                return pardakhteDaghigVaBeMoghe;
            }
        }

        public int GetSehateEtelaateEstelam(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int SehateEtelaateEstelam = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneSaheb(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.SehateEtelaateEstelam).Sum();
                    if (sum != null)
                        SehateEtelaateEstelam = (int) sum;
                }

                return SehateEtelaateEstelam;
            }
        }

        public int GetTedadeMajmooeNazaratGerefteBeOnvaneSaheb(int eUserId)
        {
            var list = GetEUserNazarSanjiScoreBeOnvaneSaheb(eUserId);
            return list.Count();
        }

        public int GetTedadeMajmooeNazaratGerefteBeOnvaneKhedmatresan(int eUserId)
        {
            var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);
            return list.Count();
        }

        private List<MyDnn_EHaml_NazarSanji_SahebBeKhadamat>
            GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var list = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                    join j in context.MyDnn_EHaml_Inquiries on i.InquiryId equals j.Id
                    where j.ServantUserId == eUserId
                    select i).ToList();

                var list2 = (from i in list
                    join j in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                        on i.InquiryId equals j.Inquiry_Id into StepOne
                    from c in StepOne
                    join k in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                        on c.ReplyToInquiry_Id equals k.ReplyToInquiry_Id
                    select c
                    ).ToList();

                return list2;
            }
        }

        public decimal GetErtebatateOomoomiKh(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int ertebatateOomoomiKh = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.Ertebatat).Sum();
                    if (sum != null)
                        ertebatateOomoomiKh = (int) sum;
                }

                return ertebatateOomoomiKh;
            }
        }

        public decimal GetDeghatDarAnjameMasooliyatha(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int result = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.DeghatDarAnjameMasooliyat).Sum();
                    if (sum != null)
                        result = (int) sum;
                }

                return result;
            }
        }

        public decimal GetPaybandiBeGofteha(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int result = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.PaybandiBeGofteha).Sum();
                    if (sum != null)
                        result = (int) sum;
                }

                return result;
            }
        }

        public decimal GetPaybandiBeTaahodeZamani(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int result = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.PaybandiBeTaahodeZamani).Sum();
                    if (sum != null)
                        result = (int) sum;
                }

                return result;
            }
        }

        public decimal GetPaybandiBeTaahodeGeymati(int eUserId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int result = 0;
                var list = GetEUserNazarSanjiScoreBeOnvaneKhadamatresan(eUserId);

                if (list.Count > 0)
                {
                    var sum = (from i in list
                        select i.PaybandiBeTaahodeGeymati).Sum();
                    if (sum != null)
                        result = (int) sum;
                }

                return result;
            }
        }

        public byte GetUserSuitableDashboardTab(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                bool isSaheb = false;
                bool isKhedmatGozar = false;

                byte result;

                isSaheb = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == userId
                          && i.Type == 'B'
                    select i).Any();

                isKhedmatGozar = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == userId
                          && i.Type == 'A'
                    select i).Any();

                if (isSaheb && isKhedmatGozar)
                {
                    result = 1;
                }
                else if (isSaheb)
                {
                    result = 1;
                }
                else
                {
                    result = 0;
                }

                return result;
            }
        }

        public string CurrentTxtOnvanePishnahad()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtOnvanePishnahad"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtOnvaneTaeidPishnahad()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtOnvaneTaeidPishnahad"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtMatnePishnahad()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtMatnePishnahad"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtMatneTaeidPishnahad()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtMatneTaeidPishnahad"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtOnvaneEMailLinkeTaeed()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtOnvaneEMailLinkeTaeed"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtMatneEMailLinkeTaeed()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtMatneEMailLinkeTaeed"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtMatnePishnahadSMS()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtMatnePishnahadSMS"
                    select i.SettingValue).Single();
            }
        }

        public string CurrentTxtMatneTaeidPishnahadSMS()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "txtMatneTaeidPishnahadSMS"
                    select i.SettingValue).Single();
            }
        }

        public bool IsUserKhadamatResan(int userId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return ((from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == userId
                          && i.Type.Value == 'A'
                    select i).Any());
            }
        }


        internal string GetTransactionDescriptionEdame(long bankId, string description)
        {
            string result = string.Empty;

            if (description.Contains("تسویه"))
            {
                result = string.Empty;
            }
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml__Bank bank = (from i in context.MyDnn_EHaml__Banks
                    where i.Id == bankId
                    select i).Single();

                if (
                    context.MyDnn_EHaml__Banks.Where(x => x.Id == bankId)
                        .Any(v => v.MyDnn_EHaml_BankTransactionDetail_Id != null))
                {
                    if (context.MyDnn_EHaml_BankTransactionDetails.Where(
                        x => x.Id == bank.MyDnn_EHaml_BankTransactionDetail_Id)
                        .Any(b => b.InquiryReplyToInquiry_Id != null))
                    {
                        MyDnn_EHaml_BankTransactionDetail detail = (from i in context.MyDnn_EHaml_BankTransactionDetails
                            where i.Id == bank.MyDnn_EHaml_BankTransactionDetail_Id
                            select i).Single();
                        string inqId = context.MyDnn_EHaml_Inquiry_ReplyToInquiries.Where(
                            x => x.Id == detail.InquiryReplyToInquiry_Id).Select(v => v.InquiryId).Single().ToString();

                        string inquiryType = (from i in context.MyDnn_EHaml_Inquiries
                            where i.Id == int.Parse(inqId)
                            select i.InquiryType).Single();

                        Util util = new Util();

                        string link = string.Format("<a class='inqidtoogrid' href='{0}' target='_blank'> {1} </a>",
                            util.CreateJoziyateEstelamLink(Convert.ToInt32(inqId), inquiryType), inqId);

                        result = " در استعلام به شماره ردیف [Iid]";
                        result = result.Replace("[Iid]", link);
                    }
                }
            }

            return result;
        }

        public int GetDarsadElamiye()
        {
            return 500;
        }

        public string IsValidateDates(DnnDatePicker dtpActionDate, DnnDatePicker dtpExpiredate)
        {
            DateTime acDateAndTime =
                new DateTime(dtpActionDate.SelectedDate.Value.Year, dtpActionDate.SelectedDate.Value.Month ,dtpActionDate.SelectedDate.Value.Day);
            DateTime exDateAndTime =
                new DateTime(dtpExpiredate.SelectedDate.Value.Year , dtpExpiredate.SelectedDate.Value.Month ,
                               dtpExpiredate.SelectedDate.Value.Day);
            string result = string.Empty;

            if ((acDateAndTime.Date <= DateTime.Now.Date) || (exDateAndTime.Date <= DateTime.Now.Date))
            {
                result += "<span>تاریخ های انتخابی نمی توانند تاریخی قیل از امروز یاشند.</span>";
            }
            if (acDateAndTime.Date < exDateAndTime.Date)
            {

                    result += "<span>تاریخ اعتبار استعلام نمیتواند بزرگتر از تاریخ آغاز عملیات باشد.</span>";

            }

            if (result == string.Empty)
            {
                result = "OK";
            }

            return result;
        }
    }
}