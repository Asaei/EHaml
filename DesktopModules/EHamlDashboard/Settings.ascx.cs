using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace EHamlDashboard
{
    public partial class Settings : ModuleSettingsBase
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
                    if ((TabModuleSettings["GetSelectedGridForDashboardeSahebBar"] != null))
                    {
                        cbolKendoNemayesh.SelectedValue =
                            TabModuleSettings["GetSelectedGridForDashboardeSahebBar"].ToString();
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

                objModules.UpdateTabModuleSetting(TabModuleId, "GetSelectedGridForDashboardeSahebBar",
                    cbolKendoNemayesh.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}