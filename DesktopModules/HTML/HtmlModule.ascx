<%@ Control language="C#" Inherits="DotNetNuke.Modules.Html.HtmlModule" CodeBehind="HtmlModule.ascx.cs" AutoEventWireup="false" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<dnn:DNNLabelEdit id="lblContent" runat="server" cssclass="Normal" enableviewstate="False" MouseOverCssClass="LabelEditOverClassML"
	LabelEditCssClass="LabelEditTextClass" EditEnabled="False" MultiLine="True" RichTextEnabled="True"
	ToolBarId="tbEIPHTML" RenderAsDiv="True" EventName="none" LostFocusSave="False" CallBackType="Simple" ClientAPIScriptPath="" LabelEditScriptPath="" WorkCssClass=""></dnn:DNNLabelEdit>
<DNN:DNNToolBar id="editorDnnToobar" runat="server" CssClass="eipbackimg" ReuseToolbar="true"
	DefaultButtonCssClass="eipbuttonbackimg" DefaultButtonHoverCssClass="eipborderhover">
	<DNN:DNNToolBarButton ControlAction="edit" ID="tbEdit" ToolTip="Edit" CssClass="eipbutton_edit" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="save" ID="tbSave" ToolTip="Save" CssClass="eipbutton_save" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="cancel" ID="tbCancel" ToolTip="Cancel" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="bold" ID="tbBold" ToolTip="Bold" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="italic" ID="tbItalic" ToolTip="Italic" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="underline" ID="tbUnderline" ToolTip="Underline" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="justifyleft" ID="tbJustifyLeft" ToolTip="JustifyLeft" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="justifycenter" ID="tbJustifyCenter" ToolTip="JustifyCenter" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="justifyright" ID="tbJustifyRight" ToolTip="JustifyRight" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="insertorderedlist" ID="tbOrderedList" ToolTip="OrderedList" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="insertunorderedlist" ID="tbUnorderedList" ToolTip="UnorderedList" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="outdent" ID="tbOutdent" ToolTip="Outdent" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="indent" ID="tbIndent" ToolTip="Indent" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="createlink" ID="tbCreateLink" ToolTip="CreateLink" runat="server"/>
</DNN:DNNToolBar>

<%-- --------------------------------------------------------------------------------------------------------- --%>
<%-- Start MyTokens Integration --%>

<script runat = "server" language = "c#">

    protected override void OnInit(System.EventArgs e) 
    {

        // force base token replacer to initialize
        DotNetNuke.Services.Tokens.TokenReplace dnnTknRepl = new DotNetNuke.Services.Tokens.TokenReplace();
        dnnTknRepl.ReplaceEnvironmentTokens("");

        if (true && HttpRuntime.Cache.Get("avt.MyTokens2.CorePatched") == "true") {
            base.OnInit(e);
            return;
        }

        Settings["MyTokensReplace"] = true;
            //Settings["MyTokensReplace"] = false;

            //if (Settings["TEXTHTML_ReplaceTokens"] != "") {
            //    if (Convert.ToBoolean(Settings["TEXTHTML_ReplaceTokens"]) == true) {
            //        Settings["MyTokensReplace"] = true;
            //    }
            //}
            
            //if (Settings["HtmlText_ReplaceTokens"] != "") {
            //    if (Convert.ToBoolean(Settings["HtmlText_ReplaceTokens"]) == true) {
            //        Settings["MyTokensReplace"] = true;
            //    }
            //}
    
            // Prevent Standard Token Replacement
            Settings["TEXTHTML_ReplaceTokens"] = false;
            Settings["HtmlText_ReplaceTokens"] = false;
    
        base.OnInit(e);
    }

    protected override void OnPreRender(System.EventArgs e) 
    {
        if (true && HttpRuntime.Cache.Get("avt.MyTokens2.CorePatched") == "true") {
            base.OnPreRender(e);
            return;
        }

        if (Convert.ToBoolean(Settings["MyTokensReplace"]) == true) {
                (lblContent.Controls[0] as LiteralControl).Text = Tokenize((lblContent.Controls[0] as LiteralControl).Text, ModuleConfiguration, false, true);
            }

        base.OnPreRender(e);
    }
    
    
    string Tokenize(string strContent, DotNetNuke.Entities.Modules.ModuleInfo modInfo, bool forceDebug, bool bRevertToDnn)
    {

        if (true && HttpRuntime.Cache.Get("avt.MyTokens2.CorePatched") == "true") {
            return strContent; // core is patched, so everything should already be tokenized
        }

        string cacheKey_Installed = "avt.MyTokens2.Installed";
        string cacheKey_MethodReplace = "avt.MyTokens2.MethodReplace";

        string bMyTokensInstalled = "no";
        System.Reflection.MethodInfo methodReplace = null;

        bool bDebug = forceDebug;
        if (!bDebug) {
            try { bDebug = !DotNetNuke.Common.Globals.IsTabPreview(); } catch { }
        }

        lock (typeof(DotNetNuke.Services.Tokens.TokenReplace)) {
            // first, determine if MyTokens is installed
            if (HttpRuntime.Cache.Get(cacheKey_Installed) == null) {

                // check again, maybe current thread was locked by another which did all the work
                if (HttpRuntime.Cache.Get(cacheKey_Installed) == null) {

                    // it's not in cache, let's determine if it's installed
                    try {
                        Type myTokensRepl = DotNetNuke.Framework.Reflection.CreateType("avt.MyTokens.MyTokensReplacer", true);
                        if (myTokensRepl == null)
                            throw new Exception(); // handled in catch

                        bMyTokensInstalled = "yes";

                        // we now know MyTokens is installed, get ReplaceTokensAll methods
                        methodReplace = myTokensRepl.GetMethod(
                            "ReplaceTokensAll",
                            System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Static,
                            null,
                            System.Reflection.CallingConventions.Any,
                            new Type[] { 
                                typeof(string), 
                                typeof(DotNetNuke.Entities.Users.UserInfo), 
                                typeof(bool),
                                typeof(DotNetNuke.Entities.Modules.ModuleInfo)
                            },
                            null
                        );

                        if (methodReplace == null) {
                            // this shouldn't really happen, we know MyTokens is installed
                            throw new Exception();
                        }

                    } catch {
                        bMyTokensInstalled = "no";
                    }

                    // cache values so next time the funciton is called the reflection logic is skipped
                    HttpRuntime.Cache.Insert(cacheKey_Installed, bMyTokensInstalled);
                    if (bMyTokensInstalled == "yes") {
                        HttpRuntime.Cache.Insert(cacheKey_MethodReplace, methodReplace);
                    }
                }
            }
        }

        bMyTokensInstalled = HttpRuntime.Cache.Get(cacheKey_Installed).ToString();
        if (bMyTokensInstalled == "yes") {
            methodReplace = (System.Reflection.MethodInfo)HttpRuntime.Cache.Get(cacheKey_MethodReplace);
            if (methodReplace == null) {
                HttpRuntime.Cache.Remove(cacheKey_Installed);
                return Tokenize(strContent, modInfo, forceDebug, bRevertToDnn);
            }
        } else {
            // if it's not installed return string or tokenize with DNN replacer
            if (!bRevertToDnn) {
                return strContent;
            } else {
                DotNetNuke.Services.Tokens.TokenReplace dnnTknRepl = new DotNetNuke.Services.Tokens.TokenReplace();
                dnnTknRepl.AccessingUser = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo();
                dnnTknRepl.DebugMessages = bDebug;
                if (modInfo != null)
                    dnnTknRepl.ModuleInfo = modInfo;

                // MyTokens is not installed, execution ends here
                return dnnTknRepl.ReplaceEnvironmentTokens(strContent);
            }
        }

        // we have MyTokens installed, proceed to token replacement
        return (string)methodReplace.Invoke(
            null,
            new object[] {
                strContent,
                DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo(),
                bDebug,
                modInfo
            }
        );

    }

</script>

<%-- End MyTokens Integration --%>
<%-- --------------------------------------------------------------------------------------------------------- --%>

