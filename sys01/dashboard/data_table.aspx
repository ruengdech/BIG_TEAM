<%@ Page Language="VB" AutoEventWireup="false" CodeFile="data_table.aspx.vb" Inherits="sys01_dashboard_index" %>

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
                <th>Dashboard for ST.Med งานติดตั้ง.</th>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gv_all" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager"  RowStyle-CssClass="rows" PageSize="15" HorizontalAlign="Center" Width="100%"  data-mode="reflow" class="ui-responsive" AutoGenerateColumns="False" DataSourceID="DATASOURCE01">
                        <Columns>
                            <asp:BoundField DataField="YY" HeaderText="YY" ReadOnly="True" SortExpression="YY" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <HeaderStyle CssClass="header" BackColor="blue"></HeaderStyle>

                        <PagerStyle CssClass="myPagerClass" />

                         <RowStyle CssClass="rows"></RowStyle>
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE01" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT year(req_installdate) AS YY , count (*) AS Total , sum ([ติดตั้งเครื่องมือแพทย์] ) [ติดตั้งเครื่องมือแพทย์], sum ([Demo]) [Demo], sum ([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum ([แสดงสินค้า] ) [แสดงสินค้า], sum ([สำรองเครื่อง]) [สำรองเครื่อง], sum ([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum ([Preventive Maintainance]) [PM] , sum ([อื่นๆ]) [อื่นๆ] FROM SYS01_TS_REQUEST PIVOT( count (engineer_job_detail) FOR req_jobtype1 IN ([ติดตั้งเครื่องมือแพทย์],[Demo],[ย้ายเครื่องมือแพทย์],[แสดงสินค้า],[สำรองเครื่อง],[ตรวจเช็คระบบ],[Preventive Maintainance],[อื่นๆ]) ) AS MAIN_DATA WHERE req_status &lt;&gt; 'INACTIVE' GROUP BY year(req_installdate)"></asp:SqlDataSource>
                    <asp:Chart ID="Chart1" runat="server" DataSourceID="EndYear" Width="415px" DataMember="DefaultView" EnableViewState="True">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Pie" XValueMember="Year" YValueMembers="JOB" IsValueShownAsLabel="True" IsXValueIndexed="True" Label="ปี #VALX \nจำนวนงาน #VAL">
                               
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY Enabled="True" IntervalAutoMode="VariableCount">
                                </AxisY>
                                <AxisX LabelAutoFitMinFontSize="10" LabelAutoFitMaxFontSize="12" IntervalAutoMode="VariableCount" Title="Year" ArrowStyle="Lines" Enabled="True">
                                    <CustomLabels>
                                        <asp:CustomLabel Text="Year" />
                                    </CustomLabels>
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Year" Text="Year of work">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>

                    <asp:SqlDataSource ID="EndYear" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT YEAR(req_installdate) AS Year, COUNT(YEAR(req_installdate)) AS JOB FROM SYS01_TS_REQUEST WHERE (req_group = 00) GROUP BY YEAR(req_installdate)"></asp:SqlDataSource>
                    <asp:Chart ID="Chart2" runat="server" DataSourceID="AmData" Height="420px" Width="547px" BorderlineWidth="2" DataMember="DefaultView" TabIndex="12" ViewStateContent="All" ViewStateMode="Enabled">
                        <Series>
                            <asp:Series ChartType="Bar" Name="Series1" XValueMember="req_amname" YValueMembers="CountAM" ChartArea="ChartArea1" IsValueShownAsLabel="True" IsXValueIndexed="True">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY Title="จำนวนงาน" IntervalAutoMode="VariableCount">
                                         <MajorGrid Enabled="False" />
                                          <LabelStyle Format="0,0" />
                                  </AxisY>
                                  <AxisX Title="ชื่อ AM" LabelAutoFitMinFontSize="10" IntervalAutoMode="VariableCount">
                                         <MajorGrid Enabled="False" />
                                 </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Title1" Text="Am">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>

                    <asp:SqlDataSource ID="AmData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_amid, COUNT(req_amid) AS CountAM, req_amname FROM SYS01_TS_REQUEST WHERE (req_group = 00) GROUP BY req_amid, req_amname"></asp:SqlDataSource>
                    <asp:Chart ID="Chart3" runat="server" DataSourceID="BmData" Height="376px" Width="544px">
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Bar" IsValueShownAsLabel="True" IsXValueIndexed="True" Name="Series1" XValueMember="req_bmname" YValueMembers="Countbm">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                               <AxisY Title="จำนวนงาน" IntervalAutoMode="VariableCount">
                                         <MajorGrid Enabled="False" />
                                          <LabelStyle Format="0,0" />
                                  </AxisY>
                                  <AxisX Title="ชื่อ BM" LabelAutoFitMinFontSize="10" IntervalAutoMode="VariableCount">
                                         <MajorGrid Enabled="False" />
                                 </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Title1" Text="Bm">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
                    <asp:SqlDataSource ID="BmData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_bmid, COUNT(req_bmid) AS Countbm, req_bmname FROM SYS01_TS_REQUEST WHERE (req_group = 00) GROUP BY req_bmid, req_bmname"></asp:SqlDataSource>
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
                <th>สรุปรายงานตามสถานะ</th>
            </tr>
            <tr>
                <td >
                    <asp:GridView ID="GV_STATUS" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE_STATUS" >
                        <Columns>
                            <asp:BoundField DataField="สถานะ" HeaderText="สถานะ" SortExpression="สถานะ" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE_STATUS" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="select req_status as [สถานะ]  , count (*) as Total
			 , sum ([ติดตั้งเครื่องมือแพทย์] ) [ติดตั้งเครื่องมือแพทย์], sum ([Demo]) [Demo], sum ([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum ([แสดงสินค้า] ) [แสดงสินค้า], sum ([สำรองเครื่อง]) [สำรองเครื่อง], sum ([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum ([Preventive Maintainance]) [PM] , sum ([อื่นๆ]) [อื่นๆ]
from SYS01_TS_REQUEST
pivot(
	count (engineer_job_detail) for  req_jobtype1 in ([ติดตั้งเครื่องมือแพทย์],[Demo],[ย้ายเครื่องมือแพทย์],[แสดงสินค้า],[สำรองเครื่อง],[ตรวจเช็คระบบ],[Preventive Maintainance],[อื่นๆ])
) as MAIN_DATA
WHERE req_status &lt;&gt; 'INACTIVE' and year(req_installdate) = @Pyear
group by req_status
">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td >
            </tr>
            
            <tr>
                <th>สรุปรายงานตามประเภทของงาน</th>
            </tr>
            <tr>
                <td >
                    <asp:GridView ID="GV_JOBDATE" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE_JOBDATE" >
                        <Columns>
                            <asp:BoundField DataField="ประเภทของงาน" HeaderText="ประเภทของงาน" SortExpression="ประเภทของงาน" ReadOnly="True" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="DATASOURCE_JOBDATE" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="select CASE WHEN DATEDIFF(day, req_date, req_installdate) &lt;=3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day, req_date, req_installdate) &lt;=6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END  END as [ประเภทของงาน]   , count (*) as Total
			 , sum ([ติดตั้งเครื่องมือแพทย์] ) [ติดตั้งเครื่องมือแพทย์], sum ([Demo]) [Demo], sum ([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum ([แสดงสินค้า] ) [แสดงสินค้า], sum ([สำรองเครื่อง]) [สำรองเครื่อง], sum ([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum ([Preventive Maintainance]) [PM] , sum ([อื่นๆ]) [อื่นๆ]
from SYS01_TS_REQUEST
pivot(
	count (engineer_job_detail) for  req_jobtype1 in ([ติดตั้งเครื่องมือแพทย์],[Demo],[ย้ายเครื่องมือแพทย์],[แสดงสินค้า],[สำรองเครื่อง],[ตรวจเช็คระบบ],[Preventive Maintainance],[อื่นๆ])
) as MAIN_DATA
WHERE req_status &lt;&gt; 'INACTIVE' and year(req_installdate) = @Pyear
group by CASE WHEN DATEDIFF(day, req_date, req_installdate) &lt;=3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day, req_date, req_installdate) &lt;=6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END  END ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </td >
            </tr>
            <tr>
                <th>สรุปรายงานตามรายชื่อ AM</th>
            </tr>
            <tr>
                <td >
                    <asp:GridView ID="gv_am" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE02" >
                        <Columns>
                            <asp:HyperLinkField HeaderText="Select"  Target="_blank" Text="Select" DataNavigateUrlFields="LINK" />
                            <asp:BoundField DataField="AM" HeaderText="AM" SortExpression="AM" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE02" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_amname AS AM, count(*) AS Total, sum([ติดตั้งเครื่องมือแพทย์]) [ติดตั้งเครื่องมือแพทย์], sum([Demo]) [Demo], sum([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum([แสดงสินค้า]) [แสดงสินค้า], sum([สำรองเครื่อง]) [สำรองเครื่อง], sum([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum([Preventive Maintainance]) [PM], sum([อื่นๆ]) [อื่นๆ], CONCAT('index_am.aspx?am=' , req_amid , '&amp;year=' , @Pyear)  AS LINK 

FROM SYS01_TS_REQUEST PIVOT (count(engineer_job_detail) FOR req_jobtype1 IN ([ติดตั้งเครื่องมือแพทย์], [Demo], [ย้ายเครื่องมือแพทย์], [แสดงสินค้า], [สำรองเครื่อง], [ตรวจเช็คระบบ], [Preventive Maintainance], [อื่นๆ])) AS MAIN_DATA WHERE req_status &lt;&gt; 'INACTIVE' AND year(req_installdate) = @Pyear GROUP BY req_amname,CONCAT('index_am.aspx?am=' , req_amid , '&amp;year=', @Pyear)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td >
            </tr>
            <tr>
                <th>สรุปรายงานตามรายชื่อ BM</th>
            </tr>
            <tr>
                
                <td>
                    <asp:GridView ID="gv_bm" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE03" >
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="LINK" HeaderText="Select" Target="_blank" Text="Select" />
                            <asp:BoundField DataField="BM" HeaderText="BM" SortExpression="BM" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE03" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_bmname AS BM, count(*) AS Total, sum([ติดตั้งเครื่องมือแพทย์]) [ติดตั้งเครื่องมือแพทย์], sum([Demo]) [Demo], sum([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum([แสดงสินค้า]) [แสดงสินค้า], sum([สำรองเครื่อง]) [สำรองเครื่อง], sum([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum([Preventive Maintainance]) [PM], sum([อื่นๆ]) [อื่นๆ] 
,CONCAT('index_bm.aspx?bm=' , req_bmid , '&amp;year=', @Pyear) as LINK

FROM SYS01_TS_REQUEST PIVOT (count(engineer_job_detail) FOR req_jobtype1 IN ([ติดตั้งเครื่องมือแพทย์], [Demo], [ย้ายเครื่องมือแพทย์], [แสดงสินค้า], [สำรองเครื่อง], [ตรวจเช็คระบบ], [Preventive Maintainance], [อื่นๆ])) AS MAIN_DATA WHERE req_status &lt;&gt; 'INACTIVE' AND year(req_installdate) = @Pyear GROUP BY req_bmname, CONCAT('index_bm.aspx?bm=' , req_bmid , '&amp;year=', @Pyear)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <th>สรุปรายงานตามช่าง</th>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gv_head" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" RowStyle-CssClass="rows" HorizontalAlign="Center" Width="100%" PageSize="2000" AutoGenerateColumns="False" DataSourceID="DATASOURCE04" >
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="LINK" HeaderText="Select" Target="_blank" Text="Select" />
                            <asp:BoundField DataField="Engineer" HeaderText="Engineer" SortExpression="Engineer" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="ติดตั้งเครื่องมือแพทย์" HeaderText="ติดตั้งเครื่องมือแพทย์" ReadOnly="True" SortExpression="ติดตั้งเครื่องมือแพทย์" />
                            <asp:BoundField DataField="Demo" HeaderText="Demo" ReadOnly="True" SortExpression="Demo" />
                            <asp:BoundField DataField="ย้ายเครื่องมือแพทย์" HeaderText="ย้ายเครื่องมือแพทย์" ReadOnly="True" SortExpression="ย้ายเครื่องมือแพทย์" />
                            <asp:BoundField DataField="แสดงสินค้า" HeaderText="แสดงสินค้า" ReadOnly="True" SortExpression="แสดงสินค้า" />
                            <asp:BoundField DataField="สำรองเครื่อง" HeaderText="สำรองเครื่อง" ReadOnly="True" SortExpression="สำรองเครื่อง" />
                            <asp:BoundField DataField="ตรวจเช็คระบบ" HeaderText="ตรวจเช็คระบบ" ReadOnly="True" SortExpression="ตรวจเช็คระบบ" />
                            <asp:BoundField DataField="PM" HeaderText="PM" ReadOnly="True" SortExpression="PM" />
                            <asp:BoundField DataField="อื่นๆ" HeaderText="อื่นๆ" ReadOnly="True" SortExpression="อื่นๆ" />
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <RowStyle CssClass="rows" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DATASOURCE04" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT S_NAME AS Engineer, count(*) AS Total, sum([ติดตั้งเครื่องมือแพทย์]) [ติดตั้งเครื่องมือแพทย์], sum([Demo]) [Demo], sum([ย้ายเครื่องมือแพทย์]) [ย้ายเครื่องมือแพทย์], sum([แสดงสินค้า]) [แสดงสินค้า], sum([สำรองเครื่อง]) [สำรองเครื่อง], sum([ตรวจเช็คระบบ]) [ตรวจเช็คระบบ], sum([Preventive Maintainance]) [PM], sum([อื่นๆ]) [อื่นๆ], CONCAT('index_engineer.aspx?engineer=', S_ID, '&amp;year=', @Pyear) AS LINK FROM SYS01_VIEW_ENGINEER_JOB PIVOT (count(engineer_job_detail) FOR req_jobtype1 IN ([ติดตั้งเครื่องมือแพทย์], [Demo], [ย้ายเครื่องมือแพทย์], [แสดงสินค้า], [สำรองเครื่อง], [ตรวจเช็คระบบ], [Preventive Maintainance], [อื่นๆ])) AS MAIN_DATA WHERE req_status &lt;&gt; 'INACTIVE' AND year(req_installdate) = @Pyear GROUP BY S_NAME, CONCAT('index_engineer.aspx?engineer=', S_ID, '&amp;year=', @Pyear)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
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
