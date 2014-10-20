<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TknNs.ascx.cs" Inherits="avt.MyTokens.TknNs" %>


<div id = "dlgAddEditNamespace" class = "tknAddEditNamespace" style = "display: none;">

    <input type = "hidden" class = "nsId" value = "-1" />

    <div style="color: #cc2222; font-size: 12px; margin: 10px 0;">
        You need to create namespaces before you can create cutom tokens and scripts...
    </div>
    
    <div class = "wizTextInputLabel " style = "">Name</div> 
    <input type = "text" class = "tooltip_focus wizTextInputLarge gray_text nsName" title= "A token namespace acts as a container for tokens. It appears before token name such as in [Namespace:TokenName]." /><asp:Image ID="Image11" runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><span class = "wizerror" id = "wizerrTokenName"></span> <br />
    <span class = "wizerror reqName" style = "margin-left: 130px;">Token Source Name is required and must not contain spaces.<br /><br /></span>
    <span class = "wizerror uniqueName" style = "margin-left: 130px;">A Token Source with same name already exists.<br /><br /></span>
    
    <div class = "wizTextInputLabel " style = "">Description</div> 
    <textarea class = "tooltip_focus wizTextInputLarge gray_text nsDesc" style = "height: 120px;" title = "Optionally, provide a descriptive text for this token source."></textarea><br /><br />
    <div class = "wizTextInputLabel " style = ""></div>
    <label class = "wizTextInputLabel tooltip_hover" style = "float: none;" title="Creates a namespace that can be accessed from all portals. This option is available to Super Users only. Adminsitrators can only create tokens on their portal.">
        <input type = "checkbox" class = "nsAllPortals" /> Available on all portals
    </label>

    <div style = "clear: both;"></div>
    <br />
    <div class = "TknNsSaving">Saving... Please Wait...</div>
    <br />
</div>


<div id = "tplViewNamespace" class = "tknViewNamespace main_auto_scroll" style = "display: none;">
    <div >
        <div class = "wizTitle">Token Namespace Information</div>
        <div class = "bk_token">
            <span style = "display: none;" class = "nsId"></span>
            <div style = "float: left;">
                <div style = "margin-top: 6px;">
                    <span class = "text_gray_medium"><b>Name:</b> </span> <span class = "nsName text_green"></span>
                </div>
                 <div style = "margin-top: 6px;">
                    <span class = "text_gray_medium"><b>Description:</b> </span> <span class = "nsDesc text_green"></span>
                </div>
                 <div style = "margin-top: 6px;">
                    <span class = "text_gray_medium"><b>Available on all portals:</b> </span> <span class = "nsAllPortals text_green"></span>
                </div>
             </div>   
             <div style = "float: right; text-align:right; margin-right: 25px; margin-top: 42px;">
                <a href = "javascript: ;" onclick = "avt.mt.tkn.newToken(jQuery(this).parents('.tknViewNamespace').find('.nsId:first').text());" class = "blue add_icon">New Token</a>
                <a href = "javascript: ;" onclick = "editScript(-1, null, null, null, null, null, 0, null, null);" class = "blue add_icon">New Script</a>
                <br />
                <a href = "javascript: ;" onclick = "avt.mt.studio.editTknNs(jQuery(this).parents('.tknViewNamespace').find('.nsId:first').text());" class = "blue edit_icon"> Edit Namespace</a>
                <a href = "javascript: ;" onclick = "avt.mt.studio.deleteTknNs(jQuery(this).parents('.tknViewNamespace').find('.nsId:first').text());" class = "blue delete_icon"> Delete Namespace</a>
             </div>
             <div style = "clear: both"></div>
         </div>
    </div>
    
    <br /><br />
    <div>
        <div class = "wizTitle">Tokens / Templates</div>
        <div class = "tknList"></div>
        <br/>
        <button onclick = "avt.mt.tkn.newToken(jQuery(this).parents('.tknViewNamespace').find('.nsId:first').text()); return false;" class = "blue btnjQuery">New Token</button>
        <button onclick = "editScript(-1, jQuery(this).parents('.tknViewNamespace').find('.nsId:first').text(), null, null, null, null, 0, null, null); return false;" class = "blue btnjQuery">New Script</button>
        <br/>
        <br/>

    </div>
</div>


<div id = "tplViewPredefNamespace" class = "tknViewNamespace main_auto_scroll" style = "display: none;">
    <div >
        <div class = "wizTitle">Predefined Token Information</div>
        <div class = "bk_token">
            <span style = "display: none;" class = "nsId"></span>
            <div style = "margin-top: 6px;">
                <span class = "text_gray_medium"><b>Name:</b> </span> <span class = "nsName text_green"></span>
            </div>
             <div style = "margin-top: 6px;">
                <span class = "text_gray_medium"><b>Description:</b> </span> <span class = "nsDesc text_green"></span>
            </div>
            <div style = "margin-top: 6px;">
                <span class = "text_gray_medium"><b>Values:</b> </span> <span class = "nsVal text_green"></span>
            </div>
            <div style = "margin-top: 6px;">
                <span class = "text_gray_medium"><b>Usage:</b> </span> <span class = "nsUsage text_green"></span>
            </div>
             <div style = "margin-top: 6px;">
                <span class = "text_gray_medium"><b>Available on all portals:</b> </span> <span class = "nsAllPortals text_green"></span>
            </div>
         </div>
    </div>
    
</div>

<a id = "tplTestTokenLink" class = "text_gray_medium blue" style="display: none;" href = "javascript: ;" onclick = "avt.mt.tkn.testToken(jQuery(this).text());" title="Click to test..."></a>

<div id = "tplTokenSummary" class = "tokenSummaryRoot bk_token" style = "display: none;">

    <div style = "">
        <div class = "inputLabel ui-state-default" style="padding: 2px;">
            <div style = "float: right; margin-right: 16px; margin-top: 2px;">
                 <span style = "margin-left: 6px; margin-bottom: 5px;">
                    <a href = "javascript: ;" onclick = "avt.mt.tkn.editToken(jQuery(this).parents('.tokenSummaryRoot:first'));" class = "blue edit_icon">Edit</a>
                    <a href = "javascript: ;" onclick = "avt.mt.tkn.cloneToken(jQuery(this).parents('.tokenSummaryRoot:first'));" class = "blue clone_icon">Clone</a>
                    <a href = "javascript: ;" onclick = "if (confirm('Are you sure you want to delete this token?')) { avt.mt.tkn.deleteToken(jQuery(this).parents('.tokenSummaryRoot:first')); }" class = "blue delete_icon">Delete</a>
                </span>
            </div>
            <span class = "tknName text_blue_strong"></span> (<span class = "text_gray_small">id: </span><span class = "tknId text_gray_small"></span>)
        </div>
        <div style = "margin: 10px;">
            <div class = "grayed_desc text_gray_small">
                <span class = "tknDesc"></span>
            </div>
            <div style = "margin-left: 0px; margin-bottom: 5px;">
                <span class = "inputLabel text_gray_small">Usage:</span>
                <span class="tknUsage"></span>
            </div>
            <div style = "margin-left: 0px; margin-bottom: 5px;">
                <span class = "inputLabel text_gray_small">Source:</span>
                <span class = "tknSource text_gray_medium"></span>
            </div>
            <div style = "margin-left: 0px; margin-bottom: 5px;">
                <span class = "inputLabel text_gray_small">Parser:</span>
                <span class = "tknParser text_gray_medium"></span>
            </div>
        </div>
   </div>
   
   <div style = "clear: both"></div>
</div>


<div id = "tplToken3rdParty" class = "tknView3rdParty main_auto_scroll" style = "display: none;">
    <div>
        <div class = "wizTitle">Token Aware Module</div>
        <div class = "bk_token">
            <span style = "display: none;" class = "nsId"></span>
            <div style = "margin-top: 6px;">
                <span class = "nsName tkn_name text_blue_big"></span>
            </div>
            <div style = "margin-top: 4px;">
                <span class = "nsDesc grayed_desc"></span>
            </div>
            
            <div class = "tknLoading text_blue_big" style = "margin: 30px;">
                Loading... Please wait...
            </div>
            
            <div class = "nsNoInfo tknNotLoaded" style = "margin-top: 16px; display: none; color :#E24343;">
                The developer of this module did not provide documentation on supported tokens. <br />
                Check module documentation or contact the vendor for more information.<br /><br />
            </div>
            
            <div style = "margin-top: 16px;" class = "nsInfo tknNotLoaded">
                <div>
                    <span class = "text_gray_medium"><b>Definition Cache time:</b> </span> <span class = "nsDefCache text_green"></span>
                    <div class = "grayed_desc">Tells how often MyTokens will query the module for supported tokens and their specification. When cache time is 0, it usually indicates that the specification is dynamic (for example it depends on security of current user or on time events).</div>
                </div>
                <div style = "margin-top: 6px;">
                    <span class = "text_gray_medium"><b>Handles Only Documented Tokens:</b> </span> <span class = "nsOnlyDocTokens text_green"></span>
                    <div class = "grayed_desc">Indicates whether the module handles only tokens documented in this page. If values is <b>no</b>, contact vendor to learn more about the undocumented tokens.</div>
                </div>
                <div style = "margin-top: 6px;" class = "nsDocUrlC">
                    <span class = "text_gray_medium"><b>Documentation Url:</b> </span> <a href = "" class = "nsDocUrl text_green"></a>
                    <div class = "grayed_desc">Visit website to learn more about supported tokens.</div>
                </div>
                <br />
            </div>
        </div>
    </div>
    
    <br /><br />
    
   
    <div class = "tknsContainer tknNotLoaded">
        <div class = "wizTitle">Tokens</div>
        <div style = "margin-top: 16px; display: none; color :#E24343;" class = "noTokens">
            There are no tokens documented for this module. Please read module documentation or contact vendor for more information on supported tokens.
        </div>
        <div class = "tknList"></div>
        <br/>
    </div>
    
</div>

<div id = "tpl3rdPartyTokenSummary" class = "tokenSummaryRoot bk_token" style = "display: none; margin: 6px;">

    <div class = "inputLabel">
        <div class = "tknName text_blue_strong" style = "padding: 0px;"></div>
    </div>

    <div class = "grayed_desc">
        <span class = "tknDesc"></span>
        <div class = "tknDocUrlC">Read more about this token at <a href = "" class = "tknDocUrl"></a></div>
    </div>
    
    <div style = "margin-top: 10px;" class = "">
        <span class = "inputLabel text_gray_medium"><b>Default Cache Time:</b></span>
        <span class = "tknCacheTime text_gray_medium"></span>
        <div class = "grayed_desc">
            Determines how long MyTokens will cache this token before refreshing it from the 3rd party module. 
            If is <b>0</b>, MyTokens never caches the token (still, the module could do some caching).
            Note that the caching time can be modified programatically by developers, reflecting actual state.
        </div>
    </div>
    
    <div style = "margin-top: 10px;" class = "">
        <span class = "inputLabel text_gray_medium"><b>Parameters:</b></span>
        
        <table class = "tknParamsC text_gray_medium" cellpadding = "0" cellspacing = "3" border = "0" style = "margin-left: 20px; margin-top: 10px;">
        </table>
    </div>
    
    <div style = "margin-top: 10px;" class = "">
        <span class = "inputLabel text_gray_medium"><b>Syntax:</b></span>
        <div class = "tknSyntax text_gray_medium" style = "margin-left: 30px; margin-top: 10px;"></div>
        <div class = "grayed_desc" style = "margin-top: 8px;">
            Folow syntax above when invoking this token. If token accepts paramters, they appear between parenthesis in form <b>paramName1=numbervalue,paramName2="stringValue",...</b>. 
            For example, invoke a token like this [ModuleName:TokenName(ModuleId=200,action=DoIt,placehold="No results")]
            <br /><br />
            To test the token, click <b>Test Token</b> button below and replace parameters (if any) with actual values.
        </div>
    </div>
    
    <div style = "margin-top: 10px;" class = "tknExamplesC">
        <span class = "inputLabel text_gray_medium"><b>Examples:</b></span>
        <div class = "grayed_desc">
            Below are examples provided by the developer.
        </div>
        
        <div class = "tknExampleList text_gray_medium" style = "margin-left: 20px; margin-top: 4px;">
        </div>
    </div>
   
    <div style = "margin: 12px; text-align: right;" class = "">
        <a href = "javascript: ;" onclick = "avt.mt.tkn.testToken(jQuery(this).parents('.tokenSummaryRoot:first').find('.tknSyntax:first').text());" class = "blue globe_icon">Test Token</a>
    </div>

</div>


<div id = "tplGadgetInfo" style = "display: none; padding: 0px;">
    <div class = "tokenSummaryRoot bk_token main_auto_scroll" style = "margin: 6px;">

        <div class = "inputLabel" style = "margin: 10px 0;">
            <div class = "tknName text_blue_strong" style = "padding: 0px;"></div>
        </div>

        <div class = "grayed_desc">
            <span class = "tknDesc"></span>
            <div class = "tknDocUrlC">Read more about this gadget at <a href = "" class = "tknDocUrl"></a></div>
        </div>
    
        <div style = "margin-top: 20px;" class = "tknParamsCC">
            <span class = "inputLabel text_gray_medium"><b>Parameters:</b></span>
        
            <table class = "tknParamsC text_gray_medium" cellpadding = "0" cellspacing = "3" border = "0" style = "margin-left: 20px; margin-top: 10px;">
            </table>
        </div>
    
        <div style = "margin-top: 10px;" class = "">
            <span class = "inputLabel text_gray_medium"><b>Syntax:</b></span>
            <div class = "tknSyntax text_gray_medium" style = "margin-left: 30px; margin-top: 10px; color: #5C808A;"></div>
            <div class = "grayed_desc" style = "margin-left: 30px;">
                To test the token, click <b>Test Token</b> button below and replace parameters (if any) with actual values.
            </div>
        </div>
    
        <div style = "margin-top: 10px;" class = "tknExamplesC">
            <span class = "inputLabel text_gray_medium"><b>Examples:</b></span>
            <div class = "tknExampleList text_gray_medium" style = "margin-left: 30px;">
            </div>
        </div>
   
        <div style = "margin: 12px; text-align: right;" class = "">
            <a href = "javascript: ;" onclick = "avt.mt.tkn.testToken(jQuery(this).parents('.tokenSummaryRoot:first').find('.tknSyntax:first').text());" class = "blue globe_icon">Test Token</a>
        </div>

    </div>
</div>

<table style = "display: none;">
    <tr id = "tplTknParam" class = "tokenParamRoot">
        <td style = "text-align: right; padding: 0px;" valign = "middle">
            <span class = "paramRequired text_gray_small" style = "color: #E24343;">[required]</span>
            <span class = "paramOptional text_gray_small" style = "color: #3A924A;">[optional]</span>
        </td>
        <td style = "padding: 0 0 0 6px;" valign = "middle">
            <span class = "paramType text_gray_small" style = "color: #4343E2; font-weight: bold;"></span>
        </td>
        <td style = "padding: 0 0 0 6px;" valign = "middle">
            <span class = "paramName text_gray_medium" style = "font-weight: bold;"></span>
        </td>
        <td style = "padding: 0 0 0 6px;" valign = "middle">
            <span class = "paramDesc grayed_desc" style = "font-style: normal;"></span>
            <div class = "paramDefaultValC text_gray_small">
                <b>Default Value:</b> <span class = "paramDefaultVal" style = ""> </span>
            </div>
            <div class = "paramPossibleValsC text_gray_small">
                <b>Possible Values:</b> <span class = "paramPossibleVals" style = ""></span>
            </div>
            <br />
        </td>
    </tr>
</table>


<div id = "tplTknExample" class = "tokenExampleRoot">
    <div class = "exCode text_gray_medium" style = "font-weight: bold; margin-top: 10px; color: #5C808A;"></div>
    <span class = "exDesc text_gray_medium" style = ""></span>
    <a href = "" class = "exTest" style = "font-size: x-small">(Test)</a>
</div>


