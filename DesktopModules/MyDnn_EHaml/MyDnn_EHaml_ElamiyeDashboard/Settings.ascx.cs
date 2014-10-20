using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard
{
    public partial class Settings : ModuleSettingsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override void LoadSettings()
        {
            if ((Page.IsPostBack == false))
            {
                if ((TabModuleSettings["grideMoredeNazarVaseDashboardElamiyeSaheb"] != null))
                {
                    cbolKendoNemayesh.SelectedValue =
                        TabModuleSettings["grideMoredeNazarVaseDashboardElamiyeSaheb"].ToString();
                }
            }
        }

        public override void UpdateSettings()
        {
            try
            {
                ModuleController objModules = new ModuleController();

                objModules.UpdateTabModuleSetting(TabModuleId, "grideMoredeNazarVaseDashboardElamiyeSaheb",
                    cbolKendoNemayesh.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}