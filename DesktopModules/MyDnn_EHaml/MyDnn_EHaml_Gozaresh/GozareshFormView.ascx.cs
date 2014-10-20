using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;


namespace MyDnn_EHaml.MyDnn_EHaml_Gozaresh
{
    public partial class GozareshFormView : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["Id"]);

                using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    var query = (from i in context.MyDnn_EHaml_GozareshTs
                        where i.Id == id
                        select i).Single();

                    txtGozareshValue.Text = query.Message;
                    dtpDate.SelectedDate = query.Date.Value;
                }
            }
        }
    }
}