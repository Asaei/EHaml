using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;


namespace MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard
{
    public partial class ReplyToElamiyeShenasname : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Util util = new Util();
                string status = util.IsUserOk(UserId, 1);
                if (status != "OK")
                {
                    switch (status)
                    {
                        case "LoginNakarde":
                            pnlMessageForLoginNakarde.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "ApproveNashode":
                            pnlMessageForNotApproved.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "Bedehkare":
                            pnlMessageForBedehkarUser.Visible = true;
                            break;
                        case "SubscribeNist":
                            pnlMessageForNotSubscribeUser.Visible = true;
                            break;
                    }
                }
                string elamiyeId = Request.QueryString["ElaId"];
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye =
                        (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where i.Id == Convert.ToInt32(elamiyeId)
                            select i).Single();
                    MyDnn_EHaml_ReplyToElamiye_KhaliJadei jadei = null;
                    MyDnn_EHaml_ReplyToElamiye_KhaliReyli reyli = null;
                    MyDnn_EHaml_ReplyToElamiye_KhaliDaryayi daryayi = null;

                    if (elamiyeReplyToElamiye.ElamiyeType == "KhaliJadei")
                    {
                        jadei =
                            (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis
                                where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                                select i).Single();

                        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                            where i.Id == jadei.MyDnn_EHaml_User_Id
                            select i).Single();

                        lblPasokhDahandeValue.Text =
                            UserController.GetUserById(0, (int) user.PortalUserId).DisplayName +
                            "(" + UserController.GetUserById(0, (int) user.PortalUserId).UserID +
                            ")";
                    }
                    else if (elamiyeReplyToElamiye.ElamiyeType == "KhaliReyli")
                    {
                        reyli =
                            (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis
                                where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                                select i).Single();

                        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                            where i.Id == reyli.MyDnn_EHaml_User_Id
                            select i).Single();

                        lblPasokhDahandeValue.Text =
                            UserController.GetUserById(0, (int) user.PortalUserId).DisplayName +
                            "(" + UserController.GetUserById(0, (int) user.PortalUserId).UserID +
                            ")";
                    }
                    else if (elamiyeReplyToElamiye.ElamiyeType == "KhaliDaryayi")
                    {
                        daryayi =
                            (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis
                                where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                                select i).Single();

                        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                            where i.Id == daryayi.MyDnn_EHaml_User_Id
                            select i).Single();

                        lblPasokhDahandeValue.Text =
                            UserController.GetUserById(0, (int) user.PortalUserId).DisplayName +
                            "(" + UserController.GetUserById(0, (int) user.PortalUserId).UserID +
                            ")";
                    }

                    switch (elamiyeReplyToElamiye.ElamiyeType)
                    {
                        case "KhaliJadei":
                            FillPnlReplyToElamiyeKhaliJadeiShenasnameTitle(elamiyeReplyToElamiye);
                            break;
                        case "KhaliReyli":
                            FillPnlReplyToElamiyeKhaliReyliShenasnameTitle(elamiyeReplyToElamiye);
                            break;
                        case "KhaliDaryayi":
                            FillPnlReplyToElamiyeKhaliDaryayiShenasnameTitle(elamiyeReplyToElamiye);
                            break;
                    }
                }
            }
        }


        private void FillPnlReplyToElamiyeKhaliDaryayiShenasnameTitle(
            MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                pnlReplyToElamiyeKhaliDaryayiShenasnameTitle.Visible = true;

                MyDnn_EHaml_ReplyToElamiye_KhaliDaryayi reyli =
                    (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis
                        where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                        select i).Single();

                lblNoVaTedadeVasileyeHamlValueReyli.Text = reyli.VasileyeHamleMoredeNiyaz;
            }
        }

        private void FillPnlReplyToElamiyeKhaliReyliShenasnameTitle(
            MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                pnlReplyToElamiyeKhaliReyliShenasnameTitle.Visible = true;

                MyDnn_EHaml_ReplyToElamiye_KhaliReyli reyli =
                    (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis
                        where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                        select i).Single();

                lblNoVaTedadeVasileyeHamlValueReyli.Text = reyli.VasileyeHamleMoredeNiyaz;
            }
        }

        private void FillPnlReplyToElamiyeKhaliJadeiShenasnameTitle(
            MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                pnlReplyToElamiyeKhaliJadeiShenasnameTitle.Visible = true;

                MyDnn_EHaml_ReplyToElamiye_KhaliJadei jadei =
                    (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis
                        where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                        select i).Single();

                lblNoVaTedadeVasileyeHamlValue.Text = jadei.VasileyeHamleMoredeNiyaz;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
            lnkSubmitReyli.Click += LnkSubmitOnClick;
        }

        private void LnkSubmitOnClick(object sender, EventArgs e)
        {
            Util util = new Util();
            string userStatus = util.IsUserOk(this.UserId, 0);
            //string status = util.IsUserOk(UserId, 0);
            if (userStatus != "OK")
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 0);
            }
            else
            {
                string replyId = Request.QueryString["ElaId"];
                MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye = null;
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    elamiyeReplyToElamiye = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                        where i.Id == int.Parse(replyId)
                        select i).Single();


                    if (elamiyeReplyToElamiye.ElamiyeType == "KhaliJadei")
                    {
                        MyDnn_EHaml_Elamiye_KhaliJadei jadei = (from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                            where i.Id == elamiyeReplyToElamiye.ElamiyeId
                            select i).Single();

                        MyDnn_EHaml_ReplyToElamiye_KhaliJadei replyToElamiyeKhaliJadei =
                            (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis
                                where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                                select i).Single();

                        jadei.ServentUserId = replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id;
                        elamiyeReplyToElamiye.Status = 1;

                        context.SubmitChanges();
                    }
                    else if (elamiyeReplyToElamiye.ElamiyeType == "KhaliReyli")
                    {
                        MyDnn_EHaml_Elamiye_KhaliReyli reyli = (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                            where i.Id == elamiyeReplyToElamiye.ElamiyeId
                            select i).Single();

                        MyDnn_EHaml_ReplyToElamiye_KhaliReyli replyToElamiyeKhaliJadei =
                            (from i in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis
                                where i.Id == elamiyeReplyToElamiye.ReplyToElamiyeId
                                select i).Single();

                        reyli.ServentUserId = replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id;
                        elamiyeReplyToElamiye.Status = 1;

                        context.SubmitChanges();
                    }
                }
            }
        }
    }
}