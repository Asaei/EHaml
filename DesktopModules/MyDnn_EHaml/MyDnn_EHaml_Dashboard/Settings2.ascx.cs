using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace MyDnn_EHaml.MyDnn_EHaml_Dashboard
{
    public partial class Settings2 : ModuleSettingsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override void LoadSettings()
        {
            try
            {
                if ((Page.IsPostBack == false))
                {
                    if ((TabModuleSettings["grideMoredeNazarVaseDashboardKhedmatgozar"] != null))
                    {
                        cbolKendoNemayesh.SelectedValue =
                            TabModuleSettings["grideMoredeNazarVaseDashboardKhedmatgozar"].ToString();
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

                objModules.UpdateTabModuleSetting(TabModuleId, "grideMoredeNazarVaseDashboardKhedmatgozar",
                    cbolKendoNemayesh.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}