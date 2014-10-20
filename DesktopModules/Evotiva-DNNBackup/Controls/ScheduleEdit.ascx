<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ScheduleEdit.ascx.cs" Inherits="Evotiva.DNN.Modules.DNNBackup.ScheduleEdit" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>

<dnn:SectionHead ID="dshPortalFilesScheduleEdit" runat="server" CssClass="bkp-head" IsExpanded="True"
                 ResourceKey="ScheduleEdit" Section="tblFilesScheduleEdit" Text="Files backup" IncludeRule="True">
</dnn:SectionHead>
<table id="tblFilesScheduleEdit" style="border-spacing: 10px;" summary="Backup Schedule Edit Design Table"
       border="0" runat="server">
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblSchedDesciption" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:TextBox ID="txtSchedDesciption" runat="server"  Columns="50"
                         MaxLength="200"></asp:TextBox>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblSchedEnabled" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkSchedEnabled"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label id="lblTimeLapse" runat="server" Suffix=":" controlname="txtTimeLapse" text="Time Lapse:"></dnn:Label>
        </td>
        <td>
            <asp:textbox id="txtTimeLapse" runat="server" maxlength="10" width="50" ></asp:textbox>
            <asp:dropdownlist id="ddlTimeLapseMeasurement" runat="server" AutoPostBack="True">
                <asp:listitem ResourceKey="Hours" value="h">Hours</asp:listitem>
                <asp:listitem ResourceKey="Days" value="d">Days</asp:listitem>
                <asp:listitem ResourceKey="Weeks" value="w">Weeks</asp:listitem>
            </asp:dropdownlist>
        </td>
    </tr>
    
        <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label id="lblDayOfWeek" runat="server" Suffix=":" controlname="ddlDayOfWeek" />
        </td>
        <td>
            <asp:dropdownlist id="ddlDayOfWeek" runat="server" AutoPostBack="False">
                <asp:listitem ResourceKey="DaySunday" value="Sunday">Sunday</asp:listitem>
                <asp:listitem ResourceKey="DayMonday" value="Monday">Monday</asp:listitem>
                <asp:listitem ResourceKey="DayTuesday" value="Tuesday">Tuesday</asp:listitem>
				<asp:listitem ResourceKey="DayWednesday" value="Wednesday">Wednesday</asp:listitem>
				<asp:listitem ResourceKey="DayThursday" value="Thursday">Thursday</asp:listitem>
				<asp:listitem ResourceKey="DayFriday" value="Friday">Friday</asp:listitem>
				<asp:listitem ResourceKey="DaySaturday" value="Saturday">Saturday</asp:listitem>
                <asp:listitem ResourceKey="DayAny" value="Any">Any</asp:listitem>
            </asp:dropdownlist>
        </td>
    </tr>
    
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label id="lblTimeToStart" runat="server" Suffix=":" controlname="ddlTimeToStart" text="Time to Start:"></dnn:Label>
        </td>
        <td>
            <asp:dropdownlist id="ddlTimeToStart" runat="server">
                <asp:listitem value="" ResourceKey="Any">Any</asp:listitem>				        
                <asp:listitem value="00:00">00:00</asp:listitem>
                <asp:listitem value="01:00">01:00</asp:listitem>
                <asp:listitem value="02:00">02:00</asp:listitem>
                <asp:listitem value="03:00">03:00</asp:listitem>
                <asp:listitem value="04:00">04:00</asp:listitem>
                <asp:listitem value="05:00">05:00</asp:listitem>
                <asp:listitem value="06:00">06:00</asp:listitem>
                <asp:listitem value="07:00">07:00</asp:listitem>
                <asp:listitem value="08:00">08:00</asp:listitem>
                <asp:listitem value="09:00">09:00</asp:listitem>
                <asp:listitem value="10:00">10:00</asp:listitem>
                <asp:listitem value="11:00">11:00</asp:listitem>
                <asp:listitem value="12:00">12:00</asp:listitem>
                <asp:listitem value="13:00">13:00</asp:listitem>
                <asp:listitem value="14:00">14:00</asp:listitem>
                <asp:listitem value="15:00">15:00</asp:listitem>
                <asp:listitem value="16:00">16:00</asp:listitem>
                <asp:listitem value="17:00">17:00</asp:listitem>
                <asp:listitem value="18:00">18:00</asp:listitem>
                <asp:listitem value="19:00">19:00</asp:listitem>
                <asp:listitem value="20:00">20:00</asp:listitem>
                <asp:listitem value="21:00">21:00</asp:listitem>
                <asp:listitem value="22:00">22:00</asp:listitem>
                <asp:listitem value="23:00">23:00</asp:listitem>
            </asp:dropdownlist>
        </td>
    </tr>
    
    <tr class="bkp-formrow" runat="server" id="rowLastRun">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblLastRun" runat="server" Suffix=":" />
        </td>
        <td>
            <asp:TextBox id="txtLastRunDate"  runat="server" width="120" Columns="20" Enabled="False"/>
        </td>
    </tr>

    <tr class="bkp-formrow" runat="server" id="rowNextRun">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblNextRun" runat="server" Suffix=":" />
        </td>
        <td>
            <asp:TextBox id="txtNextRunDate"  runat="server" width="120" Columns="20" />&nbsp;
            <asp:dropdownlist id="ddlNextRunTime" runat="server">
                <asp:listitem value="00:00">00:00</asp:listitem>
                <asp:listitem value="01:00">01:00</asp:listitem>
                <asp:listitem value="02:00">02:00</asp:listitem>
                <asp:listitem value="03:00">03:00</asp:listitem>
                <asp:listitem value="04:00">04:00</asp:listitem>
                <asp:listitem value="05:00">05:00</asp:listitem>
                <asp:listitem value="06:00">06:00</asp:listitem>
                <asp:listitem value="07:00">07:00</asp:listitem>
                <asp:listitem value="08:00">08:00</asp:listitem>
                <asp:listitem value="09:00">09:00</asp:listitem>
                <asp:listitem value="10:00">10:00</asp:listitem>
                <asp:listitem value="11:00">11:00</asp:listitem>
                <asp:listitem value="12:00">12:00</asp:listitem>
                <asp:listitem value="13:00">13:00</asp:listitem>
                <asp:listitem value="14:00">14:00</asp:listitem>
                <asp:listitem value="15:00">15:00</asp:listitem>
                <asp:listitem value="16:00">16:00</asp:listitem>
                <asp:listitem value="17:00">17:00</asp:listitem>
                <asp:listitem value="18:00">18:00</asp:listitem>
                <asp:listitem value="19:00">19:00</asp:listitem>
                <asp:listitem value="20:00">20:00</asp:listitem>
                <asp:listitem value="21:00">21:00</asp:listitem>
                <asp:listitem value="22:00">22:00</asp:listitem>
                <asp:listitem value="23:00">23:00</asp:listitem>
            </asp:dropdownlist>
            &nbsp;
            <asp:HyperLink id="cmdNextRunCalendar" Runat="server" ><asp:Image runat="server" ImageUrl="~/Images/Calendar.png"/></asp:HyperLink>
        </td>
    </tr>

    <tr  class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label id="lblRetainHistoryNum" runat="server" Suffix=":" controlname="ddlRetainHistoryNum" text="Retain Schedule History:"></dnn:Label>
        </td>
        <td>
            <asp:dropdownlist id="ddlRetainHistoryNum" runat="server">
                <asp:listitem value="0" ResourceKey="None">None</asp:listitem>
                <asp:listitem value="1">1</asp:listitem>
                <asp:listitem value="5">5</asp:listitem>
                <asp:listitem value="10">10</asp:listitem>
                <asp:listitem value="25">25</asp:listitem>
                <asp:listitem value="50">50</asp:listitem>
                <asp:listitem value="100">100</asp:listitem>
                <asp:listitem value="250">250</asp:listitem>
                <asp:listitem value="500">500</asp:listitem>
                <asp:listitem value="-1" ResourceKey="All">All</asp:listitem>
            </asp:dropdownlist>
        </td>
    </tr>

    <%--
	 <tr class="bkp-formrow">
		<td class="bkp-titlelabel">				 
			<dnn:Label id="lblTimeToStartTolerance" runat="server" Suffix=":" controlname="ddlTimeToStartTolerance" text="Tolerance:"></dnn:Label>
		</td>
		<td>
			<asp:dropdownlist id="ddlTimeToStartTolerance" runat="server">
				<asp:listitem value="0" ResourceKey="None">None</asp:listitem>
				<asp:listitem value="15" ResourceKey="15Minutes">15 Minutes</asp:listitem>
				<asp:listitem value="30" ResourceKey="30Minutes">30 Minutes</asp:listitem>
				<asp:listitem value="60" ResourceKey="1Hour">1 Hour</asp:listitem>
				<asp:listitem value="120" ResourceKey="2Hours">2 Hours</asp:listitem>
				<asp:listitem value="240" ResourceKey="4Hours">4 Hours</asp:listitem>
			</asp:dropdownlist>
		</td>
	</tr>
	--%>

    <tr class="bkp-formrow" runat="server" id="rowBkpDatabase" visible="false">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblBkpDatabase" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkBkpDatabase"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>
    <tr class="bkp-formrow" runat="server" id="rowBkpFiles" visible="false">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblBkpFiles" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkBkpFiles"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>		

    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblTrnFTP" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkTrnFTP"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblTrnAmazonS3" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkTrnAmazonS3"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblTrnAzure" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkTrnAzure"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblTrnCloudFiles" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkTrnCloudFiles"  runat="server" >
            </asp:CheckBox>
        </td>
    </tr>       
    <tr class="bkp-formrow">
        <td class="bkp-titlelabel">
            <dnn:Label ID="lblTrnDropbox" runat="server" Suffix=":" ></dnn:Label>
        </td>
        <td>
            <asp:CheckBox ID="chkTrnDropbox"  runat="server" />            
        </td>
    </tr>                   		
    <%--<tr class="bkp-formrow">
		<td class="bkp-titlelabel">				 
			<dnn:Label id="lblNextRun" runat="server" Suffix=":" controlname="txtNextRun" text="NextRun:"></dnn:Label>
		</td>
		<td>

		</td>
	</tr> --%>      

    <tr class="bkp-formrow" runat="server" ID="rowActions" Visible="False">
        <td colspan="2">
            <br />
            <div>
                <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                           EnableViewState="False" BorderStyle="None"></asp:Image>
                <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                &nbsp;
                <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
                           EnableViewState="False" BorderStyle="None"></asp:Image>
                <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton>
            </div>                    
        </td>
    </tr>	 						
</table>