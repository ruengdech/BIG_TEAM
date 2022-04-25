<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index_csi.aspx.vb" Inherits="sys01_dashboard_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>ระบบงานติดตั้ง (Dashboard)</title>
	<link rel="stylesheet" href="../themes/ST_MED.css" />
	<link rel="stylesheet" href="../themes/jquery.mobile.icons.min.css" />
    <link href="../themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../themes/jquery-1.11.1.min.js"></script>
    <script src="../themes/jquery.mobile-1.4.5.min.js"></script>
    <style type="text/css">
        .mydatagrid
        {
	        width: 80%;
	        border: solid 2px black;
	        min-width: 80%;
        }
        .header
        {
	        background-color: #000;
	        font-family: Arial;
	        color: White;
	        height: 25px;
	        text-align: center;
	        font-size: 16px;
        }

        .rows
        {
	        background-color: #fff;
	        font-family: Arial;
	        font-size: 14px;
	        color: #000;
	        min-height: 25px;
	        text-align: left;
        }
        .rows:hover
        {
	        background-color: #5badff;
	        color: #fff;
        }

        .mydatagrid a /** FOR THE PAGING ICONS  **/
        {
	        background-color: Transparent;
	        padding: 5px 5px 5px 5px;
	        color: #4c4c4c;
	        text-decoration: none;
	        font-weight: bold;
        }

        .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/
        {
	        background-color: #000;
	        color: #fff;
        }
        .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/
        {
	        background-color: #fff;
	        color: #000;
	        padding: 5px 5px 5px 5px;
        }
        .pager
        {
	        background-color: #5badff;
	        font-family: Arial;
	        color: White;
	        height: 30px;
	        text-align: left;
        }

        .mydatagrid td
        {
	        padding: 5px;
        }
        .mydatagrid th
        {
	        padding: 5px;
        }
        .auto-style1 {
            height: 30px;
        }
    </style>

    <style>
        table {
          border-collapse: collapse;
        }

        table, th, td {
          border: 1px solid black;
          vertical-align: bottom;
        }
        th, td {
          padding: 15px;
          text-align: center;
          vertical-align: top;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        #gv_all th {
            background-color: #b88821;
            color: white;
        }
                
        #gv_am th {
            background-color: #4c95af;
            color: white;
        }
        #gv_bm th {
            background-color: #21b8a9;
            color: white;
        }
        #gv_head th {
            background-color: #8f2b9e;
            color: white;
        }
        
        tr:nth-child(even){background-color: #f2f2f2;}

        tr:hover {background-color: #ddd;}
    </style>
</head>
<body>
    <div data-role="page" data-theme="a">
		<div data-role="header" data-position="inline">
            
            <h1><img src="../../img/SM_LOGO.gif" width="300px" /></h1>
			<h1>Saintmed: ระบบงานติดตั้ง (Dashboard) </h1>
		</div>
		<div data-role="content" data-theme="a">   
    <form id="form1" runat="server">
        
        <table style="width: 100%;">
            <tr>
                <th>Dashboard for ST.Med จำนวนงานที่ Complete</th>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gv_all" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager"  RowStyle-CssClass="rows" PageSize="15" HorizontalAlign="Center" Width="100%"  data-mode="reflow" class="ui-responsive" AutoGenerateColumns="False" DataSourceID="DATASOURCE01">
                        <Columns>
                            <asp:BoundField DataField="YY" HeaderText="Year" ReadOnly="True" SortExpression="YY" />
                            <asp:BoundField DataField="_TOTAL" HeaderText="# Complete Job" ReadOnly="True" SortExpression="_TOTAL" />
                            <asp:BoundField DataField="_CSI" HeaderText="# CSI" ReadOnly="True" SortExpression="_CSI" />
                        </Columns>
<HeaderStyle CssClass="header" BackColor="blue"></HeaderStyle>

                        <PagerStyle CssClass="myPagerClass" />

<RowStyle CssClass="rows"></RowStyle>
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE01" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT        YEAR(req_installdate) AS YY, COUNT(DISTINCT uid) AS _TOTAL, COUNT(DISTINCT CSI_ID) AS _CSI
FROM            SYS01_VIEW_CSI04_STATUS
GROUP BY YEAR(req_installdate)
ORDER BY YY"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">&nbsp;เลือกปีที่ต้องการ:&nbsp;
                    <asp:DropDownList ID="ddl_year" runat="server" AutoPostBack="True" data-native-menu="false">
                        <asp:ListItem Selected="True">2021</asp:ListItem>
                        <asp:ListItem>2022</asp:ListItem>
                        <asp:ListItem>2023</asp:ListItem>
                        <asp:ListItem>2024</asp:ListItem>
                        <asp:ListItem>2025</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            
            <tr>
                <th>จำนวนงานที่ Complete และมีการประเมิน รายเดือน</th>
            </tr>
            <tr>
                <td >
                    <asp:GridView ID="GV_STATUS" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE_STATUS" >
                        <Columns>
                            <asp:BoundField DataField="YY" HeaderText="Year" SortExpression="YY" ReadOnly="True" />
                            <asp:BoundField DataField="MM" HeaderText="Month" ReadOnly="True" SortExpression="MM" />
                            <asp:BoundField DataField="_TOTAL" HeaderText="# Total Complete Job" ReadOnly="True" SortExpression="_TOTAL" />
                            <asp:BoundField DataField="_CSI" HeaderText="# CSI " ReadOnly="True" SortExpression="_CSI" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE_STATUS" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT YEAR(req_installdate) AS YY, MONTH(req_installdate) AS MM, COUNT(DISTINCT uid) AS _TOTAL, COUNT(DISTINCT CSI_ID) AS _CSI FROM SYS01_VIEW_CSI04_STATUS GROUP BY YEAR(req_installdate), MONTH(req_installdate) HAVING (YEAR(req_installdate) = @year) ORDER BY YY, MM">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="year" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td >
            </tr>
            
            <tr>
                <th>สรุปงานที่มีการประเมิน</th>
            </tr>
            <tr>
                <td >
                    <asp:GridView ID="GV_JOBDATE" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE_JOBDATE" DataKeyNames="uid" >
                        <Columns>
                            <asp:BoundField DataField="INSTALL_DATE" HeaderText="วันที่ติดตั้ง" SortExpression="INSTALL_DATE" ReadOnly="True" />
                            <asp:BoundField DataField="uid" HeaderText="รหัสงาน" ReadOnly="True" SortExpression="uid" />
                            <asp:BoundField DataField="req_installlocation" HeaderText="สถานที่" SortExpression="req_installlocation" />
                            <asp:BoundField DataField="req_installdept" HeaderText="แผนก" SortExpression="req_installdept" />
                            <asp:BoundField DataField="CSI1" HeaderText="คะแนน CSI 1" SortExpression="CSI1" />
                            <asp:BoundField DataField="CSI2" HeaderText="คะแนน CSI 2" SortExpression="CSI2" />
                            <asp:BoundField DataField="CSI3" HeaderText="คะแนน CSI 3" SortExpression="CSI3" />
                            <asp:BoundField DataField="CSI4" HeaderText="คะแนน CSI 4" SortExpression="CSI4" />
                            <asp:BoundField DataField="CSI5" HeaderText="คะแนน CSI 5" SortExpression="CSI5" />
                            <asp:TemplateField HeaderText="คะแนนเฉลี่ยรวม" SortExpression="CSI_AVG">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CSI_AVG") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CSI_AVG") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:HyperLinkField NavigateUrl="https://saintmed.dyndns.biz/net/sys04/admin_s.aspx" Target="_blank" Text="LINK" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="DATASOURCE_JOBDATE" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT        FORMAT(req_installdate, 'dd/MM/yyyy ') AS INSTALL_DATE, uid, req_installlocation, req_installdept, CSI1, CSI2, CSI3, CSI4, CSI5, CSI_AVG, YEAR(req_installdate) AS YY, CSI_ID
FROM            SYS01_VIEW_CSI04_STATUS
GROUP BY req_installlocation, req_installdept, CSI1, CSI2, CSI3, CSI4, CSI5, CSI_AVG, uid, FORMAT(req_installdate, 'dd/MM/yyyy '), YEAR(req_installdate), CSI_ID
HAVING        (NOT (CSI1 IS NULL)) AND (YEAR(req_installdate) = @YEAR)
ORDER BY FORMAT(req_installdate, 'dd/MM/yyyy ')">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" Name="YEAR" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </td >
            </tr>            
            <tr>
                <td >
                    <asp:Label ID="lb_error" runat="server"></asp:Label>
                </td>

            </tr>
        </table>
        <asp:Panel ID="pan_dashboard" runat="server" Width="100%">
           
        </asp:Panel>
    </form>
        </div>
    </div>
</body>
</html>
