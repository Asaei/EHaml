using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Web.Client;
using DotNetNuke.Web.Client.ClientResourceManagement;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class Inquiry_List : PortalModuleBase
    {
        #region Methods (1) 

        // Protected Methods (1) 
        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ClientResourceManager.RegisterStyleSheet(this.Page, Util.GetCurrentKendoTheme());

            if (Settings["InquiryDefaultControl"] != null)
            {
                string defaultControl = Settings["InquiryDefaultControl"].ToString();

                if (defaultControl != "Inquiry_List")
                {
                    Response.Redirect("/default.aspx?tabid=" + this.TabId.ToString() + "&mid=" +
                                      this.ModuleId.ToString() +
                                      "&ctl=" + defaultControl);
                }
            }
        }

        #endregion Methods 
    }
}