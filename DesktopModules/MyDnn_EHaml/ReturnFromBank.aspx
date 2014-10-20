<%@ Page Language="C#" AutoEventWireup="True" Inherits="MyDnn_EHaml.ReturnFromBank" Codebehind="ReturnFromBank.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>

        <style type="text/css">
            a.dnnPrimaryAction, a.dnnPrimaryAction:link, a.dnnPrimaryAction:visited, .ui-button.ui-widget.ui-state-default.ui-corner-all.ui-button-text-only {
                background: -moz-linear-gradient(center top, #818181 0%, #656565 100%) repeat scroll 0 0 transparent;
                border-color: #FFFFFF;
                border-radius: 3px 3px 3px 3px;
                color: #FFFFFF;
                font-weight: bold;
                text-decoration: none;
                text-shadow: 0 1px 1px #000000;
            }

            ul.dnnActions li a, a.dnnPrimaryAction, a.dnnPrimaryAction:link, a.dnnPrimaryAction:visited, a.dnnSecondaryAction, a.dnnSecondaryAction:link, a.dnnSecondaryAction:visited {
                line-height: 2.5;
                padding: 0 1.2em;
            }

            .dnnForm.ui-widget-content a.dnnPrimaryAction { color: #FFFFFF; }
        </style>
    </head>
    <body style="font-size: 13px; font-family: Tahoma; direction: rtl;">
        <form id="form1" runat="server">

            <div style="text-align: right">
                شماره فاکتور:&nbsp;
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><br />
                تاریخ فاکتور:&nbsp;
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label><br />
                شماره مرجع:&nbsp;
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                <br />
                <br />
            </div>
            <br />

            <div>
                <asp:Label ID="lblPaymentMSG" runat="server"></asp:Label>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="dnnPrimaryAction" NavigateUrl="~/default.aspx" Text="بازگشت به سایت" style="padding-top: 6px; padding-bottom: 8px"></asp:HyperLink>
            </div>

            <div style="text-align: right; display: none;">
                <asp:Xml ID="Xml1" runat="server"></asp:Xml>
                <br />
                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>

            </div>
        </form>
    </body>
</html>