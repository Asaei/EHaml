using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;

namespace EHamlInquiryList
{
    public partial class Settings : ModuleSettingsBase
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
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدغن", "Inquiry_Zadghan"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدغل", "Inquiry_Zadghal"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زبن", "Inquiry_Zaban"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("رل", "Inquiry_RL"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دن", "Inquiry_DN"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دل", "Inquiry_DL"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("زدف", "Inquiry_ZDF"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("دغک", "Inquiry_Dghco"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("هل", "Inquiry_HL"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تج", "Inquiry_TJ"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تک", "Inquiry_TK"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تس", "Inquiry_TS"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("تر", "Inquiry_TR"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("اچ اس", "Inquiry_HS"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سبک", "Inquiry_ChandVajhiSabok"));
            cbolNoeEstelam.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سنگین", "Inquiry_ChandVajhiSangin"));
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