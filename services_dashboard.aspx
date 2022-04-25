<%@ Page Language="VB" AutoEventWireup="false" CodeFile="services_dashboard.aspx.vb" Inherits="services_dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SAINTMED SERVICES DASHBOARD</title>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8" />
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
    
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="themes/RUENGDECH.min.css" />
	<link rel="stylesheet" href="themes/jquery.mobile.icons.min.css" />
	<link rel="stylesheet" href="css/jm.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

    </head>
<body>
    <div data-role="page" data-theme="a">
		<div data-role="header" data-position="inline">
            
            <h1><img src="img/SM_LOGO.gif" width="300px" /></h1>
			<h1>Saintmed: Intranet () </h1>
		</div>
		<div data-role="content" data-theme="a">   
    <form id="form1" runat="server">
        
        <table style="width: 100%;">
            <tr>
                <th colspan="2">Dashboard for ST.Med Services job.</th>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gv_all" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager"  RowStyle-CssClass="rows" AllowPaging="True" PageSize="15" HorizontalAlign="Center" Width="100%"  data-mode="reflow" class="ui-responsive">
<HeaderStyle CssClass="header" BackColor="blue"></HeaderStyle>

                        <PagerStyle CssClass="myPagerClass" />

<RowStyle CssClass="rows"></RowStyle>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="auto-style1">&nbsp;Year:&nbsp;
                    <asp:DropDownList ID="ddl_year" runat="server" AutoPostBack="True" data-native-menu="false">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>สรุปรายงานตามรายชื่อ AM</th>
                <th>สรุปรายงานตามรายชื่อ BM</th>
            </tr>
            <tr>
                <td width="50%">
                    <asp:GridView ID="gv_am" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" >
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="LINK_AM" DataTextField="AM" HeaderText="AM" Target="_blank" />
                            <asp:BoundField DataField="all" HeaderText="#ALL" />
                            <asp:BoundField DataField="closed" HeaderText="#Closed" />
                            <asp:BoundField DataField="pending" HeaderText="#Pending" />
                            <asp:BoundField DataField="Wait" HeaderText="#Wait PO" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                </td >
                <td>
                    <asp:GridView ID="gv_bm" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" >
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="LINK_BM" DataTextField="BM" HeaderText="BM" Target="_blank" />
                            <asp:BoundField DataField="all" HeaderText="#ALL" />
                            <asp:BoundField DataField="Closed" HeaderText="#Closed" />
                            <asp:BoundField DataField="Pending" HeaderText="#Pending" />
                            <asp:BoundField DataField="Wait" HeaderText="#Wait PO" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <th colspan="2">สรุปรายงานตามหัวหน้าช่าง</th>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gv_head" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" >
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="LINK_HEAD" DataTextField="HEAD_ENGINEER" HeaderText="Head Engineer" Target="_blank" />
                            <asp:BoundField DataField="all" HeaderText="#ALL" />
                            <asp:BoundField DataField="Closed" HeaderText="#Closed" />
                            <asp:BoundField DataField="Pending" HeaderText="#Pending" />
                            <asp:BoundField DataField="wait" HeaderText="#Wait PO" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
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
