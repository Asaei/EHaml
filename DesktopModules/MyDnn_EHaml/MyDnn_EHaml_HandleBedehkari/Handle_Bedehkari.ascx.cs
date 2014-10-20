using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;


namespace MyDnn_EHaml.MyDnn_EHaml_HandleBedehkari
{
    public partial class Handle_Bedehkari : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util util = new Util();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                if (util.getNahveyeBarkhordBaBedehkari() != "TedadeAmaliyat")
                {
                    string akharinZamanePeydaKardaneBedehkara = ((from i in context.MyDnn_EHaml_GeneralSettings
                        where i.SettingName == "AkharinZamanePeydaKardaneBedehkara"
                        select i.SettingValue).SingleOrDefault());

                    if (akharinZamanePeydaKardaneBedehkara == null)
                    {
                        MyDnn_EHaml_GeneralSetting generalSetting = (from i in context.MyDnn_EHaml_GeneralSettings
                            where i.SettingName == "AkharinZamanePeydaKardaneBedehkara"
                            select i).Single();
                        generalSetting.SettingValue = DateTime.Now.ToString();

                        context.SubmitChanges();

                        util.BarkhordBaBedehkari();
                    }
                    else
                    {
                        if (DateTime.Now.Date > DateTime.Parse(akharinZamanePeydaKardaneBedehkara).Date)
                        {
                            util.BarkhordBaBedehkari();
                        }
                        else
                        {
                            return;
                        }
                    }
                }
            }
        }
    }
}