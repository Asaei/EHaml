using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard
{
    public partial class Elamiye_ServentDashboard : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util util2 = new Util();
            if (util2.IsUserKhadamatResan(this.UserId))
            {
                isKhadamatresan.Visible = true;
            }
        }
    }
}