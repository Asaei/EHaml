<%@ Page Language="C#" AutoEventWireup="True" Inherits="MyDnn_EHaml.SendToBank" Codebehind="SendToBank.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <style type="text/css">
            .paymentpanel {
                font-family: tahoma;
                height: 100px;
                padding: 0;
                text-align: center;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

        <script src="/Resources/Shared/Scripts/jquery/jquery.min.js?cdv=16">
            function voorood(parameters) {
                var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
                dnnModal.show(modulePath, true, 550, 960, true, '');
            }
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#submit").trigger("click");
            });

            function voorood(parameters) {
                var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
                dnnModal.show(modulePath, true, 550, 960, true, '');
            }
        </script>
    </body>
</html>