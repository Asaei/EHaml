using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;

namespace MyDnn_EHaml.MyDnn_EHaml_Elamiye
{
    public partial class ElamiyeSettings : ModuleSettingsBase
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
            cbolNoeElamiye.Items.Add(new DnnComboBoxItem("خالی جاده ای", "KhaliJadei"));
            cbolNoeElamiye.Items.Add(new DnnComboBoxItem("خالی ریلی", "KhaliReyli"));
            cbolNoeElamiye.Items.Add(new DnnComboBoxItem("خالی دریایی", "KhaliDaryayi"));

            cbolDefaultControl.Items.Add(new DnnComboBoxItem("لیست", "Elamiye_List"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("خالی جاده ای", "Elamiye_KhaliJadei"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("خالی ریلی", "Elamiye_KhaliReyli"));
            cbolDefaultControl.Items.Add(new DnnComboBoxItem("خالی دریایی", "Elamiye_KhaliDaryayi"));
        }

        public override void LoadSettings()
        {
            try
            {
                if ((Page.IsPostBack == false))
                {
                    if ((TabModuleSettings["ElamiyeTypeForList"] != null))
                    {
                        cbolNoeElamiye.SelectedValue = TabModuleSettings["ElamiyeTypeForList"].ToString();
                    }
                    if ((TabModuleSettings["NameControlForReply"] != null))
                    {
                        txtNameControl.Text = TabModuleSettings["NameControlForReply"].ToString();
                    }
                    if ((TabModuleSettings["ElamiyeDefaultControl"] != null))
                    {
                        cbolDefaultControl.SelectedValue = TabModuleSettings["ElamiyeDefaultControl"].ToString();
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
                objModules.UpdateTabModuleSetting(TabModuleId, "ElamiyeTypeForList",
                    cbolNoeElamiye.SelectedItem.Value);
                objModules.UpdateTabModuleSetting(TabModuleId, "NameControlForReply", txtNameControl.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "ElamiyeDefaultControl",
                    cbolDefaultControl.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}