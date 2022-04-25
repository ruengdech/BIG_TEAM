<%@ Page Language="VB" AutoEventWireup="false" CodeFile="services_listhead.aspx.vb" Inherits="services_listhead" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SAINTMED SERVICES DASHBOARD</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
                
        #gv_engineer th {
            background-color: #4c95af;
            color: white;
        }
        #gv_detail th {
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
    
    <form id="form1" runat="server">
        
        
        <asp:Panel ID="pan_dashboard" runat="server" Width="100%">
           <table style="width: 100%;">
            <tr>
                <th colspan="2">Dashboard for ST.Med Services job. by HEAD: 
                    <asp:Label ID="lb_am" runat="server" Text="Label"></asp:Label>
                </th>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gv_head" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" PageSize="2000" >
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>

                </td>
            </tr>
            <tr>
                <td colspan="2" class="auto-style1">&nbsp;Year:&nbsp;
                    <asp:Label ID="lb_year" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <th colspan="2">สรุปรายงานตามรายชื่อช่าง</th>
            </tr>
            <tr>
                <td colspan="2">
                    
                    <asp:GridView ID="gv_engineer" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" AutoGenerateColumns="False" PageSize="2000" >
                        <Columns>
                            <asp:BoundField DataField="ENGINEER" HeaderText="ENGINEER" />
                            <asp:BoundField DataField="ALL" HeaderText="#ALL" />
                            <asp:BoundField DataField="CLOSED" HeaderText="#CLOSED" />
                            <asp:BoundField DataField="PENDING" HeaderText="#PENDING" />
                            <asp:BoundField DataField="WAIT" HeaderText="#WAIT" />
                            <asp:HyperLinkField DataNavigateUrlFields="SALE_LINK_ALL" HeaderText="Detail (ALL)" Target="_self" Text="All JOB " />
                            <asp:HyperLinkField DataNavigateUrlFields="SALE_LINK_CLOSE" HeaderText="Detail (Closed)" Text="Closed" />
                            <asp:HyperLinkField DataNavigateUrlFields="SALE_LINK_PEND" HeaderText="Detail (Pending)" Text="Pending" />
                            <asp:HyperLinkField DataNavigateUrlFields="SALE_LINK_WAIT" HeaderText="Detail (WaitPO)" Text="Wait PO" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    
                </td>
            </tr>
            <tr>
                <th colspan="2">รายละเอียดงาน <asp:Label ID="lb_sale" runat="server"></asp:Label>
                </th>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gv_detail" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" AllowPaging="True" HorizontalAlign="Center" Width="100%" PageSize="2000" >
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel ID="pan_warning" runat="server" Width="100%">
            <asp:Label ID="Label1" runat="server" Text="You don't have permission for this data." ForeColor="#FF3300"></asp:Label>

        </asp:Panel>
    </form>
    
</body>
</html>