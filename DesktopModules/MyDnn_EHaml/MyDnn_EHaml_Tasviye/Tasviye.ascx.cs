using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Tasviye
{
    public partial class Tasviye : PortalModuleBase
    {
        private Util util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["RegisterStatus"] != null)
                {
                    pnlmessageforTasviye.Visible = true;
                    pnlregularTasviye.Visible = false;
                    if (Session["UserPaymentStatus"] == "Success")
                    {
                        lblMessageForTasviye.Text = "پرداخت شما با موفقیت انجام گرفت";
                    }
                    else
                    {
                        lblMessageForTasviye.Text = "متاسفانه پرداخت شما با مشکل مواجه شد.";
                    }
                }

                if (PortalController.GetPortalSettingAsInteger("TasviyeTabId", this.PortalId, -1) == -1)
                {
                    PortalController.UpdatePortalSetting(this.PortalId, "TasviyeTabId", this.TabId.ToString());
                }
                FillPageControlls();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSub.Click += lnkSub_Click;
            lnkBack.Click += lnkBack_Click;
        }

        private void lnkBack_Click(object sender, EventArgs e)
        {
            string returnTabId = Session["FinalReturnTabId"].ToString();

            Response.Redirect("/default.aspx?tabid=" + returnTabId);
        }

        private void lnkSub_Click(object sender, EventArgs e)
        {
            int userType = Convert.ToInt32(Request.QueryString["type"]);
            //if (cbolNahveyePardakht.SelectedItem.Value == "1")
            //{
            Session["FinalReturnTabId"] = Request.QueryString["FinalReturnTabId"];
            Session["TasviyeTabId"] = this.TabId;
            Session["TUserId"] = this.UserId;
            Session["IsTasviye"] = "Yes";
            Session["BankPrice"] = (-1)*(int) util.getUserMizaneBedehkari(this.UserId);


            Response.Redirect("~/DesktopModules/MyDnn_EHaml/SendToBank.aspx");
            //util.TasviyeKonInKarBarRa(this.UserId);
        }

        private void FillPageControlls()
        {
            lblFirstName.Text = this.UserInfo.FirstName;
            lblLastName.Text = this.UserInfo.LastName;
            lblEmail.Text = this.UserInfo.Email;
            lblMablaghePardakhtValue.Text = ((-1)*(util.getUserMizaneBedehkari((this.UserId)))).ToString("N0") + " ریال";

            FillcbolNahveyePardakht();
        }

        private void FillcbolNahveyePardakht()
        {
            cbolNahveyePardakht.Items.Add(new RadComboBoxItem("-- انتخاب نمایید --", "-1"));
            cbolNahveyePardakht.Items.Add(new RadComboBoxItem("از طریق الکترونیکی(درگاه بانک)", "1"));
            cbolNahveyePardakht.Items.Add(new RadComboBoxItem("از موجودی سایت", "0"));

            cbolNahveyePardakht.SelectedValue = "-1";
            cbolNahveyePardakht.Items[0].Enabled = false;
        }
    }
}