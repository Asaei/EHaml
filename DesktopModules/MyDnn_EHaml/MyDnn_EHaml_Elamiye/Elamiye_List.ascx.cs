using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Web.Http;
using System.Net.Http;

namespace MyDnn_EHaml.MyDnn_EHaml_Elamiye
{
    public partial class Elamiye_List : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Settings["ElamiyeDefaultControl"] != null)
            {
                string defaultControl = Settings["ElamiyeDefaultControl"].ToString();

                if (defaultControl != "Elamiye_List")
                {
                    Response.Redirect("/default.aspx?tabid=" + this.TabId.ToString() + "&mid=" +
                                      this.ModuleId.ToString() +
                                      "&ctl=" + defaultControl);
                }
            }
        }
    }
}