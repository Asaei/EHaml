using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace MyDnn_EHaml.MyDnn_EHaml_DashboardHandler
{
    public partial class View : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                byte type = _util.GetUserSuitableDashboardTab(this.UserId);

                if (type == 1)
                {
                    Response.Redirect("/default.aspx?tabid=1148");
                }
                else
                {
                    Response.Redirect("/default.aspx?tabid=1149");
                }
            }
        }
    }
}