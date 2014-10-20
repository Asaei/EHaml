using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;

namespace MyDnn_EHaml.MyDnn_EHaml_GeneralList
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
            cbolTartibeNemayesh.Items.Add(new DnnComboBoxItem("نزولی", "Nozooli"));
            cbolTartibeNemayesh.Items.Add(new DnnComboBoxItem("صعودی", "Soodi"));
            cbolTartibeNemayesh.Items[0].Selected = true;
        }

        public override void LoadSettings()
        {
            try
            {
                if ((Page.IsPostBack == false))
                {

                    if ((TabModuleSettings["InquiryTartibeNemayesh"] != null))
                    {
                        cbolTartibeNemayesh.SelectedValue = TabModuleSettings["TartibeNemayesh"].ToString();
                    }
                    if ((TabModuleSettings["InquiryTemplate"] != null))
                    {
                        txtTemplate.Text = TabModuleSettings["InquiryTemplate"].ToString();
                    }
                    if ((TabModuleSettings["InquiryTedadeNemayesh"] != null))
                    {
                        txtTedadeNemayesh.Text = TabModuleSettings["TedadeNemayesh"].ToString();
                    }
                    if ((TabModuleSettings["InquiryPaging"] != null))
                    {
                        txtPagingSize.Text = TabModuleSettings["InquiryPaging"].ToString();
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

                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTartibeNemayesh", cbolTartibeNemayesh.SelectedItem.Value);
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTemplate", txtTemplate.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryTedadeNemayesh", txtTedadeNemayesh.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "InquiryPaging", txtPagingSize.Text);

            }
            catch (Exception exc)
            {
            }
        }
    }
}