using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Net;
using System.Collections;


namespace MyDnn_EHaml
{
    public partial class SendToBank : System.Web.UI.Page
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.setSendingData();
        }

        public void setSendingData()
        {
            //Hashtable Settings =
            //    new DotNetNuke.Entities.Modules.ModuleController().GetTabModuleSettings(
            //        int.Parse(Request.QueryString["tabmid"]));

            //------------------------------------------------------------------------
            //در این قسمت اطلاعاتی که در صفحه 
            //Default 
            //وارد نموده اید جایگذاری می گردد

            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            string privateKeyText = ""; //متغیری جهت تعریف کلید اختصاصی در سیستم

            //------------------------------------------------------------------------
            //در این قسمت اطلاعاتی که در صفحه 
            //Default 
            //وارد نموده اید جایگذاری می گردد
            string merchantCode = (_util.getCurrentShomarePazirande() != null ? _util.getCurrentShomarePazirande() : "");
            // کد پذیرنده
            string terminalCode = (_util.getCurrentShomareTerminal() != null ? _util.getCurrentShomareTerminal() : "");
            // کد ترمینال


            string amount = (Session["BankPrice"] != null
                ? (Convert.ToDouble(Session["BankPrice"].ToString())).ToString()
                : ""); //  مبلغ فاکتور


            string redirectAddress = (_util.getCurrentAddresseBazgashtAzBank() != null
                ? _util.getCurrentAddresseBazgashtAzBank()
                : "");
            string invoiceNumber = Guid.NewGuid().ToString(); // شماره فاکتور
            string action = "1003";
            //--------------------------------------------------------------------------

            //تاریخ فاکتور و زمان اجرای عملیات از سیستم گرفته می شود
            //شما می توانید تاریخ فاکتور را به صورت دستی وارد نمایید 
            string timeStamp = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            string invoiceDate = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"); // تاریخ فاکتور
            //-------------------------------------------------------------------------

            //کلید اختصاصی خود را که تولید نموده اید در این قسمت وارد نمایید
            privateKeyText = (_util.getCurrentKelideEkhtesasi() != null ? _util.getCurrentKelideEkhtesasi() : "");
            //------------------------------------------------------------------------

            // در این قسمت تولید می شود و برای بانک ارسال می گرددsign
            rsa.FromXmlString(privateKeyText);
            string data = "#" + merchantCode + "#" + terminalCode + "#" + invoiceNumber +
                          "#" + invoiceDate + "#" + amount + "#" + redirectAddress + "#" + action + "#" + timeStamp +
                          "#";
            byte[] signMain = rsa.SignData(Encoding.UTF8.GetBytes(data), new SHA1CryptoServiceProvider());
            string sign = Convert.ToBase64String(signMain);

            string pForm = "";
            pForm =
                string.Concat(
                    "<form method=\"post\" action=\"https://pep.shaparak.ir/gateway.aspx\" name=\"form1\">",
                    "<div class='paymentpanel'><input style='display:none;' type=\"text\" name=\"merchantCode\" value=\"",
                    merchantCode,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"terminalCode\" value=\"",
                    terminalCode,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"amount\" value=\"",
                    amount,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"redirectAddress\" value=\"",
                    redirectAddress,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"invoiceNumber\" value=\"",
                    invoiceNumber,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"invoiceDate\" value=\"",
                    invoiceDate,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"action\" value=\"",
                    action,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"sign\" value=\"",
                    sign,
                    "\" />",
                    "<input style='display:none;' type=\"text\" name=\"timeStamp\" value=\"",
                    timeStamp,
                    "\" />",
                    "<br> <p style='font-family:tahoma;font-size:13px;text-align:center;direction:rtl;'>لطفا صبر نمائید. در حال اتصال به بانک پاسارگاد...</p>",
                    "<br><br><input style='display:none;' type=\"submit\" name=\"submit\" value=\"ارسال به بانک\"  id=\"submit\" value=\"ok\" /></div></form>");

            Literal1.Text = pForm;
        }
    }
}