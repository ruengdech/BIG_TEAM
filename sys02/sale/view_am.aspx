<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">

    Dim USER_STAFF_ID As String = "" ' "314001" '  
    Dim USER_STAFF_NAME As String = "RUENGDECH LA-ORPONGAISAN"





</script>
<%
    Session("URL") = "../../sys02/sale/view_am.aspx"
    Dim clsa As New MY_CLASS
    Dim cls As New MY_CLASS_MSSQL()
    Dim clss As New MY_CLASS_MSSQL("newsm", "sa", "Sapb1")

    Try
        If IsNothing(Session("STAFF_ID")) Then
            If Request.QueryString("user_id") <> Nothing Then
                clsa.strSql = "SELECT " &
                                    "users.ID, users.username, employee2.uid, users.pswd, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
                                "FROM  " &
                                    "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                                    "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                                "WHERE (((users.ID)=" & Request.QueryString("user_id") & ") );"
                clsa.func_SetDataSet(clsa.strSql, "LOGIN")
                If clsa.ds.Tables("LOGIN").Rows.Count > 0 Then
                    With clsa.ds.Tables("LOGIN").Rows(0)
                        Session("STAFF_ID") = .Item("uid").ToString
                        Session("USER_ID") = .Item("ID").ToString
                        Session("USER_NAME") = .Item("username").ToString
                        Session("USER_FNAME") = .Item("name").ToString & " " & .Item("lastname").ToString
                        Session("USER_ABR") = .Item("abr").ToString
                        Session("USER_TYPE") = .Item("USER_TYPE").ToString


                        cls.strSql = "SELECT STAFF_TYPE FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & Session("STAFF_ID") & ")"
                        cls.func_SetDataSet(cls.strSql, "TYPES")
                        'response.write(cls.strSql & "123")
                        Try
                            Session("USER_CATEGORY") = cls.ds.Tables("TYPES").Rows(0).Item(0).ToString
                        Catch ex As Exception

                        End Try
                    End With
                Else
                    Session("URL") = ""
                    Response.Redirect("../../sys01/authentication/login.aspx")
                End If

            Else
                Response.Redirect("../../sys01/authentication/login.aspx")
            End If
        Else
            'DO NOTHING
        End If
    Catch ex As Exception
        Response.Redirect("../../sys01/authentication/login.aspx")
    End Try




    USER_STAFF_ID = Session("STAFF_ID")
    USER_STAFF_NAME = Session("USER_FNAME")

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="../RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />
    <link href="../../css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet" />
    <script src="../../JS/jquery-1.11.1.min.js"></script>
    <script src="../../JS/jquery.mobile-1.4.5.min.js"></script>
    <%--<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" /> 
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>   --%>  
	<style>
	 .center {
		  margin: auto !important;
		  text-align: center !important;
	 }
	 
     .table_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
     }
     .table_list th, .table_list td {
          border: 1px solid #ddd;
          font-size: 0.9em;
          padding: 5px;
     }
     .table_list tr:nth-child(even) {background-color: #f2f2f2;}
     .table_list tr:hover  {background-color: #ddd;}
     .table_list th {
          padding-top: 4px;
          padding-bottom: 4px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
     }
     /*.container {margin:150px auto;}*/
	   
	</style>
    <script type="text/javascript" >
        var JOB_DATA = [];
        var PRODUCT_DATA = [];
        var MODEL_DATA = [];
        var STAFF_ID = "";
        var BM_DATA = [];
        var STAFF_DATA = [];
        var _YEAR = "";
        var _MONTH = "";
        var _PROB = "";
    </script>
    <link href="../../css/jquerysctipttop.css" rel="stylesheet" />
    <link href="../RESOURCE/table_filter/Filter.css" rel="stylesheet" />
    <script src="../RESOURCE/table_filter/Filter.js"></script>
    <script>
        function myFunction() {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tb_list");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>
    <style>
        #tb_list {
          background-image: url('/css/searchicon.png'); /* Add a search icon to input */
          background-position: 10px 12px; /* Position the search icon */
          background-repeat: no-repeat; /* Do not repeat the icon image */
          width: 100%; /* Full-width */
          font-size: 16px; /* Increase font-size */
          padding: 12px 20px 12px 40px; /* Add some padding */
          border: 1px solid #ddd; /* Add a grey border */
          margin-bottom: 12px; /* Add some space below the input */
        }

        #tb_list {
          border-collapse: collapse; /* Collapse borders */
          width: 100%; /* Full-width */
          border: 1px solid #ddd; /* Add a grey border */
          font-size: 18px; /* Increase font-size */
        }

        #tb_list th, #tb_list td {
          text-align: left; /* Left-align text */
          padding: 12px; /* Add padding */
        }

        #tb_list tr {
          /* Add a bottom border to all table rows */
          border-bottom: 1px solid #ddd;
        }

        #tb_list tr.header, #tb_list tr:hover {
          /* Add a grey background color to the table header and on hover */
          background-color: #f1f1f1;
        }
    </style>
</head>
<% 

    'clss.strSql = "SELECT CardName FROM OCRD WHERE (CardType = 'C') GROUP BY CardName ORDER BY CardName"
    'clss.func_SetDataSet(clss.strSql, "HOSPITAL_DATA")

    Dim CONDITION_ As String = ""
    cls.strSql = "SELECT VIEW_STAFF_ID, VIEW_PRODUCT_UID FROM SYS02_MS_STAFF_PRIVILED WHERE (STAFF_ID = '" & USER_STAFF_ID & "')"
    cls.func_SetDataSet(cls.strSql, "STAFF")
    If cls.ds.Tables("STAFF").Rows.Count > 0 Then
        With cls.ds.Tables("STAFF").Rows(0)
            'If .Item(0).ToString = "ALL" And .Item(1).ToString = "ALL" Then
            '    CONDITION_ = "  " ' Nothing to Fillter
            'ElseIf .Item(0).ToString = "ALL" And .Item(1).ToString = "ALL" Then
            'End If
            CONDITION_ = " AND ( (" & .Item(0).ToString & ") AND (" & .Item(1).ToString & ") )  "
        End With
    Else
        Response.End()
    End If




    If Session("USER_CATEGORY").ToString().IndexOf("DIRECTOR") > -1 Then
        cls.strSql = "SELECT SALE_ORDER_YEAR, SALE_ORDER_MONTH, STAFF_NAME, ORDERPROB_ID, ORDERPROB_NAME, REVENUE, SALE_STAFF_ID FROM  SYS02_VIEW_AM_VIEW ORDER BY SALE_ORDER_YEAR, SALE_ORDER_MONTH, ORDERPROB_ID"
        cls.func_SetDataSet(cls.strSql, "JOB_DATA")

        cls.strSql = "SELECT SALE_STAFF_ID, STAFF_NAME, 0 AS [0], 0 AS [1], 0 AS [2], 0 AS [3], 0 AS [4], 0 AS [5], 0 AS [6], 0 AS [7], 0 AS [8], 0 AS [9], 0 AS [10], 0 AS [11], 0 AS [12] FROM SYS02_VIEW_AM_VIEW GROUP BY SALE_STAFF_ID, STAFF_NAME ORDER BY STAFF_NAME"
        cls.func_SetDataSet(cls.strSql, "STAFF_DATA")

    Else
        cls.strSql = "SELECT SALE_ORDER_YEAR, SALE_ORDER_MONTH, STAFF_NAME, ORDERPROB_ID, ORDERPROB_NAME, REVENUE, SALE_STAFF_ID FROM  SYS02_VIEW_AM_VIEW WHERE (SALE_STAFF_AM_ID = '" & USER_STAFF_ID & "') OR  (SALE_STAFF_ID = '" & USER_STAFF_ID & "') ORDER BY SALE_ORDER_YEAR, SALE_ORDER_MONTH, ORDERPROB_ID"
        cls.func_SetDataSet(cls.strSql, "JOB_DATA")

        cls.strSql = "SELECT SALE_STAFF_ID, STAFF_NAME, 0 AS [0], 0 AS [1], 0 AS [2], 0 AS [3], 0 AS [4], 0 AS [5], 0 AS [6], 0 AS [7], 0 AS [8], 0 AS [9], 0 AS [10], 0 AS [11], 0 AS [12] FROM SYS02_VIEW_AM_VIEW WHERE (SALE_STAFF_AM_ID = '" & USER_STAFF_ID & "') OR  (SALE_STAFF_ID = '" & USER_STAFF_ID & "') GROUP BY SALE_STAFF_ID, STAFF_NAME ORDER BY STAFF_NAME"
        cls.func_SetDataSet(cls.strSql, "STAFF_DATA")
    End If
    '0   SALE_ORDER_YEAR
    '1   SALE_ORDER_MONTH
    '2   STAFF_NAME
    '3   ORDERPROB_ID
    '4   ORDERPROB_NAME
    '5   REVENUE
    '6   STAFF_ID

    'cls.strSql = "SELECT BUDGETTYPE_ID, BUDGETTYPE_NAME, BUDGETTYPE_STATUS FROM SYS02_MS_BUDGET_TYPE WHERE BUDGETTYPE_STATUS = 'ACTIVE' ORDER BY BUDGETTYPE_NAME "
    'cls.func_SetDataSet(cls.strSql, "BUDGET_DATA")

    'cls.strSql = "SELECT CUSTSTATE_ID, CUSTSTATE_NAME, CUSTSTATE_STATUS FROM SYS02_MS_CUSTOMER_STATE WHERE CUSTSTATE_STATUS = 'ACTIVE' ORDER BY CUSTSTATE_NAME "
    'cls.func_SetDataSet(cls.strSql, "CUSTSTATE_DATA")

    cls.strSql = "SELECT ORDERPROB_ID, ORDERPROB_NAME, ORDERPROB_STATUS FROM SYS02_MS_ORDER_PROB WHERE ORDERPROB_STATUS = 'ACTIVE' ORDER BY ORDERPROB_NAME "
    cls.func_SetDataSet(cls.strSql, "PROB_DATA")

    'cls.strSql = "SELECT ORDERSTATE_ID, ORDERSTATE_NAME, ORDERSTATE_STATUS FROM SYS02_MS_ORDER_STATE WHERE ORDERSTATE_STATUS = 'ACTIVE' ORDER BY ORDERSTATE_NAME "
    'cls.func_SetDataSet(cls.strSql, "ORDERSTATE_DATA")

    'cls.strSql = "SELECT PRODUCT_ID, PRODUCT_BRAND_ID, PRODUCT_NAME, PRODUCT_STATUS, PRODUCT_STAFF_ID FROM SYS02_MS_PRODUCT WHERE PRODUCT_STATUS = 'ACTIVE' ORDER BY PRODUCT_NAME "
    'cls.func_SetDataSet(cls.strSql, "PRODUCT_DATA")

%>
<body>

<% 
    If cls.ds.Tables("JOB_DATA").Rows.Count > 0 Then
        For i As Integer = 0 To cls.ds.Tables("JOB_DATA").Rows.Count - 1
            With cls.ds.Tables("JOB_DATA").Rows(i)
%>
            <script>
                JOB_DATA.push([<%response.Write(.Item(0).ToString)%>, <%response.Write(.Item(1).ToString)%>, "<%response.Write(.Item(2).ToString)%>", "<%response.Write(.Item(3).ToString)%>", "<%response.Write(.Item(4).ToString)%>", <%response.Write(.Item(5).ToString)%>, "<%response.Write(.Item(6).ToString)%>"]);
            </script>
<%
            End With
        Next
    End If
%>

<% 
            If cls.ds.Tables("STAFF_DATA").Rows.Count > 0 Then
                For i As Integer = 0 To cls.ds.Tables("STAFF_DATA").Rows.Count - 1
                    With cls.ds.Tables("STAFF_DATA").Rows(i)
%>
            <script>
                STAFF_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>",<%response.Write(.Item(2).ToString)%>,<%response.Write(.Item(3).ToString)%> ,<%response.Write(.Item(4).ToString)%> ,<%response.Write(.Item(5).ToString)%> ,<%response.Write(.Item(6).ToString)%> ,<%response.Write(.Item(7).ToString)%> ,<%response.Write(.Item(8).ToString)%> ,<%response.Write(.Item(9).ToString)%> ,<%response.Write(.Item(10).ToString)%> ,<%response.Write(.Item(11).ToString)%> ,<%response.Write(.Item(12).ToString)%> ,<%response.Write(.Item(13).ToString)%> ,<%response.Write(.Item(14).ToString)%>]);
            </script>
<%
            End With
        Next
    End If
%>

	<div data-role="page" id="page_main">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[Data] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
            <a href="view_am.aspx" rel="external">AM DASHBOARD</a> | <a href="view_bm.aspx" rel="external">BM DASHBOARD</a> | <a href="view_customer01.aspx" rel="external">Customer</a> | <a href="view_customer02.aspx" rel="external">Customer-Sale</a> | <a href="view_product01.aspx" rel="external">Brand-Sale</a> | <a href="view_bm_sale.aspx" rel="external">BM-Sale</a>
            <div class="ui-bar ui-bar-a center">
                <h3>AM Dashboard</h3>
            </div>

            <div class="container">  
                <div class="ui-grid-a ui-responsive" id="div_filter1">
                    <div class="ui-block-a" style="padding-left:10px; padding-right:10px"> 
                        <fieldset data-role="controlgroup" data-type="horizontal">
                            <legend>ความน่าจะเป็น:</legend>
                            <%For i As Integer = 0 To cls.ds.Tables("PROB_DATA").Rows.Count - 1 %>
                                <%Response.Write("<input onclick='calculate_this()' type=""checkbox"" id=""rdo_prob_" & cls.ds.Tables("PROB_DATA").Rows(i).Item("ORDERPROB_ID").ToString() & """ value=""" & cls.ds.Tables("PROB_DATA").Rows(i).Item("ORDERPROB_ID").ToString() & """ class=""rdo_prob"" data-mini='true' >") %>
                                <%Response.Write("<label for=""rdo_prob_" & cls.ds.Tables("PROB_DATA").Rows(i).Item("ORDERPROB_ID").ToString() & """>" & cls.ds.Tables("PROB_DATA").Rows(i).Item("ORDERPROB_NAME").ToString().Substring(0, 3) & "</label>") %>
                            <%Next%>
                        </fieldset>
                    </div>
                    <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                        <fieldset data-role="controlgroup" data-type="horizontal">
                            <legend>ปี:</legend>
                            <%For i As Integer = Date.Now.Year - 2 To Date.Now.Year + 1 %>
                                <%Dim tmp_ As String = "" %>
                                <%If i = Date.Now.Year Then tmp_ = "checked = 'checked' "%>
                                <%Response.Write("<input onclick='calculate_this()' type=""radio"" id=""rdo_year_" & (i + 543) & """ name='rdo_year' value=""" & (i + 543) & """ class=""rdo_year"" data-mini='true' " & tmp_ & ">") %>
                                <%Response.Write("<label for=""rdo_year_" & (i + 543) & """>" & (i + 543) & "</label>") %>
                            <%Next%>
                        </fieldset>
                    </div>
                </div>
                <%--<div class="ui-grid-solo ui-responsive" id="div_filter2">
                    <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <fieldset data-role="controlgroup" data-type="horizontal">
                        <legend>เดือน:</legend>
                        <%For i As Integer = 1 To 12 %>
                            <%Response.Write("<input type=""checkbox"" id=""rdo_month_" & i & """ class=""rdo_month"" data-mini='true' checked='checked'>") %>
                            <%Response.Write("<label for=""rdo_month_" & i & """>" & i & "</label>") %>
                        <%Next%>
                    </fieldset>
                    </div>
                </div>--%>
                
                <div style="width: 100%; overflow-x:auto!important;">
                    <input type="text" id="myInput" onkeyup="myFunction()" placeholder="พิมพ์เพื่อค้นหา" />
                    <table id="tb_list"  class="table table-bordered table-striped table_list">
                    <thead>
                        <tr  class="header">
                                <th>พนักงาน</th>
                                <th>เดือน 0</th>
                                <th>เดือน 1</th>
                                <th>เดือน 2</th>
                                <th>เดือน 3</th>
                                <th>เดือน 4</th>
                                <th>เดือน 5</th>
                                <th>เดือน 6</th>
                                <th>เดือน 7</th>
                                <th>เดือน 8</th>
                                <th>เดือน 9</th>
                                <th>เดือน 10</th>
                                <th>เดือน 11</th>
                                <th>เดือน 12</th>
                                <th>รวม</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                </div>
            </div>                
		</div><!-- /content -->
        
		<div data-role="footer" data-position="fixed" style="background-color:#f1f1f3!important;vertical-align:middle;color:darkslategrey;border:none;">
			<div class="ui-grid-c center">
				<div class="ui-block-a"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-b"><div style="background-color:#43bf79!important;font-size:5px; display:none;  ">&nbsp;</div></div>
				<div class="ui-block-c"><div style="background-color:#43bf79!important;font-size:5px;">&nbsp;</div></div>
				<div class="ui-block-d"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>

				<div class="ui-block-a" style="min-height:50px;bottom:0;"><a href="sale01.aspx#page_main" rel="external"><img src="../RESOURCE/themes/images/set02/049-home.png" style="margin-top: 5px!important; width:35px;"  /></a></div>
				<div class="ui-block-b" style="min-height:50px;margin:auto;"><a href="sale01.aspx#page_detail" onclick="clear_form()" rel="external"><img src="../RESOURCE/themes/images/set02/022-copy.png" style="margin-top: 5px!important; width:35px; "/></a></div>
				<div class="ui-block-c" style="min-height:50px;margin:auto;"><a href="view_bm.aspx" rel="external" ><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:35px;" /></a></div>
				<div class="ui-block-d" style="min-height:50px;margin:auto;"><a href="log_out.aspx" onclick="log_out()" rel="external"><img src="../RESOURCE/themes/images/set02/061-outside.png" style="margin-top: 5px!important; width:35px;" /></a></div>
                
				<div class="ui-block-a" style="font-size:0.7em;" >หน้าหลัก</div>
				<div class="ui-block-b" style="font-size:0.7em;" >เพิ่ม/แก้ไขรายการ</div>
				<div class="ui-block-c" style="font-size:0.7em;" >Dashboard(BM)</div>
				<div class="ui-block-d" style="font-size:0.7em;" >Logout</div>

				<div class="ui-block-a" ><div>&nbsp;</div></div>
				<div class="ui-block-b" ><div>&nbsp;</div></div>
				<div class="ui-block-c" ><div>&nbsp;</div></div>
				<div class="ui-block-d" ><div>&nbsp;</div></div>
			</div>
		</div><!-- /footer -->

	</div><!-- /page -->

</body>
<script src="../JS/sys02.view_am.js"></script>
    </html>
<%-- $.mobile.silentScroll($('#wopwop').get(0).offsetTop);    --%>
