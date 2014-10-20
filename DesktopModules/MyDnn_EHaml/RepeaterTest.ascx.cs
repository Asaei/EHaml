using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyDnn_EHaml
{
    public partial class RepeaterTest : System.Web.UI.UserControl
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            rpt1.ItemDataBound += rpt1_ItemDataBound;
        }

        private void rpt1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            object dataItem = e.Item.DataItem;

            string template = getTemplate();

            template = template.Replace("[ID]", "1");

            LiteralControl objlit = new LiteralControl(template);

            e.Item.FindControl("plc1").Controls.Add(objlit);
        }

        private string getTemplate()
        {
            return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            List<object> list = new List<object>();

            rpt1.DataSource = list;
            rpt1.DataBind();
        }
    }
}