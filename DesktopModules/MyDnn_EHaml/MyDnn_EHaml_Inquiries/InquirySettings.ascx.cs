using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class InquirySettings : ModuleSettingsBase
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

            //////////////////////////////////////////////////////////

            cbolDefaultControl.Items.Add(new DnnComboBoxItem("لیست", "Inquiry_List"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("زدغن", "Inquiry_Zadghan"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("زدغل", "Inquiry_Zadghal"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("زبن", "Inquiry_Zaban"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("رل", "Inquiry_Rl"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("دن", "Inquiry_Dn"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("دل", "Inquiry_Dl"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("زدف", "Inquiry_ZDF"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("دغک", "Inquiry_Dghco"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("هل", "Inquiry_Hl"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("تج", "Inquiry_Tj"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("تک", "Inquiry_Tk"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("تس", "Inquiry_Ts"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("تر", "Inquiry_Tr"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("اچ اس", "Inquiry_Hs"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سبک", "Inquiry_ChandVajhiSabok"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("چندوجهی – محمولات سنگین", "Inquiry_ChandVajhiSangin"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("بازدید", "Inquiry_Bazdid"));

            cbolDefaultControl.Items[0].Selected = true;

            ///////////////////////////////////////////////////////////

            //cbolTartibeNemayesh.Items.Add(new DnnComboBoxItem("نزولی","Nozooli"));
            //cbolTartibeNemayesh.Items.Add(new DnnComboBoxItem("صعودی","Soodi"));
            //cbolTartibeNemayesh.Items[0].Selected = true;
        }


        public override void LoadSettings()
        {
            try
            {
                if ((Page.IsPostBack == false))
                {
                    if ((TabModuleSettings["InquiryTypeForList"] != null))
                    {
                        cbolNoeEstelam.SelectedValue = TabModuleSettings["InquiryTypeForList"].ToString();
                    }
                    if ((TabModuleSettings["NameControlForReply"] != null))
                    {
                        txtNameControl.Text = TabModuleSettings["NameControlForReply"].ToString();
                    }
                    if ((TabModuleSettings["InquiryDefaultControl"] != null))
                    {
                        cbolDefaultControl.SelectedValue = TabModuleSettings["InquiryDefaultControl"].ToString();
                    }


                    //if ((TabModuleSettings["InquiryTartibeNemayesh"] != null))
                    //{
                    //    cbolTartibeNemayesh.SelectedValue = TabModuleSettings["TartibeNemayesh"].ToString();
                    //}
                    //if ((TabModuleSettings["InquiryTemplate"] != null))
                    //{
                    //    txtTemplate.Text = TabModuleSettings["InquiryTemplate"].ToString();
                    //}
                    //if ((TabModuleSettings["InquiryTedadeNemayesh"] != null))
                    //{
                    //    txtTedadeNemayesh.Text = TabModuleSettings["TedadeNemayesh"].ToString();
                    //}
                    //if ((TabModuleSettings["InquiryPaging"] != null))
                    //{
                    //    txtPagingSize.Text = TabModuleSettings["InquiryPaging"].ToString();
                    //}
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
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTypeForList", cbolNoeEstelam.SelectedItem.Value);
                objModules.UpdateTabModuleSetting(TabModuleId, "NameControlForReply", txtNameControl.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryDefaultControl",
                    cbolDefaultControl.SelectedItem.Value);

                //objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTartibeNemayesh", cbolTartibeNemayesh.SelectedItem.Value);
                //objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTemplate", txtTemplate.Text);
                //objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTedadeNemayesh", txtTedadeNemayesh.Text);
                //objModules.UpdateTabModuleSetting(TabModuleId, "InquiryPaging", txtPagingSize.Text);
            }
            catch (Exception exc)
            {
            }
        }
    }
}