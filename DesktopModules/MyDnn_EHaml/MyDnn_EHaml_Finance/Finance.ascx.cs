using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;

namespace MyDnn_EHaml.MyDnn_EHaml_Finance
{
    public partial class Finance : PortalModuleBase
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            btnPardakht.Click += btnPardakht_Click;
        }

        private void btnPardakht_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            if (util.IsUserKhadamatResan(this.UserId))
            {
                Response.Redirect("/default.aspx?tabid=" +
                                  PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) +
                                  "&type=1&FinalReturnTabId=" + this.TabId);
            }
            else
            {
                Response.Redirect("/default.aspx?tabid=" +
                                  PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) +
                                  "&type=0&FinalReturnTabId=" + this.TabId);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Util util2 = new Util();
            if (util2.IsUserKhadamatResan(this.UserId))
            {
                isKhadamatresan.Visible = true;
            }

            if (!Page.IsPostBack)
            {
                Util util = new Util();
                long mojoodi = util.getUserMizaneBedehkari(this.UserId);
                if (mojoodi >= 0)
                {
                    btnPardakht.Enabled = false;
                    lblMojoodiValue.Text =
                        string.Format(
                            "<span style='color: green; font-size: 12px; font-family: tahoma; font-weight: bold;'>{0}</span>",
                            mojoodi + "+ ریال ");
                }
                else if (mojoodi == int.MinValue)
                {
                    btnPardakht.Enabled = false;
                    lblMojoodiValue.Text =
                        string.Format(
                            "<span style='color: red; font-size: 12px; font-family: tahoma; font-weight: bold;'>{0}</span>",
                            (0).ToString().Replace("-", "") + " ریال ");
                }
                else
                {
                    lblMojoodiValue.Text =
                        string.Format(
                            "<span style='color: red; font-size: 12px; font-family: tahoma; font-weight: bold;'>{0}</span>",
                            (mojoodi).ToString().Replace("-", "") + "- ریال ");
                }
            }
        }
    }
}