<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ScheduleList.ascx.cs" Inherits="Evotiva.DNN.Modules.DNNBackup.ScheduleList" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="evotiva" Namespace="Evotiva.DNN.Modules.DNNBackup" Assembly="Evotiva.DNN.Modules.DNNBackup" %>

<br />
<asp:Label ID="lblLoadError" runat="server" Visible="false" CssClass="bkp-error" />
<dnn:SectionHead ID="dshPortalFilesSchedule" runat="server" CssClass="bkp-head" IsExpanded="True"
                 Section="tblFilesSchedule" Text="Files backup" IncludeRule="true">
</dnn:SectionHead>
<table id="tblFilesSchedule" style="border-spacing: 10px;" summary="Backup Schedules Design Table" runat="server">

    <tr class="bkp-formrow">
        <td style="text-align: left;">
            <asp:label runat="server" ID="lblSchedulesList" ResourceKey="lblSchedulesList"   Visible="False"></asp:label>
            <asp:Image ID="imgAdd" TabIndex="-1" runat="server" ImageUrl="~/images/add.gif"
                       EnableViewState="False" BorderStyle="None"></asp:Image>
            <asp:LinkButton ID="cmdAddSchedule" ResourceKey="cmdAddSchedule" runat="server" 
                            Text="Add" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td>
            <asp:label runat="server" ID="lblNoSchedules" ResourceKey="lblNoSchedules" visible="False"></asp:label>            
            <asp:DataGrid ID="grdSchedule" runat="server"   
                          CellPadding="2" CellSpacing="2" Width="100%"
                          DataKeyField="ScheduleID" enableviewstate="true" 
                          BorderStyle="None" BorderWidth="0px" GridLines="None"
                          AutoGenerateColumns="false">   <%--onitemcommand="grdSchedule_ItemCommand" --%>
                <HeaderStyle CssClass="bkp-head-small" />
                <ItemStyle  HorizontalAlign="Left" />
                <Columns>                            
                    <evotiva:imagecommandcolumn text="Edit" commandname="Edit" EditMode="Command" keyfield="ScheduleID" imageurl="~/images/edit.gif" />
                    <evotiva:imagecommandcolumn text="Copy" commandname="Copy" EditMode="Command" keyfield="ScheduleID" imageurl="~/images/copy.gif" />
                    <evotiva:imagecommandcolumn text="Delete" commandname="Delete" EditMode="Command" keyfield="ScheduleID" imageurl="~/images/delete.gif" />                    
                    <evotiva:imagecommandcolumn text="History" commandname="History" EditMode="Command" keyfield="ScheduleID" imageurl="~/images/icon_profile_16px.gif" />
                    <evotiva:imagecommandcolumn text="Run Now" commandname="Run" EditMode="Command" keyfield="ScheduleID" imageurl="~/images/icon_scheduler_16px.gif" />

                    <asp:TemplateColumn HeaderText="Enabled">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgScheduleEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#Convert.ToBoolean(DataBinder.Eval(Container.DataItem,"Enabled")) %>' 
                                       AlternateText="Enabled" ResourceKey="Enabled.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:BoundColumn DataField="Description" HeaderText="Description" />                                    

                    <asp:TemplateColumn HeaderText="Data">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgDataEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.
                                      Eval
                                      (Container
                                           .
                                           DataItem,
                                       "BkpDatabase")) %>' 
                                       AlternateText="Database" ResourceKey="Data.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn>     

                    <asp:TemplateColumn HeaderText="Files">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgFilesEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "BkpFiles")) %>' 
                                       AlternateText="Files" ResourceKey="Files.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn>                                                            

                    <asp:TemplateColumn HeaderText="TrnFTP">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgFTPEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TrnFTP")) %>' 
                                       AlternateText="FTP" ResourceKey="TrnFTP.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn> 

                    <asp:TemplateColumn HeaderText="TrnAmazonS3">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgS3Enabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TrnAmazonS3")) %>' 
                                       AlternateText="Amazon S3" ResourceKey="TrnAmazonS3.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn> 

                    <asp:TemplateColumn HeaderText="TrnAzure">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgAzureEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TrnAzure")) %>' 
                                       AlternateText="Windows Azure" ResourceKey="TrnAzure.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn HeaderText="TrnCloudFiles">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgCFEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TrnCloudFiles")) %>' 
                                       AlternateText="CloudFiles" ResourceKey="TrnCloudFiles.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn> 

                    <asp:TemplateColumn HeaderText="TrnDropbox">
                        <ItemStyle  HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image id="imgDropboxEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                       Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TrnDropbox")) %>' 
                                       AlternateText="Dropbox" ResourceKey="TrnDropbox.Header" />
                        </ItemTemplate>
                    </asp:TemplateColumn> 

                    <asp:TemplateColumn HeaderText="Frequency">
                        <ItemTemplate>
                            <%#                GetTimeLapse((int) DataBinder.Eval(Container.DataItem, "TimeLapse"),
                             (string) DataBinder.Eval(Container.DataItem, "TimeLapseMeasurement")) %>            
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn HeaderText="DayOfWeek">
                        <ItemTemplate>
                            <%#  GetDayOfWeek((string)DataBinder.Eval(Container.DataItem, "DayOfWeek"))%>            
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn HeaderText="LastRun">
                        <ItemTemplate>
                            <%#                GetDateTime((DateTime?) DataBinder.Eval(Container.DataItem, "LastRun")) %>            
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn HeaderText="NextRun">
                        <ItemTemplate>
                            <%#                GetDateTime((DateTime?) DataBinder.Eval(Container.DataItem, "NextRun"),
                            (bool) DataBinder.Eval(Container.DataItem, "Enabled")) %>            
                        </ItemTemplate>
                    </asp:TemplateColumn>

                </Columns>
            </asp:DataGrid>                    
        </td>
    </tr>


    <%--
	<tr class="bkp-formrow">
		<td>
			<br />
			<center>
				<asp:Image ID="imgReturn2" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
					EnableViewState="False" BorderStyle="None"></asp:Image>
				<asp:LinkButton ID="cmdReturn2" ResourceKey="cmdReturn" runat="server" 
					Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton>                               
			 </center>                    
		</td>
	</tr>
	--%>

</table>

<asp:panel runat="server" id="pnlScheduleHistory" Visible="False">
    <br />
    <dnn:SectionHead ID="dshSchedulerHistory" runat="server" CssClass="bkp-head" IsExpanded="True"
                     Section="tblSchedulerHistory" Text="Scheduler History"  IncludeRule="true"/>
     
    <table id="tblSchedulerHistory" style="border-spacing: 10px;" summary="Scheduler History Design Table"
           border="0" runat="server">   
        <tr class="bkp-formrow">
            <td>
                <asp:label runat="server" ID="lblNoScheduleHistory" ResourceKey="lblNoScheduleHistory" visible="False"/>            
                <asp:LinkButton ID="lnkPurgeHistory" runat="server" ResourceKey="lnkPurgeHistory" visible="False" />
                <asp:DataGrid ID="grdScheduleHistory" runat="server" AutoGenerateColumns="false" 
                              CellPadding="4" CellSpacing="2" DataKeyField="ScheduleID" border="1" 
                              EnableViewState="false"  summary="This table shows the schedule history." 
                              BorderColor="gray" BorderStyle="Solid" BorderWidth="1px" GridLines="Both">
                    <HeaderStyle CssClass="bkp-bold" />
                    <ItemStyle  VerticalAlign="Top" />
                    <Columns>                                                
                        <asp:TemplateColumn HeaderText="Succeeded">
                            <ItemStyle  HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Image id="imgScheduleEnabled" ImageUrl="~/images/checked.gif" runat="server"  
                                           Visible='<%#                Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Succeeded")) %>' 
                                           AlternateText="Succeeded" ResourceKey="Succeeded.Header" />
                            </ItemTemplate>
                        </asp:TemplateColumn>                                            
                        <asp:BoundColumn DataField="StartDate" HeaderText="StartDate" />
                        <asp:BoundColumn DataField="EndDate" HeaderText="EndDate" />
                        <asp:BoundColumn DataField="LogNotes" HeaderText="LogNotes" />                      
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr> 
    </table>
</asp:panel>