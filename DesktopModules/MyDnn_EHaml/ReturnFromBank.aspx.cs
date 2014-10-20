using System;
using System.Collections.Generic;
using System.Net;
using System.Security.Cryptography;
using System.Web;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Roles;
using DotNetNuke.Entities.Portals;

namespace MyDnn_EHaml
{
    public partial class ReturnFromBank : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int returnTabId = 0;
            int subscribeType = 0;
            int planId = 0;
            int userid = 0;

            bool isTasviye = Session["IsTasviye"] != null;

            if (isTasviye)
            {
                returnTabId = (int) Session["TasviyeTabId"];
                userid = Convert.ToInt32(Session["TUserId"].ToString());
            }
            else
            {
                returnTabId = (int) Session["RegisterTabId"];
                subscribeType = (int) Session["SubscribeType"];
                planId = (int) Session["PlanId"];
            }


            //اطلاعات زیر جهت ارجاع فاکتور از بانک می باشد
            string invoiceNumber = Page.Request.QueryString["iN"]; // شماره فاکتور
            string invoiceDate = Page.Request.QueryString["iD"]; // تاریخ فاکتور
            string TransactionReferenceID = Page.Request.QueryString["tref"]; // شماره مرجع
            string XMLResult;

            XMLResult = ReadPaymentResult();
            Label1.Text = invoiceNumber;
            Label2.Text = invoiceDate;
            Label3.Text = TransactionReferenceID;

            Xml1.DocumentContent = XMLResult;
            //در صورتی که تراکنشی انجام نشده باشد فایلی از بانک برگشت داده نمی شود  
            //دستور شزطی زیر جهت اعلام نتیجه به کاربر است
            if (XMLResult == "")
            {
                Session["UserPaymentStatus"] = "Error";
                Session["RegisterTabId"] = null;
                Session["SubscribeType"] = null;
                Session["PlanId"] = null;
                Session["IsTasviye"] = null;
                Session["TUserId"] = null;

                if (isTasviye)
                {
                    Response.Redirect(
                        string.Format("/default.aspx?tabid={0}&RegisterStatus=AfterPayment",
                            returnTabId));
                }
                else
                {
                    Response.Redirect(
                        string.Format("/default.aspx?tabid={0}&RegisterStatus=AfterPayment&subscribeType={1}",
                            returnTabId, subscribeType));
                }
            }
            else
            {
                XmlDocument XD = new XmlDocument();
                XD.LoadXml(XMLResult);
                XmlNodeList _TXNResult = XD.GetElementsByTagName("result"); //نتیجه تراکنش
                //XmlNodeList _TXNtraceNumber = XD.GetElementsByTagName("traceNumber"); //شماره پیگیری
                //XmlNodeList _TXNreferenceNumber = XD.GetElementsByTagName("referenceNumber"); //شماره ارجاع
                XmlNodeList _TXNreferenceAmount = XD.GetElementsByTagName("amount"); //مبلغ
                //XmlNodeList _TXNreferenceTDate = XD.GetElementsByTagName("invoiceDate");
                //XmlNodeList _TXNinvoiceNumber = XD.GetElementsByTagName("invoiceNumber");

                Label4.Text = _TXNResult[0].InnerText;
                string Result = _TXNResult[0].InnerText;

                if (bool.Parse(_TXNResult[0].InnerText))
                {
                    Session["UserPaymentStatus"] = "Success";
                    Session["RegisterTabId"] = null;
                    Session["SubscribeType"] = null;
                    Session["PlanId"] = null;
                    Session["IsTasviye"] = null;
                    Session["TUserId"] = null;
                    Util util = new Util();


                    var merchantCode = 571078;
                    var terminalCode = 571816;
                    var amount = _TXNreferenceAmount[0].InnerText;
                    //var amount = _TXNreferenceAmount[0].InnerText.Substring(0,
                    //    _TXNreferenceAmount[0].InnerText.IndexOf("."));
                    var timeStamp = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");

                    RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
                    rsa.FromXmlString(
                        "<RSAKeyValue><Modulus>y1Iae7REtEK2JWWJ3PhmpP1XE4KqvmUkoz5RiB6gju/RSjwQBpgodd69wVQHt0M9vVlofd8b5/VJaQaKHA9iCmHUKRNapzjphcJFIAbr4WVKq2AzdJPcBcFybyVox/87hEkwt3lpXj0EWdOd4pXiMK6wW1VzctEnLQ0StdXbwcc=</Modulus><Exponent>AQAB</Exponent><P>+LdwNLOTWe7UfzHbnmA9UcCf8S9Ic6B3D208msKzW3WLIoRiOLHWJyOXqpILqqo+3v3TzDshn+VUWvSf3q+AGw==</P><Q>0UZYOpuLrD14CFyIl4Ct45W7AVm/0mcl1+C9RGFi3684klcCV4yoD0IGSViBdPXGppXYRuCMqY3HldnTAx9XxQ==</Q><DP>NfRNUhF2sLa/wEwHkYbdJoP77m1McVDpIx6WXBhKoleQdE91o0jo5Rqyhx0hjMdb1jIIJTDarX4pW4XfvIYj6w==</DP><DQ>nPQlN89w8b0oSR0dVIMt54Jkvp6RPzwdJctoJ+DiRuEjjJ21I/RaFxdtn5TBgvbSBh5cFsxSstei2MCFgdIAAQ==</DQ><InverseQ>iHi295Rsb55UpGKfwxoZl0V0P+aCSVL8b7qKxWsmBM7TTZu/N7YlTX9+dlHMbq/n4yb6LKMvv/ds7/PAkjiM5g==</InverseQ><D>U+j7gwgfvqE1mPNx1R8zBW6EjEnF+7O0Tia+8UVqj/MLVe650m7ja9nUSEBMuuZmSYnnpOL6Gl3RwSVwxCnZFKDNWa76D2iZTVAc8CBSvM2Hr9XCmtX4DpnQqBGq8g5yMWJGYGRYTIKO6gxlb6TRpAxgiTgBDtvOha07wsIDvlk=</D></RSAKeyValue>");
                    string data = "#" + merchantCode + "#" + terminalCode + "#" + invoiceNumber + "#" + invoiceDate +
                                  "#" +
                                  amount + "#" + timeStamp + "#";
                    byte[] signMain = rsa.SignData(Encoding.UTF8.GetBytes(data), new SHA1CryptoServiceProvider());
                    var sign = Convert.ToBase64String(signMain);
                    HttpWebRequest request =
                        (HttpWebRequest) WebRequest.Create("https://pep.shaparak.ir/VerifyPayment.aspx");
                    string text = "InvoiceNumber=" + invoiceNumber + "&InvoiceDate=" +
                                  invoiceDate + "&MerchantCode=" + merchantCode + "&TerminalCode=" +
                                  terminalCode + "&Amount=" + amount + "&TimeStamp=" + timeStamp + "&Sign=" + sign;
                    byte[] textArray = Encoding.UTF8.GetBytes(text);
                    request.Method = "POST";
                    request.ContentType = "application/x-www-form-urlencoded";
                    request.ContentLength = textArray.Length;
                    request.GetRequestStream().Write(textArray, 0, textArray.Length);
                    HttpWebResponse response = (HttpWebResponse) request.GetResponse();
                    StreamReader reader = new StreamReader(response.GetResponseStream());
                    string result = reader.ReadToEnd();

                    //ErsaleTaidiye(_TXNreferenceTDate[0].InnerText, _TXNreferenceAmount[0].InnerText, _TXNinvoiceNumber[0].InnerText);

                    if (isTasviye)
                    {
                        util.TasviyeKonInKarBarRa(userid);
                        Response.Redirect(string.Format(
                            "/default.aspx?tabid={0}&RegisterStatus=AfterPayment",
                            returnTabId));
                    }
                    else
                    {
                        util.MackeUserSubscribe(subscribeType, planId);
                        Response.Redirect(
                            string.Format(
                                "/default.aspx?tabid={0}&RegisterStatus=AfterPayment&subscribeType={1}",
                                returnTabId, subscribeType));
                    }
                }
                else
                {
                    Session["UserPaymentStatus"] = "Error";
                    Session["RegisterTabId"] = null;
                    Session["SubscribeType"] = null;
                    Session["PlanId"] = null;
                    Session["IsTasviye"] = null;
                    Session["TUserId"] = null;

                    if (isTasviye)
                    {
                        Response.Redirect(string.Format(
                            "/default.aspx?tabid={0}&RegisterStatus=AfterPayment",
                            returnTabId));
                    }
                    else
                    {
                        Response.Redirect(
                            string.Format(
                                "/default.aspx?tabid={0}&RegisterStatus=AfterPayment&subscribeType={1}",
                                returnTabId, subscribeType));
                    }
                }
            }
        }

        private void ErsaleTaidiye(string _date, string _amount, string _invoiceNumber)
        {
            var merchantCode = 571078;
            var terminalCode = 571816;
            var amount = _amount;
            var invoiceNumber = _invoiceNumber;
            var invoiceDate = _date;
            var timeStamp = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");

            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(
                "<RSAKeyValue><Modulus>y1Iae7REtEK2JWWJ3PhmpP1XE4KqvmUkoz5RiB6gju/RSjwQBpgodd69wVQHt0M9vVlofd8b5/VJaQaKHA9iCmHUKRNapzjphcJFIAbr4WVKq2AzdJPcBcFybyVox/87hEkwt3lpXj0EWdOd4pXiMK6wW1VzctEnLQ0StdXbwcc=</Modulus><Exponent>AQAB</Exponent><P>+LdwNLOTWe7UfzHbnmA9UcCf8S9Ic6B3D208msKzW3WLIoRiOLHWJyOXqpILqqo+3v3TzDshn+VUWvSf3q+AGw==</P><Q>0UZYOpuLrD14CFyIl4Ct45W7AVm/0mcl1+C9RGFi3684klcCV4yoD0IGSViBdPXGppXYRuCMqY3HldnTAx9XxQ==</Q><DP>NfRNUhF2sLa/wEwHkYbdJoP77m1McVDpIx6WXBhKoleQdE91o0jo5Rqyhx0hjMdb1jIIJTDarX4pW4XfvIYj6w==</DP><DQ>nPQlN89w8b0oSR0dVIMt54Jkvp6RPzwdJctoJ+DiRuEjjJ21I/RaFxdtn5TBgvbSBh5cFsxSstei2MCFgdIAAQ==</DQ><InverseQ>iHi295Rsb55UpGKfwxoZl0V0P+aCSVL8b7qKxWsmBM7TTZu/N7YlTX9+dlHMbq/n4yb6LKMvv/ds7/PAkjiM5g==</InverseQ><D>U+j7gwgfvqE1mPNx1R8zBW6EjEnF+7O0Tia+8UVqj/MLVe650m7ja9nUSEBMuuZmSYnnpOL6Gl3RwSVwxCnZFKDNWa76D2iZTVAc8CBSvM2Hr9XCmtX4DpnQqBGq8g5yMWJGYGRYTIKO6gxlb6TRpAxgiTgBDtvOha07wsIDvlk=</D></RSAKeyValue>");
            string data = "#" + merchantCode + "#" + terminalCode + "#" + invoiceNumber + "#" + invoiceDate + "#" +
                          amount + "#" + timeStamp + "#";
            byte[] signMain = rsa.SignData(Encoding.UTF8.GetBytes(data), new SHA1CryptoServiceProvider());
            var sign = Convert.ToBase64String(signMain);
            HttpWebRequest request = (HttpWebRequest) WebRequest.Create("https://pep.shaparak.ir/VerifyPayment.aspx");
            string text = " InvoiceNumber =" + invoiceNumber + "& InvoiceDate=" +
                          invoiceDate + "&MerchantCode=" + merchantCode + "&TerminalCode=" +
                          terminalCode + "& Amount=" + amount + "& TimeStamp=" + timeStamp + "&Sign=" + sign;
            byte[] textArray = Encoding.UTF8.GetBytes(text);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = textArray.Length;
            request.GetRequestStream().Write(textArray, 0, textArray.Length);
            HttpWebResponse response = (HttpWebResponse) request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string result = reader.ReadToEnd();
        }

        private string ReadPaymentResult()
        {
            HttpWebRequest request =
                (HttpWebRequest) WebRequest.Create("https://pep.shaparak.ir/CheckTransactionResult.aspx");
            string text = "invoiceUID=" + Page.Request.QueryString["tref"];
            byte[] textArray = Encoding.UTF8.GetBytes(text);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = textArray.Length;
            request.GetRequestStream().Write(textArray, 0, textArray.Length);
            HttpWebResponse response = (HttpWebResponse) request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string result = reader.ReadToEnd();
            return result;
        }

        private void VerifyPayment()
        {
        }
    }
}