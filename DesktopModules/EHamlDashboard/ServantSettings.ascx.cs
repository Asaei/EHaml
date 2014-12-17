using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;

namespace EHamlDashboard
{
    public partial class ServantSettings : ModuleSettingsBase
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
                    if ((TabModuleSettings["GetSelectedGridForDashboardeServant"] != null))
                    {
                        cbolKendoNemayesh.SelectedValue =
                            TabModuleSettings["GetSelectedGridForDashboardeServant"].ToString();
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

                objModules.UpdateTabModuleSetting(TabModuleId, "GetSelectedGridForDashboardeServant",
                    cbolKendoNemayesh.SelectedItem.Value);
            }
            catch (Exception exc)
            {
            }
        }
    }
}