<%@ Page Language="VB" AutoEventWireup="false" CodeFile="data_dashboard.aspx.vb" Inherits="sys01_dashboard_New_DataTable" %>

<!DOCTYPE html>

<script runat="server">
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        Application("PTui") = 0
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        Application("PTui") = Nothing
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Application.Lock()
        Application("PTui") = Application("PTui") + 1
        Application.UnLock()
    End Sub
    </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>ระบบงานติดตั้ง (Dashboard)</title>
    <link rel="stylesheet" href="../themes/ST_MED.css" />
	<link rel="stylesheet" href="../themes/jquery.mobile.icons.min.css" />
    <link href="../themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../themes/jquery-1.11.1.min.js"></script>
    <script src="../themes/jquery.mobile-1.4.5.min.js"></script>
     <style>
        table {
          width: 140px;
          height: 80px;
          border-collapse: collapse;
          display: inline-table;
        }

        table, th, td {
          border: none;

        }
        th, td {
          padding-top: 15px;
          padding-left: 15px;
          padding-right: 15px;
          text-align: center;
        }
        th {
            color: black;
        }
  
         .auto-style1 {
             width: 230px;
         }
  
    </style>
</head>

<body>

    <form id="form1" runat="server" style="background-color:#FFFCF5" >

    <div data-role="header" data-position="inline">
            <h1><img src="../../img/SM_LOGO.gif" style="width:300px;" /></h1>
			<h1>Saintmed: ระบบงานติดตั้ง (Dashboard) </h1>
	</div>
    <div style="background-color:aliceblue">
    <br /><br />
        </div>
        <center>
        <div style="background-color:aliceblue">
            <div style="width:40%"> 
          &nbsp;เลือกปีที่ต้องการ:&nbsp;<asp:DropDownList ID="ddl_year" runat="server" AutoPostBack="True" data-native-menu="false" >
                        <asp:ListItem Value="2021">2021</asp:ListItem>
                        <asp:ListItem Value="2022">2022</asp:ListItem>
                        <asp:ListItem Value="2023">2023</asp:ListItem>
                        <asp:ListItem Value="2024">2024</asp:ListItem>
                        <asp:ListItem Value="2025">2025</asp:ListItem>
                        <asp:ListItem Value="2026">2026</asp:ListItem>
                        <asp:ListItem Value="2027">2027</asp:ListItem>
                        <asp:ListItem Value="2028">2028</asp:ListItem>
                    </asp:DropDownList>
                &nbsp;เลือกกลุ่มที่ต้องการ:&nbsp;<asp:DropDownList ID="ddl_reqGroup" runat="server"  AutoPostBack="True" data-native-menu="false" >
                    <asp:ListItem Value="00">พี่ตุ๋ย</asp:ListItem>
                    <asp:ListItem Value="01">พี่ต่าย</asp:ListItem>
                </asp:DropDownList>
                </div>
            <br /><br />
          </div>
            
      <table>
            <tr>
                       <th>   
        <asp:DataList ID="DataList10" runat="server" DataSourceID="NewData2">
            <ItemStyle BackColor="#99FFCC" />
                        <ItemTemplate>
                NEW<br />
                <asp:Label ID="NEWLabel" runat="server" Text='<%# Eval("NEW") %>' />
                         <br />
<br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="NewData2" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_status) AS NEW FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'new%') and year(req_installdate) = @Pyear AND (req_group = @ddl_Choosereqgroup)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
            </SelectParameters>
                           </asp:SqlDataSource>
                        </th>

                <th>
           <asp:DataList ID="DataList1" runat="server" DataSourceID="NewData">
                        <ItemStyle BackColor="#99FFCC" />
                        <ItemTemplate>
                            START<br /> &nbsp;<asp:Label ID="STARTLabel" runat="server" Text='<%# Eval("START") %>' />
                            <br />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="NewData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_status) AS START FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'start%') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
    

                    </th>

                <th>

                          <asp:DataList ID="DataList2" runat="server" DataSourceID="PlanData">
                              <ItemStyle BackColor="#99FFCC" />
                        <ItemTemplate>
                            PLAN<br /> <asp:Label ID="STARTLabel" runat="server" Text='<%# Eval("START") %>' />
                            <br />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="PlanData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_status) AS START FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'plan%') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                          </asp:SqlDataSource>


                    </th>
                 <th>

                          <asp:DataList ID="DataList3" runat="server" DataSourceID="AssignData">
                              <ItemStyle BackColor="#99FFCC" ForeColor="#333333" />
                        <ItemTemplate>
                            ASSIGNED<br />
                            <asp:Label ID="ASSIGNEDLabel" runat="server" Text='<%# Eval("ASSIGNED") %>' />
                            <br />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="AssignData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_status) AS ASSIGNED FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'assigned%') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                          </asp:SqlDataSource>


                 </th>
                <th>

                          <asp:DataList ID="DataList4" runat="server" DataSourceID="FinishData">
                              <ItemStyle BackColor="#99FFCC" />
                        <ItemTemplate>
                            FINISH<br />
                            <asp:Label ID="FINISHLabel" runat="server" Text='<%# Eval("FINISH") %>' />
                            <br />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="FinishData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_status) AS FINISH FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'finish%') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                          </asp:SqlDataSource>
                 </th>
                <th>
                <asp:DataList ID="DataList11" runat="server" DataSourceID="TotalData">
                    <ItemStyle BackColor="#99FFCC" ForeColor="#333333" />
                    <ItemTemplate>
                        TOTAL<br /> &nbsp;<asp:Label ID="JOBLabel" runat="server" Text='<%# Eval("JOB") %>' />
                        <br />
<br />
                    </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="TotalData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(YEAR(req_installdate)) AS JOB FROM SYS01_TS_REQUEST WHERE (req_status &lt;&gt; 'INACTIVE') AND (YEAR(req_installdate) &lt; 2100) AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup) GROUP BY YEAR(req_installdate)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </th>
                <th>

                    

      <asp:DataList ID="DataList6" runat="server" DataSourceID="UrgentworkData">
          <ItemStyle BackColor="#99CCFF" />
          <ItemTemplate>
              &nbsp;งานด่วนมาก<br />
          <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
              <br /> 
              <br />
          </ItemTemplate>
      </asp:DataList>
       <asp:SqlDataSource ID="UrgentworkData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END AS ประเภทของงาน, COUNT(*) AS Total FROM SYS01_TS_REQUEST WHERE (YEAR(req_installdate) = @Pyear) AND (req_status &lt;&gt; 'INACTIVE') AND (DATEDIFF(day, req_date, req_installdate) &lt;= 3)  AND (req_group = @ddl_Choosereqgroup)  GROUP BY CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END">
           <SelectParameters>
               <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
               <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
           </SelectParameters>
                    </asp:SqlDataSource>
                 </th>

                <th>
        
        <asp:DataList ID="DataList5" runat="server" DataSourceID="SqlDataSource1">
            <ItemStyle BackColor="#99CCFF" />
            <ItemTemplate>
                งานด่วน<br /> <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END AS ประเภทของงาน, COUNT(*) AS Total FROM SYS01_TS_REQUEST WHERE (YEAR(req_installdate) = @Pyear) AND (req_status &lt;&gt; 'INACTIVE') AND (DATEDIFF(day, req_date, req_installdate) &lt;= 6) AND (DATEDIFF(day, req_date, req_installdate) &gt; 3)  AND (req_group = @ddl_Choosereqgroup)  GROUP BY CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
            </SelectParameters>
                    </asp:SqlDataSource>

                 </th>
                <th class="auto-style1">
        <asp:DataList ID="DataList7" runat="server" DataSourceID="StandardWork">
            <ItemStyle BackColor="#99CCFF" />
            <ItemTemplate>
                งานปกติ<br />
                <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="StandardWork" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END AS ประเภทของงาน, COUNT(*) AS Total FROM SYS01_TS_REQUEST WHERE (DATEDIFF(day, req_date, req_installdate) &gt; 6) AND (YEAR(req_installdate) = @Pyear) AND (req_status &lt;&gt; 'INACTIVE')  AND (req_group = @ddl_Choosereqgroup)  GROUP BY CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 3 THEN '01 งานด่วนมาก' ELSE CASE WHEN DATEDIFF(day , req_date , req_installdate) &lt;= 6 THEN '02 งานด่วน' ELSE '03 งานปรกติ' END END">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
            </SelectParameters>
                    </asp:SqlDataSource>

                 </th>
                </tr>
          </table>
          </center>
 



        <div>
            <center>
         <table style="width:90%;">
             <tr>
                 <th rowspan="2" style="padding-top: 0px; padding-left: 0px; padding-right: 0px;">
        <asp:Chart ID="Chart5" runat="server" DataSourceID="EndYearByMonth" Width="1003px" EnableViewState="True">
            <Series>
                <asp:Series IsXValueIndexed="True" Name="Series1" XValueMember="MONTH" YValueMembers="JOB" IsValueShownAsLabel="True" Color="255, 224, 192" Palette="Pastel">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY IntervalAutoMode="VariableCount">
                        <MajorGrid Enabled="False" />
                    </AxisY>
                    <AxisX IntervalAutoMode="VariableCount" Maximum="13">
                        <MajorGrid Enabled="False" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title Name="Title1" Text="จำนวนงานรายเดือน" Font="Microsoft Sans Serif, 12pt" TextStyle="Shadow">
                </asp:Title>
            </Titles>
        </asp:Chart>
 
                     <asp:SqlDataSource ID="EndYearByMonth" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT { fn MONTHNAME(req_installdate) } AS MONTH, COUNT(MONTH(req_installdate)) AS JOB FROM SYS01_TS_REQUEST WHERE (req_group = 00) AND (req_status &lt;&gt; 'INACTIVE') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)  GROUP BY { fn MONTHNAME(req_installdate) }, MONTH(req_installdate)">
                         <SelectParameters>
                             <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                             <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                         </SelectParameters>
                     </asp:SqlDataSource>
 
        <asp:Chart ID="Chart1" runat="server" DataSourceID="EndYear" Width="357px" DataMember="DefaultView" EnableViewState="True" Height="300px">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Pie" XValueMember="Year" YValueMembers="JOB" IsValueShownAsLabel="True" IsXValueIndexed="True" Label="ปี #VALX \nจำนวนงาน #VAL" Legend="Legend3">
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
                        <Legends>
                            <asp:Legend Name="Legend3">
                            </asp:Legend>
                        </Legends>
                        <Titles>
                            <asp:Title Name="Year" Text="Year of work" Font="Microsoft Sans Serif, 12pt" TextStyle="Shadow">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
                     </th>
                
      <td style="padding-top: 0px; padding-left: 0px; padding-right: 0px;">
     <asp:DataList ID="DataList8" runat="server" DataSourceID="EndTask" Font-Bold="True">
            <ItemStyle BackColor="#99CCFF" />
            <ItemTemplate>
                ปิดงาน<br />
                <asp:Label ID="จำนวนงานLabel" runat="server" Text='<%# Eval("isfinish") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
           <asp:SqlDataSource ID="EndTask" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_isfinish) AS isfinish FROM SYS01_TS_REQUEST WHERE (req_status LIKE 'finish%') AND (YEAR(req_installdate) = @Pyear) AND (req_isfinish &lt;&gt; 'TRUE')  AND (req_group = @ddl_Choosereqgroup) ">
               <SelectParameters>
                   <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                   <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
               </SelectParameters>
          </asp:SqlDataSource>
           </td>
  </tr>
             <tr>
          <td style="padding-top: 0px; padding-left: 0px; padding-right: 0px;">
   <asp:DataList ID="DataList9" runat="server" DataSourceID="EndTaskElse" Font-Bold="True">
            <ItemStyle BackColor="#99CCFF"  />
            <ItemTemplate>
                ปิดงาน*<br />
                <asp:Label ID="จำนวนงานLabel" runat="server" Text='<%# Eval("isfinish") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
              <asp:SqlDataSource ID="EndTaskElse" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(req_isfinish) AS isfinish FROM SYS01_TS_REQUEST WHERE (req_isfinish = 'TRUE') AND (YEAR(req_installdate) = @Pyear)  AND (req_group = @ddl_Choosereqgroup) ">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                  </SelectParameters>
              </asp:SqlDataSource>
  </td>
 </tr>
</table>
                </center>
            </div>
       
 
        
        <center>
                    <asp:SqlDataSource ID="EndYear" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT YEAR(req_installdate) AS Year, COUNT(YEAR(req_installdate)) AS JOB FROM SYS01_TS_REQUEST WHERE  (req_status &lt;&gt; 'INACTIVE') AND (YEAR(req_installdate) &lt; 2100) AND (req_group = @ddl_Choosereqgroup)  GROUP BY YEAR(req_installdate)  ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                        <br />
                    <asp:Chart ID="Chart2" runat="server" DataSourceID="AmData" Height="520px" Width="650px" BorderlineWidth="2" DataMember="DefaultView" TabIndex="12" ViewStateContent="All" ViewStateMode="Enabled" IsMapAreaAttributesEncoded="True">
                        <Series>
                            <asp:Series ChartType="Bar" Name="Series1" XValueMember="Expr1" YValueMembers="CountAM" ChartArea="ChartArea1" IsValueShownAsLabel="True" IsXValueIndexed="True" MapAreaAttributes="#VALX" LabelUrl="~/sys01/dashboard/data_am.aspx?req_am_id=#VALX">
                            </asp:Series>
                        </Series>
                        <MapAreas>
                            <asp:MapArea Coordinates="0,0,0,0" MapAreaAttributes="#VALX" Url="~/sys01/dashboard/TEST.aspx?#VALX" />
                        </MapAreas>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY Title="จำนวนงาน" IntervalAutoMode="VariableCount" TitleFont="Microsoft Sans Serif, 9pt">
                                         <MajorGrid Enabled="False" />
                                          <LabelStyle Format="0,0" />
                                  </AxisY>
                                  <AxisX Title="รายชื่อ AREA MANAGER" LabelAutoFitMinFontSize="10" IntervalAutoMode="VariableCount"  TitleFont="Microsoft Sans Serif, 9pt">
                                         <MajorGrid Enabled="False" />
                                 </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Title1" Text="AREA MANAGER" Font="Microsoft Sans Serif, 12pt" TextStyle="Shadow">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>

                    <asp:SqlDataSource ID="AmData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_amid, COUNT(req_amid) AS CountAM, req_amname, req_amname + '|' + CAST(req_amid AS varchar) AS Expr1 FROM SYS01_TS_REQUEST WHERE (req_group = 00) AND (req_status &lt;&gt; 'INACTIVE') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)  GROUP BY req_amid, req_amname ORDER BY CountAM DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Chart ID="Chart3" runat="server" DataSourceID="BmData" Height="520px" Width="650px">
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Bar" IsValueShownAsLabel="True" IsXValueIndexed="True" Name="Series1" XValueMember="Expr1" YValueMembers="Countbm" LabelUrl="~/sys01/dashboard/data_bm.aspx?req_bm_id=#VALX" MapAreaAttributes="#VALX">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                               <AxisY Title="จำนวนงาน" IntervalAutoMode="VariableCount" TitleFont="Microsoft Sans Serif, 9pt">
                                         <MajorGrid Enabled="False" />
                                          <LabelStyle Format="0,0" />
                                  </AxisY>
                                  <AxisX Title="รายชื่อ BRAND MANAGER" LabelAutoFitMinFontSize="10" IntervalAutoMode="VariableCount" TitleFont="Microsoft Sans Serif, 9pt">
                                         <MajorGrid Enabled="False" />
                                 </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Title1" Text="BRAND MANAGER" Font="Microsoft Sans Serif, 12pt" TextStyle="Shadow">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
            

                    <asp:SqlDataSource ID="BmData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT req_bmid, COUNT(req_bmid) AS Countbm, req_bmname,req_bmname + '|' +  CAST(req_bmid AS varchar) AS Expr1 FROM SYS01_TS_REQUEST WHERE (req_group = 00) AND (req_status &lt;&gt; 'INACTIVE') AND (YEAR(req_installdate) = @Pyear) AND (req_group = @ddl_Choosereqgroup)  GROUP BY req_bmid, req_bmname ORDER BY Countbm DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Chart ID="Chart4" runat="server" DataSourceID="HeadMaintainData" Height="1126px" Width="1386px">
                        <Series>
                            <asp:Series ChartType="Bar" IsValueShownAsLabel="True" Name="Series1" XValueMember="Expr1" YValueMembers="Engineer" LabelUrl="~/sys01/dashboard/data_engineer.aspx?req_engineer_id=#VALX" MapAreaAttributes="#VALX">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY IntervalAutoMode="VariableCount" Title="จำนวนงาน" TitleFont="Microsoft Sans Serif, 9pt">
                                    <MajorGrid Enabled="False" />
                                </AxisY>
                                <AxisX IntervalAutoMode="VariableCount" Title="รายชื่อ ENGINEER" TitleFont="Microsoft Sans Serif, 9pt">
                                    <MajorGrid Enabled="False" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Font="Microsoft Sans Serif, 12pt" Name="Title1" Text="ENGINEER" TextStyle="Shadow">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
                    <asp:SqlDataSource ID="HeadMaintainData" runat="server" ConnectionString="<%$ ConnectionStrings:RUENGDECH_STMEDConnectionString %>" SelectCommand="SELECT COUNT(SYS01_VIEW_ENGINEER_JOB.S_NAME) AS Engineer, SYS01_VIEW_ENGINEER_JOB.S_ID, SYS01_VIEW_ENGINEER_JOB.S_NAME, SYS01_VIEW_ENGINEER_JOB.S_NAME + '|' + CAST(SYS01_VIEW_ENGINEER_JOB.S_ID AS varchar) AS Expr1 FROM SYS01_VIEW_ENGINEER_JOB INNER JOIN SYS01_TS_REQUEST ON SYS01_VIEW_ENGINEER_JOB.uid = SYS01_TS_REQUEST.uid WHERE (SYS01_VIEW_ENGINEER_JOB.req_status &lt;&gt; 'INACTIVE') AND (YEAR(SYS01_VIEW_ENGINEER_JOB.req_installdate) = @Pyear) AND (SYS01_TS_REQUEST.req_group = @ddl_Choosereqgroup) GROUP BY SYS01_VIEW_ENGINEER_JOB.S_ID, SYS01_VIEW_ENGINEER_JOB.S_NAME ORDER BY Engineer DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_year" DefaultValue="2021" Name="Pyear" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddl_reqGroup" DefaultValue="00" Name="ddl_Choosereqgroup" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    
                   </center>
    </form>
</body>
</html>


