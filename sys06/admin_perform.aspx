<%@ Page Language="VB" AutoEventWireup="false" CodeFile="admin_perform.aspx.vb" Inherits="sys06_admin_perform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body><center>
    <form id="form1" runat="server">
        <div>
                <b><span lang="TH" style="font-size:14.0pt;mso-ansi-font-size:10.0pt;line-height:115%;
font-family:&quot;TH Sarabun New&quot;,sans-serif;mso-ascii-font-family:Calibri;
mso-hansi-font-family:Calibri">แผนดำเนินงานบรรลุ<span style="mso-spacerun:yes">&nbsp; </span></span><span style="font-size:10.0pt;
mso-bidi-font-size:14.0pt;line-height:115%;mso-ascii-font-family:Calibri;
mso-hansi-font-family:Calibri;mso-bidi-font-family:&quot;TH Sarabun New&quot;">KPI (Action Plan)</span></b><span style="font-size:10.0pt;mso-bidi-font-size:14.0pt;
line-height:115%;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:&quot;TH Sarabun New&quot;"><span style="font-size:10.0pt;mso-bidi-font-size:14.0pt;
line-height:115%;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:&quot;TH Sarabun New&quot;"> :
            <asp:DropDownList ID="ddl_year" runat="server" AutoPostBack="True">
                <asp:ListItem>2021</asp:ListItem>
                <asp:ListItem>2022</asp:ListItem>
                <asp:ListItem>2023</asp:ListItem>
                <asp:ListItem>2024</asp:ListItem>
            </asp:DropDownList>
                </span>&nbsp;<asp:SqlDataSource ID="DS_STAFF" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT STAFF_ID, STAFF_NAME + '  ' + STAFF_LNAME AS STAFF_NAME FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%ENGINEER%') AND (NOT (STAFF_TYPE LIKE '%BOARD%')) AND (NOT (STAFF_TYPE LIKE '%MANAGER%')) ORDER BY STAFF_NAME"></asp:SqlDataSource>
            <br />
                <b><span lang="TH" style="font-size:14.0pt;mso-ansi-font-size:10.0pt;line-height:115%;
font-family:&quot;TH Sarabun New&quot;,sans-serif;mso-ascii-font-family:Calibri;
mso-hansi-font-family:Calibri">หน่วยงาน </span></b><span style="font-size:10.0pt;
mso-bidi-font-size:14.0pt;line-height:115%;mso-ascii-font-family:Calibri;
mso-hansi-font-family:Calibri;mso-bidi-font-family:&quot;TH Sarabun New&quot;">: </span><span lang="TH" style="font-size:14.0pt;mso-ansi-font-size:10.0pt;line-height:115%;
font-family:&quot;TH Sarabun New&quot;,sans-serif;mso-ascii-font-family:Calibri;
mso-hansi-font-family:Calibri">แผนกติดตั้ง <span style="mso-spacerun:yes">&nbsp;&nbsp;</span><b>บริษัท<span style="mso-spacerun:yes">&nbsp; </span>เซนต์เมด<span style="mso-spacerun:yes">&nbsp; </span>จำกัด<br />
            <span lang="TH" style="font-size:10.0pt;mso-bidi-font-size:14.0pt;line-height:115%;
mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:
&quot;TH Sarabun New&quot;"> ระบุพนักงานที่ต้องการ&nbsp;
                </span></b></span>
                </span><span style="font-size:10.0pt;mso-bidi-font-size:14.0pt;
line-height:115%;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:&quot;TH Sarabun New&quot;"> 
            <asp:DropDownList ID="ddl_staff" runat="server" AutoPostBack="True" DataSourceID="DS_STAFF" DataTextField="STAFF_NAME" DataValueField="STAFF_ID" Height="39px">
            </asp:DropDownList>
&nbsp;<b><span lang="TH" style="font-size:10.0pt;mso-bidi-font-size:14.0pt;line-height:115%;
mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:
&quot;TH Sarabun New&quot;"><asp:Button ID="bt_reload" runat="server" Text="Reload" />
                </span></b>
                </span>
        </div>
        <asp:GridView ID="gv_staff_all" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="uid" DataSourceID="DS_ALL_PERFORM" ForeColor="#333333" GridLines="None" Width="100%">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="uid" HeaderText="uid" InsertVisible="False" ReadOnly="True" SortExpression="uid" />
                <asp:BoundField DataField="STAFF ID" HeaderText="STAFF ID" ReadOnly="True" SortExpression="STAFF ID" />
                <asp:BoundField DataField="STAFF NAME" HeaderText="STAFF NAME" ReadOnly="True" SortExpression="STAFF NAME" />
                <asp:BoundField DataField="no" HeaderText="no" ReadOnly="True" SortExpression="no" />
                <asp:BoundField DataField="KPI" HeaderText="KPI" ReadOnly="True" SortExpression="KPI" />
                <asp:BoundField DataField="TARGET" HeaderText="TARGET" ReadOnly="True" SortExpression="TARGET" />
                <asp:BoundField DataField="jan" HeaderText="jan" SortExpression="jan" />
                <asp:BoundField DataField="feb" HeaderText="feb" SortExpression="feb" />
                <asp:BoundField DataField="mar" HeaderText="mar" SortExpression="mar" />
                <asp:BoundField DataField="apr" HeaderText="apr" SortExpression="apr" />
                <asp:BoundField DataField="may" HeaderText="may" SortExpression="may" />
                <asp:BoundField DataField="jun" HeaderText="jun" SortExpression="jun" />
                <asp:BoundField DataField="jul" HeaderText="jul" SortExpression="jul" />
                <asp:BoundField DataField="aug" HeaderText="aug" SortExpression="aug" />
                <asp:BoundField DataField="sep" HeaderText="sep" SortExpression="sep" />
                <asp:BoundField DataField="oct" HeaderText="oct" SortExpression="oct" />
                <asp:BoundField DataField="nov" HeaderText="nov" SortExpression="nov" />
                <asp:BoundField DataField="dec" HeaderText="dec" SortExpression="dec" />
                <asp:BoundField DataField="avg" HeaderText="avg" SortExpression="avg" />
                <asp:BoundField DataField="remark" HeaderText="remark" SortExpression="remark" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="DS_ALL_PERFORM" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT SYS06_TS_STAFF_PERFORM.uid, SYS01_MS_STAFF.STAFF_ID AS [STAFF ID], SYS01_MS_STAFF.STAFF_NAME + ' ' + SYS01_MS_STAFF.STAFF_LNAME AS [STAFF NAME], SYS06_MS_PERFORMANCE.no, SYS06_MS_PERFORMANCE.objective AS KPI, SYS06_TS_STAFF_PERFORM.kpi AS TARGET, SYS06_TS_STAFF_PERFORM.jan, SYS06_TS_STAFF_PERFORM.feb, SYS06_TS_STAFF_PERFORM.mar, SYS06_TS_STAFF_PERFORM.apr, SYS06_TS_STAFF_PERFORM.may, SYS06_TS_STAFF_PERFORM.jun, SYS06_TS_STAFF_PERFORM.jul, SYS06_TS_STAFF_PERFORM.aug, SYS06_TS_STAFF_PERFORM.sep, SYS06_TS_STAFF_PERFORM.oct, SYS06_TS_STAFF_PERFORM.nov, SYS06_TS_STAFF_PERFORM.dec, SYS06_TS_STAFF_PERFORM.avg, SYS06_TS_STAFF_PERFORM.remark FROM SYS06_TS_STAFF_PERFORM INNER JOIN SYS06_MS_PERFORMANCE ON SYS06_TS_STAFF_PERFORM.kpi_uid = SYS06_MS_PERFORMANCE.uid INNER JOIN SYS01_MS_STAFF ON SYS06_TS_STAFF_PERFORM.staff_id = SYS01_MS_STAFF.STAFF_ID WHERE (SYS06_MS_PERFORMANCE.dept_id = 2) AND (SYS06_TS_STAFF_PERFORM.year = @sel_year) AND (SYS06_MS_PERFORMANCE.status = 'ACTIVE') ORDER BY [STAFF ID], SYS06_MS_PERFORMANCE.no" UpdateCommand="UPDATE [SYS06_TS_STAFF_PERFORM] SET  [jan] = @jan, [feb] = @feb, [mar] = @mar, [apr] = @apr, [may] = @may, [jun] = @jun, [jul] = @jul, [aug] = @aug, [sep] = @sep, [oct] = @oct, [nov] = @nov, [dec] = @dec, [avg] = @avg,  [mwhen] = GETDATE(), [remark] = @remark WHERE [uid] = @uid">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddl_year" Name="sel_year" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="jan" />
                <asp:Parameter Name="feb" />
                <asp:Parameter Name="mar" />
                <asp:Parameter Name="apr" />
                <asp:Parameter Name="may" />
                <asp:Parameter Name="jun" />
                <asp:Parameter Name="jul" />
                <asp:Parameter Name="aug" />
                <asp:Parameter Name="sep" />
                <asp:Parameter Name="oct" />
                <asp:Parameter Name="nov" />
                <asp:Parameter Name="dec" />
                <asp:Parameter Name="avg" />
                <asp:Parameter Name="remark" />
                <asp:Parameter Name="uid" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gv_staff_filter" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="uid" DataSourceID="DS_FILTER_STAFF" ForeColor="#333333" GridLines="None" Width="100%" Visible="False">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="uid" HeaderText="uid" InsertVisible="False" ReadOnly="True" SortExpression="uid" />
                <asp:BoundField DataField="STAFF ID" HeaderText="STAFF ID" ReadOnly="True" SortExpression="STAFF ID" />
                <asp:BoundField DataField="STAFF NAME" HeaderText="STAFF NAME" SortExpression="STAFF NAME" ReadOnly="True" />
                <asp:BoundField DataField="no" HeaderText="no" SortExpression="no" />
                <asp:BoundField DataField="KPI" HeaderText="KPI" SortExpression="KPI" />
                <asp:BoundField DataField="TARGET" HeaderText="TARGET" SortExpression="TARGET" />
                <asp:BoundField DataField="jan" HeaderText="jan" SortExpression="jan" />
                <asp:BoundField DataField="feb" HeaderText="feb" SortExpression="feb" />
                <asp:BoundField DataField="mar" HeaderText="mar" SortExpression="mar" />
                <asp:BoundField DataField="apr" HeaderText="apr" SortExpression="apr" />
                <asp:BoundField DataField="may" HeaderText="may" SortExpression="may" />
                <asp:BoundField DataField="jun" HeaderText="jun" SortExpression="jun" />
                <asp:BoundField DataField="jul" HeaderText="jul" SortExpression="jul" />
                <asp:BoundField DataField="aug" HeaderText="aug" SortExpression="aug" />
                <asp:BoundField DataField="sep" HeaderText="sep" SortExpression="sep" />
                <asp:BoundField DataField="oct" HeaderText="oct" SortExpression="oct" />
                <asp:BoundField DataField="nov" HeaderText="nov" SortExpression="nov" />
                <asp:BoundField DataField="dec" HeaderText="dec" SortExpression="dec" />
                <asp:BoundField DataField="avg" HeaderText="avg" SortExpression="avg" />
                <asp:BoundField DataField="remark" HeaderText="remark" SortExpression="remark" />
                <asp:CommandField ShowEditButton="True" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="DS_FILTER_STAFF" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT SYS06_TS_STAFF_PERFORM.uid, SYS01_MS_STAFF.STAFF_ID AS [STAFF ID], SYS01_MS_STAFF.STAFF_NAME + ' ' + SYS01_MS_STAFF.STAFF_LNAME AS [STAFF NAME], SYS06_MS_PERFORMANCE.no, SYS06_MS_PERFORMANCE.objective AS KPI, SYS06_TS_STAFF_PERFORM.kpi AS TARGET, SYS06_TS_STAFF_PERFORM.jan, SYS06_TS_STAFF_PERFORM.feb, SYS06_TS_STAFF_PERFORM.mar, SYS06_TS_STAFF_PERFORM.apr, SYS06_TS_STAFF_PERFORM.may, SYS06_TS_STAFF_PERFORM.jun, SYS06_TS_STAFF_PERFORM.jul, SYS06_TS_STAFF_PERFORM.aug, SYS06_TS_STAFF_PERFORM.sep, SYS06_TS_STAFF_PERFORM.oct, SYS06_TS_STAFF_PERFORM.nov, SYS06_TS_STAFF_PERFORM.dec, SYS06_TS_STAFF_PERFORM.avg, SYS06_TS_STAFF_PERFORM.remark FROM SYS06_TS_STAFF_PERFORM INNER JOIN SYS06_MS_PERFORMANCE ON SYS06_TS_STAFF_PERFORM.kpi_uid = SYS06_MS_PERFORMANCE.uid INNER JOIN SYS01_MS_STAFF ON SYS06_TS_STAFF_PERFORM.staff_id = SYS01_MS_STAFF.STAFF_ID WHERE (SYS06_MS_PERFORMANCE.dept_id = 2) AND (SYS06_TS_STAFF_PERFORM.year = @sel_year) AND (SYS01_MS_STAFF.STAFF_ID = @sel_staff) AND (SYS06_MS_PERFORMANCE.status = 'ACTIVE') ORDER BY [STAFF ID], SYS06_MS_PERFORMANCE.no"  UpdateCommand="UPDATE [SYS06_TS_STAFF_PERFORM] SET  [jan] = @jan, [feb] = @feb, [mar] = @mar, [apr] = @apr, [may] = @may, [jun] = @jun, [jul] = @jul, [aug] = @aug, [sep] = @sep, [oct] = @oct, [nov] = @nov, [dec] = @dec, [avg] = @avg,  [mwhen] = GETDATE(), [remark] = @remark WHERE [uid] = @uid">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddl_year" Name="sel_year" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddl_staff" Name="sel_staff" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="jan" />
                <asp:Parameter Name="feb" />
                <asp:Parameter Name="mar" />
                <asp:Parameter Name="apr" />
                <asp:Parameter Name="may" />
                <asp:Parameter Name="jun" />
                <asp:Parameter Name="jul" />
                <asp:Parameter Name="aug" />
                <asp:Parameter Name="sep" />
                <asp:Parameter Name="oct" />
                <asp:Parameter Name="nov" />
                <asp:Parameter Name="dec" />
                <asp:Parameter Name="avg" />
                <asp:Parameter Name="remark" />
                <asp:Parameter Name="uid" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
