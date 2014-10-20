using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Entities.Users;
using DotNetNuke.Modules.Dashboard.Components.Portals;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Subscribe
{
    public partial class Subscribe : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSub.Click += lnkSub_Click;
            lnkReturn.Click += lnkReturn_Click;
        }

        private void lnkReturn_Click(object sender, EventArgs e)
        {
            if (Session["FinalReturnTabId"] != null)
            {
                string returnTabId = Session["FinalReturnTabId"].ToString();

                Session["FinalReturnTabId"] = null;
                Response.Redirect("/default.aspx?" + returnTabId);
            }
            else
            {
                Response.Redirect("/default.aspx");
            }
        }

        private void lnkSub_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["IsAdminHand"] == "Yes" && this.UserInfo.IsInRole("Administrators"))
            {
                int userId = Convert.ToInt32(Request.QueryString["UId"]);
                int userType = Convert.ToInt32(Request.QueryString["type"]);
                int planId = int.Parse(cbolPlanNameType.SelectedItem.Value);

                using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    if (userType == 1)
                    {
                        _util.MackeUserSubscribe2(1, planId, userId);
                    }
                    else
                    {
                        _util.MackeUserSubscribe2(0, planId, userId);
                    }
                }
                // Todo: make use subscribe with god hand
            }
            else
            {
                int userType = Convert.ToInt32(Request.QueryString["type"]);
                //if (cbolNahveyePardakht.SelectedItem.Value == "1")
                //{
                int planId = int.Parse(cbolPlanNameType.SelectedItem.Value);
                Session["RegisterTabId"] = this.TabId;
                Session["BankPrice"] = getPlanIdPrice(planId);
                Session["SubscribeType"] = userType;
                Session["PlanId"] = planId;

                Response.Redirect("~/DesktopModules/MyDnn_EHaml/SendToBank.aspx");

                //_util.MackeUserSubscribe(userType, planId);

                //}
                //else
                //{
                //}
            }
        }

        private decimal getPlanIdPrice(int planId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (decimal) (from i in context.MyDnn_EHaml_SubscriptionPlans
                    where i.Id == planId
                    select i.PlanPrice).Single();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["RegisterStatus"] != null)
                {
                    pnlRegular.Visible = false;
                    pnlAfterPayment.Visible = true;

                    if (Session["UserPaymentStatus"] != "Error")
                    {
                        lblMessage.Text = "پرداخت شما با موفقیت انجام گرفت";
                    }
                    else
                    {
                        lblMessage.Text = "متاسفانه عملیات پرداخت با مشکل مواجح شد.";
                    }
                }
                else
                {
                    if (PortalController.GetPortalSettingAsInteger("SubscriptionTabId", this.PortalId, -1) == -1)
                    {
                        PortalController.UpdatePortalSetting(this.PortalId, "SubscriptionTabId", this.TabId.ToString());
                    }
                    FillPageControlls();
                }
            }
        }

        private void FillPageControlls()
        {
            if (Request.QueryString["IsAdminHand"] == "Yes" && this.UserInfo.IsInRole("Administrators"))
            {
                int userId = Convert.ToInt32(Request.QueryString["UId"]);

                UserInfo info = UserController.GetUserById(this.PortalId, userId);
                lblFirstName.Text = info.FirstName;
                lblLastName.Text = info.LastName;
                lblEmail.Text = info.Email;
            }
            else
            {
                lblFirstName.Text = this.UserInfo.FirstName;
                lblLastName.Text = this.UserInfo.LastName;
                lblEmail.Text = this.UserInfo.Email;
            }


            FillCbolPlanNameType();

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

        private void FillCbolPlanNameType()
        {
            int userType = Convert.ToInt32(Request.QueryString["type"]);
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var planNames = from i in context.MyDnn_EHaml_SubscriptionPlans
                    select new {i.Id, i.PlanName, i.PlanPrice, i.Type};

                //                if (this.UserInfo.IsInRole("Khedmatgozar"))
                if (userType == 0)
                {
                    foreach (var item in planNames.Where(x => x.Type != false))
                    {
                        string price = item.PlanPrice.Value.ToString("C0");
                        cbolPlanNameType.Items.Add(new DnnComboBoxItem(item.PlanName + " " + price,
                            item.Id.ToString()));
                    }
                }
                else
                {
                    foreach (var item in planNames)
                    {
                        string price = item.PlanPrice.Value.ToString("C0");
                        cbolPlanNameType.Items.Add(new DnnComboBoxItem(item.PlanName + " " + price,
                            item.Id.ToString()));
                    }
                }
            }
        }
    }
}