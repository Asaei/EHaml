using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;

namespace Asaei_EHaml
{
    public partial class ViewInquiryListSettings : ModuleSettingsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillPageControlls();
            }
        }

        private void FillPageControlls()
        {
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدغن", "Zadghan"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدغل", "Zadghal"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زبن", "Zaban"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("رل", "Rl"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دن", "Dn"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دل", "Dl"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدف", "ZDF"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دغک", "Dghco"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("هل", "Hl"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تج", "Tj"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تک", "Tk"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تس", "Ts"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تر", "Tr"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("اچ اس", "Hs"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سبک", "ChandVajhiSabok"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سنگین", "ChandVajhiSangin"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("بازدید", "Bazdid"));

            cbolDefaultControl.Items.Add(new DnnComboBoxItem("لیست", "Inquiry_List"));

            cbolDefaultControl.Items[0].Selected = true;
        }

        public override void LoadSettings()
        {
            try
            {
                if ((Page.IsPostBack == false))
                {
                    if ((TabModuleSettings["InquiryTypeForViewInquiryList"] != null))
                    {
                        cbolNoeEstelam.SelectedValue = TabModuleSettings["InquiryTypeForViewInquiryList"].ToString();
                    }
                }
            }
            catch (Exception exc)
            {
            }
        }

        public override void UpdateSettings()
        {
            try
            {
                ModuleController objModules = new ModuleController();
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTypeForViewInquiryList",
                    cbolNoeEstelam.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}