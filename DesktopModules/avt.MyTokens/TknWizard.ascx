<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TknWizard.ascx.cs" Inherits="avt.MyTokens.TknWizard" %>

<div id = "tplTknWizard" class = "tknWizardRoot" style = "display: none; height: 460px;">
    <div class = "tknwizard wizStep1">

        <div class = "tknwizardC">

            <div class = "wizStep">Step <b>1</b> of <b>3</b></div>
            <div class = "wizTitle">General Information</div>
            <div style = "clear: both;"></div>
            <div class = "grayed_desc">Focus controls for additional help...</div>
            <br /><br />
        
            <div class = "wizTextInputLabel " style = "font-weight: bold;">Name</div>
            <span style = "font-weight: bold;">
                [ 
                    <select name = "wiz_tknNs" class = "tooltip_hover " style = "width: 160px;" title = "Select a namespace under which to place this token.">
                    </select>
                :
                    <input type = "text" name = "wiz_tknName" class = "tooltip_focus wizTextInputSmall gray_text" title= "The token name is used to access this token from other modules. It must not contain spaces. It also has to be unique." />
                ]
            </span>
            <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
            <span class = "wizerror wizerrTokenName" style = "margin-left: 160px;"></span>
            <br />
        
            <div class = "wizTextInputLabel " style = "">Description</div> <textarea name = "wiz_tknDesc" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 70px;" title = "Optionally, provide a descriptive text for this token."></textarea><br /><br />
            <div class = "wizTextInputLabel " style = "">Source</div> 
            <select name = "wiz_tknSourceType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select a source from where data is to be retrieved.">
                <option value = "string">Constant String</option>
                <option value = "db">Database</option>
                <option value = "http">Http Request</option>
                <option value = "file">File System</option>
                <option value = "ftp">FTP</option>
                <option value = "execType">Execute Type (implement IExecutableToken)</option>
                <option value = "mail">Mail</option>
            </select><br /><br />

            <div class = "wizTextInputLabel " style = "">Default Value</div> <input type = "text" name = "wiz_tknDefVal" class = "tooltip_focus wizTextInputSmall gray_text" style = "" title = "Specify default value to use if token doesn't return any data. Note that the default value can contain other tokens."/><br />
            <div class = "grayed_desc" style = "margin-left: 130px">Can contain other tokens. Can be overriden at invoke time using syntax [Namespace:Token=DefaultValue]</div>
            <br />

            <div class = "wizTextInputLabel " style = "width: 120px;">Cache Time</div> 
            <input type = "text" name = "wiz_tknCacheTime" class = "tooltip_focus wizTextInputSmall gray_text" style = "width: 80px;" title = "Time in <u>seconds</u> to keep this token cached. Caching helps improve performance as it saves roundtrips to database or external files for xml tokens. Set to 0 to disable caching."/>
            Layer <select name="wiz_tknCacheLayer">
                <option value="global">Global (Per Host)</option>
                <option value="portal">Per Portal</option>
                <option value="role">Per Role</option>
                <option value="user">Per User</option>
                <option value="usersession">Per User Session</option>
            </select>
            <br />
            <div class = "grayed_desc" style = "margin-left: 130px">
                If cache is needed, make sure the cache layer matches the token specification (for example, if you use [Portal:PortalId] token in the definition then set the cache layer to Per Portal).
            </div>
            <div style = "clear: both;"></div>
        </div>
        
        <br /><br /><br />
        <div style = "" class = "wizBar">
            <div style = "float: right; margin-right: 160px;" >
                <a href = "javascript: ;" class = "wizNext blue btn_border" onclick = "avt.mt.tkn.submitGeneral(avt.mt.$(this).parents('.tknWizardRoot:first'));"><b>Next</b> <img src = "<%=TemplateSourceDirectory %>/res/rt.gif" border = "0" align = "absmiddle" style = "margin-left: 3px;"/></a>
            </div>
            <a href = "javascript: ;" onclick = "avt.mt.tkn.hideNewToken(avt.mt.$(this).parents('.tknWizardRoot:first'));" class = "blue cancel_icon" ><b> Cancel</b></a>
            <div style = "clear: both;"></div>
        </div>
    </div>

    <div class = "tknwizard wizStep2">
        
        <div class = "tknwizardC">
            <div class = "wizStep">Step <b>2</b> of <b>3</b></div>
            <div class = "wizTitle">Token Source: <span class = "tknType"></span></div>
            <div style = "clear: both;"></div>
            <div class = "grayed_desc">Focus controls for additional help...</div>
            <br /><br />
        
            <div class = "wizSrc"></div>
        </div>
        <br /><br /><br />
        <div style = "" class = "wizBar">
            <div style = "float: left; margin-left: 160px;">
                <a href = "javascript: ;" class = "wizPrev blue btn_border" onclick = "avt.mt.tkn.showGeneral(avt.mt.$(this).parents('.tknWizardRoot:first'));"><img src = "<%=TemplateSourceDirectory %>/res/lt.gif" border = "0" align = "absmiddle" style = "margin-right: 3px;" /><b>Prev</b></a>
            </div>
            <div style = "float: right;margin-right: 160px;" >
                <a href = "javascript: ;" class = "wizNext blue btn_border" onclick = "avt.mt.tkn.submitSource(avt.mt.$(this).parents('.tknWizardRoot:first'));"><b>Next</b> <img src = "<%=TemplateSourceDirectory %>/res/rt.gif" border = "0" align = "absmiddle" style = "margin-left: 3px;"/></a>
            </div>
            <a href = "javascript: ;" onclick = "avt.mt.tkn.hideNewToken(avt.mt.$(this).parents('.tknWizardRoot:first'));"  class = "blue cancel_icon" ><b>Cancel</b></a>
            <div style = "clear: both;"></div>
        </div>
    </div>

    <div class = "tknwizard wizStep3">
        
        <div class = "tknwizardC">
            <div class = "wizStep">Step <b>3</b> of <b>3</b></div>
            <div class = "wizTitle">Data Parsing</div>
            <div style = "clear: both;"></div>
            <div class = "grayed_desc">Focus controls for additional help...</div>
            <br /><br />

            <div class = "wizParse"></div>
        </div>
        <br /><br /><br />
        <div style = "" class = "wizBar">
            <div style = "float: left; margin-left: 160px;">
                <a href = "javascript: ;" class = "wizPrev blue btn_border" onclick = "avt.mt.tkn.showSource(avt.mt.$(this).parents('.tknWizardRoot:first'));"><img src = "<%=TemplateSourceDirectory %>/res/lt.gif" border = "0" align = "absmiddle" style = "margin-right: 3px;" /><b>Prev</b></a>
            </div>
            <div style = "float: right;  margin-right: 160px;" >
                <a href = "javascript: ;" class = "wizNext blue btn_border" onclick = "avt.mt.tkn.submitParsing(avt.mt.$(this).parents('.tknWizardRoot:first'));"><b>Save</b> <img src = "<%=TemplateSourceDirectory %>/res/rt.gif" border = "0" align = "absmiddle" style = "margin-left: 3px;"/></a>
            </div>
            <a href = "javascript: ;" onclick = "avt.mt.tkn.hideNewToken(avt.mt.$(this).parents('.tknWizardRoot:first'));" class = "wizSave blue cancel_icon" ><b>Cancel</b> </a>
            <span class = "TknNsSaving">Saving... Please Wait...</span>
            <div style = "clear: both;"></div>
        </div>
    </div>


    <br /><br /><br />

</div>


<div id = "tplTknCt" style = "display: none;">
    <div class = "wizTextInputLabel " style = "float: none; text-align: left;">Input Constant String</div>
    <textarea name = "wiz_ctBody" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 120px;" title = "The token will be replaced with the string provided in this field. Notice that the string can call to other tokens by using the syntax [Namespace:TokenName] and selecting the Replace Tokens option in the parser."></textarea><br />
    <span class = "wizerror wizerrCtSrc"></span>
    <br />
    
    <span class = "grayed_desc">Can contain other tokens if option enabled in parser (next wizard step).</span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left;">Parser</div>
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the string should be parsed. No Parsing means the entire string will be replace where the token appears. Other parsing methods include interpreting the response as XML or JSON.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />
</div>

<div id = "tplTknDb" style = "display: none;">
    
    <div class = "wizTextInputLabel" style = "float: none; text-align: left; width: auto;">Synchronize Token Source</div>
    <select name = "wiz_dbSync" class = "tooltip_hover wizTextInputXLarge gray_text" style = "" title = "Choose a token name to synchronize with or switch back to Not Sync." onchange = "avt.mt.tkn.tknSrcType.db.syncChanged(this);"></select>
    <ul class = "syncList wiz_dbSyncList gray_text" style = ""></ul><br />
    
    <span class = "grayed_desc">
        <b>Obsolote: </b>Instead of using this feature you can specify have a single token and specify multiple columns to extract. Then, use the dot notation to invoke each column.<br />
        Synchronized Database Token Sources share the same connection string and SQL Query. <br />
        Changing these for one token will reflect in all other tokens that are synchronized. <br />
    </span>
    <br /><br />
    
    <div class = "wizTextInputLabel" style = "float: none; text-align: left; width: auto;">Database Connection String<span class = "srcSync"> (synchronized)</span></div>
    <input type = "text" name = "wiz_dbConnStr" class = "tooltip_focus wizTextInputXLarge gray_text" style = "" title = "If this field is empty, My Tokens will connect to the DotNetNuke database to run the query. Provide the name of a connection string or the connection string to connect to a different database." /><br />
    <span class = "grayed_desc">Leave empty to connect to the DotNetNuke database.<br />Can contain other tokens.</span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Input Database Query<span class = "srcSync"> (synchronized)</span></div>
    <textarea name = "wiz_dbSql" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 120px;" title = "The query is used to retrieve data. Notice that it can call to other tokens by using the syntax [Namespace:TokenName]."></textarea><br />
    <span class = "wizerror wizerrDbSql"></span><br />
    <span class = "grayed_desc">Can contain other tokens; use {databaseOwner} and {objectQualifier} placeholders to make query generic (easy to migrate to other sites)</span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left;">Column Names (one per line)</div>
    <textarea name = "wiz_dbColumnNames" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "" title = "These are the columns that will be extracted from the result set. To extract more than one column, specify one column per line. Each column will then be accessed like this [Namespace:TokenName.ColumnName]"></textarea><br />
    <span class = "wizerror wizerrDbCol"></span><br />
    <span class = "grayed_desc">Can contain other tokens</span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left;">Default Column</div>
    <input type = "text" name = "wiz_dbColumn" class = "tooltip_focus wizTextInputXLarge gray_text" style = "" title = "This is the column to use when the token is invoked without a column name like this [Namespace:Token]."><br />
    <span class = "grayed_desc">Can contain other tokens</span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left;">Parser</div>
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the returned field should be parsed. No Parsing means the entire string will be replace where the token appears. Other parsing methods include interpreting the response as XML or JSON.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />
</div>

<div id = "tplTknHttp" style = "display: none;">

    <div class = "wizTextInputLabel" style = "float: none; text-align: left; width: auto;">Synchronize Token Source</div>
    <select name = "wiz_httpSync" class = "tooltip_hover wizTextInputXLarge gray_text" style = "" title = "Choose a token name to synchronize with or switch back to Not Sync." onchange = "avt.mt.tkn.tknSrcType.http.syncChanged(this);"></select>
    <ul class = "syncList wiz_httpSyncList gray_text" style = ""></ul><br />

    <span class = "grayed_desc">
        Synchronized Http Token Sources share the same URL and parameters. <br />
        Changing these for one token will reflect in all other tokens that are synchronized. <br />
        Normally, this is intended for when multiple tokens need to be extracted from same Http Request.
    </span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">URL<span class = "srcSync"> (synchronized)</span></div> 
    <input type = "text" name = "wiz_tknUrl" class = "tooltip_focus wizTextInputXLarge gray_text" title= "Provide the URL where the request will be made. The URL can contain other tokens." />
    <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
    <span class = "wizerror wizerrHttpUrl" style = "margin-left: 130px;"></span>
    <br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Get Parameters<span class = "srcSync"> (synchronized)</span></div> 
    <textarea  name = "wiz_tknGetParams" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 120px;" title = "Optionally, provide GET parameters to send to given URL. Input one parameter per line, format is <i>name=value</i>. Both the name and the value can contain other tokens."></textarea><br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Post Parameters<span class = "srcSync"> (synchronized)</span></div> 
    <textarea  name = "wiz_tknPostParams" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 120px;" title = "Optionally, provide POST parameters to send to given URL. Input one parameter per line, format is <i>name=value</i>. Both the name and the value can contain other tokens."></textarea><br /><br />

    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">HTTP Headers<span class = "srcSync"> (synchronized)</span></div> 
    <textarea  name = "wiz_tknHttpHeaders" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 120px;" title = "This is especially useful to integrate with REST Web Services that expect some of the data to pass thourgh the headers.<br/>Format is <br/><i>&amp;lt;HeaderName&amp;gt;: &amp;lt;HeaderValue&amp;gt;</i><br/>Put one pair per line."></textarea><br /><br />

    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Parsing</div> 
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the response should be parsed. No Parsing means the entire response from the server will be displayed when token is called.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />
    
    <%--<div class = "wizTextInputLabel " style = "">Test Request</div> 
    <a href = "javascript: ;" onclick = "avt.mt.tkn.testHttp();">Make Request</a><br />
    <textarea class = "wizTextInputLarge gray_text" style = "height: 120px;" title = "" readonly = "readonly">Response will be loaded here once you click Make Request...</textarea><br /><br />--%>
    
</div>


<div id = "tplTknFile" style = "display: none;">
    <div class = "wizTextInputLabel" style = "float: none; text-align: left; width: auto;">Synchronize Token Source</div>
    <select name = "wiz_fileSync" class = "tooltip_hover wizTextInputXLarge gray_text" style = "" title = "Choose a token name to synchronize with or switch back to Not Sync." onchange = "avt.mt.tkn.tknSrcType.file.syncChanged(this);"></select>
    <ul class = "syncList wiz_fileSyncList gray_text" style = ""></ul><br />

    <span class = "grayed_desc">
        Synchronized File System Token Sources share the same file path. <br />
        Changing it for one token will reflect in all other tokens that are synchronized. <br />
    </span>
    <br /><br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">File Path<span class = "srcSync"> (synchronized)</span></div> 
    <input type = "text" name = "wiz_tknPath" class = "tooltip_focus wizTextInputXLarge gray_text" title= "Provide the URL where the request will be made. The URL can contain other tokens." />
    <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
    <span class = "wizerror wizerrFilePath" style = ""></span>
    <div class = "grayed_desc">
        The file path can contain other tokens.<br />
        Also, the file can be absolute (for example <i>c:\file.txt</i>) or relative to website root 
        (for example <i>~/file.txt</i>)
    </div>
    <br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Parsing</div> 
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the response should be parsed. No Parsing means the entire response from the server will be displayed when token is called.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />
    
</div>


<div id = "tplTknFtp" style = "display: none;">

    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">FTP Server</div> 
    <select name = "wiz_tknSrv" class = "wizTextInputXLarge gray_text" onchange="if (avt.mt.$(this).val() == '0') { editServer(undefined, 'ftp', avt.mt.$(this)); this.selectedIndex = 0; }"></select>
    <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
    <span class = "wizerror wizerrSrv" style = ""></span>
    <div class = "grayed_desc">
        Select existing server or define new one...
    </div>
    <br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">File Path</div> 
    <input type = "text" name = "wiz_tknPath" class = "tooltip_focus wizTextInputXLarge gray_text" style = "" title = "Provide path to the file to grab from the FTP Server. For example: <i>/folder/subfolder/myfile.txt</i>" />
    <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
    <span class = "wizerror wizerrPath" style = ""></span>
    <div class = "grayed_desc">Can contain other tokens.</div>
    <br />

    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Parsing</div> 
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the response should be parsed. No Parsing means the entire response from the server will be displayed when token is called.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />
    
</div>


<div id = "tplTknExecType" style = "display: none;">
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Type</div> 
    <input type = "text" name = "wiz_tknExecType" class = "tooltip_focus wizTextInputXLarge gray_text" title= "Fully.Qualified.Class,&nbsp;AssmblyName" />
    <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
    <span class = "wizerror wizerrExecType" style = ""></span>
    <div class = "grayed_desc">
        Input the type to invoke. 
        The type field can contain other tokens.<br />
    </div>
    <br />
    
    <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Parameters</div> 
    <textarea type = "text" name = "wiz_tknExecTypeParams" wrap="off" class = "tooltip_focus wizTextInputXLarge gray_text" style="height: 80px;" title= "Provide a string to send to the IExecutableParam class."></textarea>
    <br />
    <br />
    
    <%--<div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Parsing</div> 
    <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the response should be parsed. No Parsing means the entire response from the server will be displayed when token is called.">
        <option value = "string">No Parsing</option>
        <option value = "striptags">Strip Xml/Html Tags</option>
        <option value = "xml">XML (XPath) Parsing</option>
        <option value = "json">JSON (to XML, then XPath) Parsing</option>
        <option value = "regexp">Regular Expression</option>
        <option value = "xslt">XSL Transformation</option>
    </select><br /><br />--%>
    
</div>


<div id = "tplTknMail" style = "display: none;">

    <div style = "color: red; margin: 0 20px 20px 20px;">
        The Mail Token Source is EXPERIMENTAL. It will only retrieve latest email.<br />
        Please <a href = "http://www.dnnsharp.com/Forums/tabid/99/forumid/10/scope/threads/Default.aspx">send us feebdack</a> with your requirements and we'll implemented them in a future
        version as we add filters for retrieving emails.
    </div>

    <div class = "wizTextInputLabel" style = "float: none; text-align: left; width: auto;">Synchronize Token Source</div>
    <select name = "wiz_mailSync" class = "tooltip_hover wizTextInputXLarge gray_text" style = "" title = "Choose a token name to synchronize with or switch back to Not Sync." onchange = "avt.mt.tkn.tknSrcType.mail.syncChanged(this);"></select>
    <ul class = "syncList wiz_mailSyncList gray_text" style = ""></ul><br />

    <span class = "grayed_desc">
        Synchronized Mail Token Sources share the same Server Name, Protocol, Username and Password. <br />
        Changing these for one token will reflect in all other tokens that are synchronized. <br />
        Normally, this is intended for when multiple emails need to be extracted from same Mail Server.
    </span>
    <br /><br />
    
    <div class = "wizTitle">Connection</div>
    <div style = "margin-left: 20px">
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Protocol<span class = "srcSync"> (synchronized)</span></div> 
        <select name = "wiz_tknProtocol" class = "tooltip_focus wizTextInputLarge gray_text" title= "Prefered protocol is IMAP as it offers more features." onchange = "avt.mt.tkn.tknSrcType.mail.setDefaultPort(avt.mt.$(this).parents('.tknWizardRoot:first'));">
            <option value = "imap">IMAP</option>
            <option value = "pop3">POP3</option>
        </select>
        <br /><br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Server Name<span class = "srcSync"> (synchronized)</span></div> 
        <input type = "text" name = "wiz_tknHost" class = "tooltip_focus wizTextInputLarge gray_text" title= "Provide the name of the server to connect to. It can contain other tokens." />
        <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
        <span class = "wizerror wizerrHost" style = ""></span>
        <div class = "grayed_desc">Can contain other tokens.</div>
        <br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">
            Use SSL
            <input type = "checkbox" name = "wiz_tknSSL" class = "gray_text" onchange = "avt.mt.tkn.tknSrcType.mail.setDefaultPort(avt.mt.$(this).parents('.tknWizardRoot:first'));" />
            <span class = "srcSync"> (synchronized)</span>
        </div> 
        <label></label>
        <div class = "grayed_desc">Some providers (such as GMail) require SSL to connect over POP3 or IMAP.</div>
        <br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Port<span class = "srcSync"> (synchronized)</span></div> 
        <input type = "text" name = "wiz_tknPort" class = "tooltip_focus wizTextInputXSmall gray_text" title= "Provide the port to connect over. It can contain other tokens." />
        <asp:Image ID="Image7" runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
        <span class = "wizerror wizerrPort" style = ""></span>
        <br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Username<span class = "srcSync"> (synchronized)</span></div> 
        <input type = "text" name = "wiz_tknUser" class = "tooltip_focus wizTextInputLarge gray_text" title= "Can contain other tokens." />
        <asp:Image ID="Image8" runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
        <span class = "wizerror wizerrUser" style = ""></span>
        <br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Password<span class = "srcSync"> (synchronized)</span></div> 
        <input type = "password" name = "wiz_tknPass" class = "tooltip_focus wizTextInputLarge gray_text" title= "Can contain other tokens." />
        <asp:Image ID="Image9" runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
        <span class = "wizerror wizerrPass" style = ""></span>
        <br />
    </div>
    
    <br /><br />
    <div class = "wizTitle">Retrieve Email</div>
    <div style = "margin-left: 20px">
        <br />
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Get Email</div> 
        <select name = "wiz_tknGetEmail" class = "tooltip_focus wizTextInputLarge gray_text" title= "">
            <option value = "newest">Newest Unread Email</option>
        </select>
        <div class = "grayed_desc">
            This option will allow retrieving emails by filters on subject, sender, etc.
            For now, only option available is to retrieve latest email.
        </div>
        <br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">Get Part</div> 
        <select name = "wiz_tknGetPart" class = "tooltip_focus wizTextInputLarge gray_text" title= "">
            <option value = "subject">Subject</option>
            <option value = "body">Body</option>
            <option value = "from">From</option>
            <option value = "to">To</option>
            <option value = "attachment1">1st Attachment</option>
        </select>
        <br /><br />
        
        <div class = "wizTextInputLabel " style = "float: none; text-align: left; width: auto;">
            Mark as Read
            <input type = "checkbox" name = "wiz_tknMarkRead" class = "gray_text" />
        </div> 
        <label></label>
        <div class = "grayed_desc">
            If this option is checked, email will be marked as read after is retrieved.
            Email Servers will not return read emails when accessed over POP3 by same client.
        </div>
        <br />
        
    </div>
    
    <br /><br />
    <div class = "wizTitle">Parsing</div>
    <div style = "margin-left: 20px">
        <br />
        <select name = "wiz_tknParseType" class = "tooltip_hover wizTextInputLarge gray_text" style = "" title = "Select how the response should be parsed. No Parsing means the entire response from the server will be displayed when token is called.">
            <option value = "string">No Parsing</option>
            <option value = "striptags">Strip Xml/Html Tags</option>
            <option value = "xml">XML (XPath) Parsing</option>
            <option value = "json">JSON (to XML, then XPath) Parsing</option>
            <option value = "regexp">Regular Expression</option>
            <option value = "xslt">XSL Transformation</option>
        </select><br /><br />
    </div>
    
</div>


<div id = "tplTknParseNot" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">No Parsing</div>
    <div class = "grayed_desc">No additional text processing will be made...</div>
    
    <br />
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens
        <input type = "checkbox" class = "wiz_tknNoParseReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknNoParseDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />
</div>

<div id = "tplTknParseStrip" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">Strip xml/html tags</div>
     <div class = "grayed_desc">MyTokens will remove tags from string...</div>
    
    <br />
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens
        <input type = "checkbox" class = "wiz_tknStripReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknStripDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />
</div>

<div id = "tplTknParseXml" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">XML(XPath) Parser</div><br /><br />
    <div class = "wizTextInputLabel " style = "">XPath Expression</div> 
    <textarea  name = "wiz_tknXmlXPath" wrap="off" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 120px;" title = "The XPath expression is used to select a value from the XML that will the token will output."></textarea><br />
    <span class = "wizerror wizerrParseXml" style = "margin-left: 130px;"></span><br />
    <div class = "grayed_desc">
        For a quick start on XPath, read <a href = "http://www.w3schools.com/XPath/xpath_syntax.asp">XPath Tutorial on W3Schools</a>.
    </div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Match Occurance #
        <input type = "text" name = "wiz_tknXmlIndex" class = "tooltip_focus wizTextInputXSmall gray_text" style = "margin-left: 4px;" />
    </label>
    <span class = "wizerror wizerrParseXmlIndex" style = "margin-left: 10px;"></span><br />
    <div class = "grayed_desc">If XPath matches more than one nodes, use this option to specify which node to return. This index is 0 based (0 is first match).
        Use -1 to return the total number of matched results.
    </div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens
        <input type = "checkbox" class = "wiz_tknXmlReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknXmlDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />

</div>

<div id = "tplTknParseJson" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">JSON (to XML, then XPath) Parser</div><br /><br />
    <div class = "wizTextInputLabel " style = "">XPath Expression</div>
    <textarea  name = "wiz_tknJsonExpr" wrap="off" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 120px;" title = "The Json expression is used to select a value. MyTokens will transform the json to an XML and encapsulate it inside a &amp;lt;json&amp;gt; root node (this is because json doesn't have a name for the root object, or root object could actually be an array and XML allows only one root element). The JSON expression that you input into this field is the XPATH that runs against the resulting XML."></textarea><br />
    <span class = "wizerror wizerrParseJson" style = "margin-left: 130px;"></span><br />
    <div class = "grayed_desc">
        Write the JSON expression as you would write an XPATH against an XML where the root node is called <u>json/obj</u>. Note that if the response is an array, json will contain multiple <em>obj</em> entries.
        For a quick start on XPath, read <a href = "http://www.w3schools.com/XPath/xpath_syntax.asp">XPath Tutorial on W3Schools</a>.<br />
        <br />
        For example, if json is {a:"Value A", b: [{c:1},{c:2}]}, there are a few methods to display value "2" in second object in array "b":
        /json/b[2]/c (absolute path), //b[2]/c (// means any level), //b[c=2]/c (select b node that has a c equal to 2), etc.
    </div>
    <br /><br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Match Occurance #
        <input type = "text" name = "wiz_tknJsonIndex" class = "tooltip_focus wizTextInputXSmall gray_text" style = "margin-left: 4px;" />
    </label>
    <span class = "wizerror wizerrParseJsonIndex" style = "margin-left: 10px;"></span><br />
    <div class = "grayed_desc">If XPath matches more than one nodes, use this option to specify which node to return. This index is 0 based (0 is first match).</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens
        <input type = "checkbox" class = "wiz_tknJsonReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknJsonDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />
</div>


<div id = "tplTknParseRegExp" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">RegExp Parser</div><br /><br />
    <div class = "wizTextInputLabel" style = "">RegExp Expression</div>
    <textarea  name = "wiz_tknRegExp" wrap="off" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 120px;" title = "The regular expression is executed against the source and the match is outputed by the token."></textarea><br />
    <span class = "wizerror wizerrParseRegExp" style = "margin-left: 130px;"></span>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Match Occurance #
        <input type = "text" name = "wiz_tknRegExpIndex" class = "tooltip_focus wizTextInputXSmall gray_text" style = "margin-left: 4px;" />
    </label>
    <span class = "wizerror wizerrParseRegExp" style = "margin-left: 10px;"></span><br />
    <div class = "grayed_desc">
        If regular expression returns more than one match, use this option to specify which match to use. This index is 0 based (0 is first match).<br /><br />
        For example, if input string is <b>Test Rest</b> and regexp is <b>(.)est</b> then there will be two matches, <b>T</b> from Test and <b>R</b> form Rest.
    </div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens
        <input type = "checkbox" class = "wiz_tknRegexpReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknRegexpDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />
</div>



<div id = "tplTknParseXslt" style = "display: none;">
    <div style = "font-weight: bold; border-bottom: 1px dashed #b2b2b2;">XSL Transformation</div>
    <div class = "grayed_desc">This parser converts the HTTP response to XML then transforms it against the XSL template provided below.</div>
    <br /><br />

    <div class = "wizTextInputLabel " style = "">XSL Template</div> 
    <textarea  name = "wiz_tknXslTpl" wrap="off" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 320px; width: 500px;" title = "The XSL Template is used to transform the XML structure to relevant HTML code."></textarea><br />
    <span class = "wizerror wizerrParseXsl" style = "margin-left: 130px;"></span><br />
    <div class = "grayed_desc">
        For a quick start on XSL, read <a href = "http://www.w3schools.com/xsl/">XSLT Tutorial on W3Schools</a>.
    </div>
    <br />
    
    
    <label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Replace Response Tokens 
        <input type = "checkbox" class = "wiz_tknXsltReplace" />
    </label>
    <div class = "grayed_desc">Check this option to have MyTokens recursively replace tokens.</div>
    <br />
    
    <%--<label class = "wizTextInputLabel " style = "width: auto; float: none;">
        Decode HTML
        <input type = "checkbox" class = "wiz_tknXsltDecodeHtml" />
    </label>
    <div class = "grayed_desc">If the result is HTML encoded, check this option to have MyTokens decode it.</div>
    <br /><br /><br />--%>
    
    <div class = "" style = "color: #825555;">Click Save below to persist this token definition.</div> 
    <br /><br />

</div>

