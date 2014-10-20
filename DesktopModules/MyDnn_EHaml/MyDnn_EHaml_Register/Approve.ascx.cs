using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;


namespace MyDnn_EHaml.MyDnn_EHaml_Register
{
    public partial class Approve : PortalModuleBase
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            btnBazgasht.Click += btnBazgasht_Click;
            btnKharideTarh.Click += btnKharideTarh_Click;
        }

        void btnKharideTarh_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + -1;
            Util util = new Util();
            if (util.IsUserKhadamatResan(this.UserId))
            {
                Response.Redirect("/default.aspx?tabid=" +
                                  PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) +
                                  "&type=0");
            }
            else
            {
                Response.Redirect("/default.aspx?tabid=" +
                                  PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) +
                                  "&type=1");
            }
        }

        void btnBazgasht_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string appCode = Request.QueryString["AppCode"];

                using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    //if (this.UserId > -1)
                    //{
                    var thisUserAppcode = (from i in context.MyDnn_EHaml_Users
                        where i.AppCode == appCode
                        select i).SingleOrDefault();
                    if (thisUserAppcode != null && thisUserAppcode.AppCode == appCode)
                    {
                        thisUserAppcode.IsApprove = true;
                        context.SubmitChanges();
                    }
                    else
                    {
                        pnlSomeThingWrong.Visible = true;
                        pnlOk.Visible = false;
                    }
                    //}
                    //else
                    //{
                    //    pnlLoginKonAhmagh.Visible = true;
                    //    pnlOk.Visible = false;
                    //}
                }
            }
        }
    }
}