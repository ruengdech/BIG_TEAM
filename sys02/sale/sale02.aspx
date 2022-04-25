<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">

    Dim USER_STAFF_ID As String = "" '"314001"
    Dim USER_STAFF_NAME As String = "RUENGDECH LA-ORPONGAISAN"


</script>
<%
    Session("URL") = "../../sys02/sale/sale01.aspx"
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
    'Try
    '    If USER_STAFF_ID <> "314001" Then
    '        Response.End()
    '    End If
    'Catch ex As Exception

    'End Try

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
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script> 
    <script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>     --%>
	<style>
	 .center {
		  margin: auto !important;
		  text-align: center !important;
	 }
	 
     .table_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
          /*overflow: scroll!important; /* Scrollbar are always visible */
          /*overflow: auto!important;   /* Scrollbar is displayed as it's needed */
     }
     .table_list th, .table_list td {
          border: 1px solid #ddd;
          font-size: 0.9em;
          /*padding: 8px;*/
     }
     .table_list tr:nth-child(even) {background-color: #f2f2f2;}
     .table_list tr:hover  {background-color: #ddd;}
     .table_list th {
          padding-top: 1px;
          padding-bottom: 1px;
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
        var HOSPITAL_DATA = [];
    </script>
    <link href="../../css/jquerysctipttop.css" rel="stylesheet" />
    <link href="../RESOURCE/table_filter/Filter.css" rel="stylesheet" />
    <script src="../RESOURCE/table_filter/Filter.jss"></script>

    
</head>
<% 

    clss.strSql = "SELECT CardName FROM OCRD WHERE (CardType = 'C') GROUP BY CardName ORDER BY CardName"
    clss.func_SetDataSet(clss.strSql, "HOSPITAL_DATA")

    Dim CONDITION_ As String = ""
    cls.strSql = "SELECT VIEW_STAFF_ID, VIEW_PRODUCT_UID FROM SYS02_MS_STAFF_PRIVILED WHERE (STAFF_ID = '" & USER_STAFF_ID & ".2')"
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








    cls.strSql = "SELECT UID, convert(varchar, SALE_DATE, 23) as SALE_DATE, SALE_HOSPITAL, SALE_DEPARTMENT, SALE_PRODUCT_ID, SALE_PRODUCT_MODEL_NAME, PRODUCT_NAME, BRAND_NAME, SALE_UNIT_PRICE, SALE_QTY, SALE_TOTAL_PRICE, SALE_CUSTSTATE_ID, CUSTSTATE_NAME, SALE_ORDERSTATE_ID, ORDERSTATE_NAME, SALE_ESTIMATE_IN, SALE_STAFF_ID, SALE_STAFF_AM_ID, SALE_STAFF_BM_ID, SALE_STAFF_SUP_ID, SALE_ORDER_TYPE, ORDERTYPE_NAME, SALE_ORDER_YEAR, SALE_ORDER_MONTH, SALE_PROB_ID, ORDERPROB_NAME, SALE_BUDGET_ID, BUDGETTYPE_NAME, STAFF_ID, STAFF_NAME, BM_ID, BM_NAME, AM_ID, AM_NAME, SALE_REMARK, SALE_CWHEN, SALE_MWHEN, SALE_CNAME, SALE_MNAME,BRAND_ID FROM SYS02_VIEW_TS_SALE WHERE SALE_STATUS = 'ACTIVE' " & CONDITION_ & " ORDER BY SALE_MWHEN DESC,  UID DESC"
    cls.func_SetDataSet(cls.strSql, "JOB_DATA")
    '0	UID	
    '1	SALE_DATE	วันที่ยื่นซอง
    '2	SALE_HOSPITAL	โรงพยาบาล
    '3	SALE_DEPARTMENT	หน่วยงาน
    '4	SALE_PRODUCT_ID	
    '5	SALE_PRODUCT_MODEL_NAME	โมเดล
    '6	PRODUCT_NAME	สินค้า
    '7	BRAND_NAME	แบรนด์
    '8	SALE_UNIT_PRICE	ราคา/หน่วย
    '9	SALE_QTY	จำนวน
    '10	SALE_TOTAL_PRICE	ราคารวม Vat
    '11	SALE_CUSTSTATE_ID	
    '12	CUSTSTATE_NAME	สถานะลูกค้า
    '13	SALE_ORDERSTATE_ID	
    '14	ORDERSTATE_NAME	สถานะสินค้า
    '15	SALE_ESTIMATE_IN	คาดการณ์สินค้าเข้า
    '16	SALE_STAFF_ID	
    '17	SALE_STAFF_AM_ID	
    '18	SALE_STAFF_BM_ID	
    '19	SALE_STAFF_SUP_ID	
    '20	SALE_ORDER_TYPE	
    '21	ORDERTYPE_NAME	B2
    '22	SALE_ORDER_YEAR	ปี
    '23	SALE_ORDER_MONTH	เดือน
    '24	SALE_PROB_ID	
    '25	ORDERPROB_NAME	ความน่าจะเป็น
    '26	SALE_BUDGET_ID	
    '27	BUDGETTYPE_NAME	ประเภทงบ
    '28	STAFF_ID	
    '29	STAFF_NAME	พนักงานขาย
    '30	BM_ID	
    '31	BM_NAME	BM
    '32	AM_ID	
    '33	AM_NAME	AM
    '34	SALE_REMARK	หมายเหตุ
    '35	SALE_CWHEN	
    '36	SALE_MWHEN	
    '37	SALE_CNAME	
    '38	SALE_MNAME	
    '39	BRAND_ID


    cls.strSql = "SELECT STAFF_ID, STAFF_NAME + ' ' + STAFF_LNAME as STAFF_NAME , STAFF_STATUS FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%AREAMANAGER%') ORDER BY  STAFF_NAME "
    cls.func_SetDataSet(cls.strSql, "AM_DATA")

    cls.strSql = "SELECT STAFF_ID, STAFF_NAME + ' ' + STAFF_LNAME as STAFF_NAME, STAFF_STATUS FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%BRANDMANAGER%') ORDER BY  STAFF_NAME "
    cls.func_SetDataSet(cls.strSql, "BM_DATA")
    For i As Integer = 0 To cls.ds.Tables("BM_DATA").Rows.Count - 1
        With cls.ds.Tables("BM_DATA").Rows(i)
%>
    <script>
        BM_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>"]);
    </script>
<%
        End With
    Next

    cls.strSql = "SELECT STAFF_ID, STAFF_NAME + ' ' + STAFF_LNAME as STAFF_NAME, STAFF_STATUS FROM SYS01_MS_STAFF ORDER BY  STAFF_NAME "
    cls.func_SetDataSet(cls.strSql, "STAFF_DATA")
    For i As Integer = 0 To cls.ds.Tables("STAFF_DATA").Rows.Count - 1
        With cls.ds.Tables("STAFF_DATA").Rows(i)
%>
    <script>
        STAFF_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>"]);
    </script>
<%
                End With
            Next

            cls.strSql = "SELECT BRAND_ID, BRAND_NAME, BRAND_STATUS FROM SYS02_MS_BRAND WHERE BRAND_STATUS = 'ACTIVE' ORDER BY BRAND_NAME "
            cls.func_SetDataSet(cls.strSql, "BRAND_DATA")

            cls.strSql = "SELECT BUDGETTYPE_ID, BUDGETTYPE_NAME, BUDGETTYPE_STATUS FROM SYS02_MS_BUDGET_TYPE WHERE BUDGETTYPE_STATUS = 'ACTIVE' ORDER BY BUDGETTYPE_NAME "
            cls.func_SetDataSet(cls.strSql, "BUDGET_DATA")

            cls.strSql = "SELECT CUSTSTATE_ID, CUSTSTATE_NAME, CUSTSTATE_STATUS FROM SYS02_MS_CUSTOMER_STATE WHERE CUSTSTATE_STATUS = 'ACTIVE' ORDER BY CUSTSTATE_NAME "
            cls.func_SetDataSet(cls.strSql, "CUSTSTATE_DATA")

            cls.strSql = "SELECT ORDERPROB_ID, ORDERPROB_NAME, ORDERPROB_STATUS FROM SYS02_MS_ORDER_PROB WHERE ORDERPROB_STATUS = 'ACTIVE' ORDER BY ORDERPROB_NAME "
            cls.func_SetDataSet(cls.strSql, "PROB_DATA")

            cls.strSql = "SELECT ORDERSTATE_ID, ORDERSTATE_NAME, ORDERSTATE_STATUS FROM SYS02_MS_ORDER_STATE WHERE ORDERSTATE_STATUS = 'ACTIVE' ORDER BY ORDERSTATE_NAME "
            cls.func_SetDataSet(cls.strSql, "ORDERSTATE_DATA")

            cls.strSql = "SELECT ORDERTYPE_ID, ORDERTYPE_NAME, ORDERTYPE_STATUS FROM SYS02_MS_ORDER_TYPE WHERE ORDERTYPE_STATUS = 'ACTIVE' ORDER BY ORDERTYPE_NAME "
            cls.func_SetDataSet(cls.strSql, "ORDERTYPE_DATA")

            cls.strSql = "SELECT PRODUCT_ID, PRODUCT_BRAND_ID, PRODUCT_NAME, PRODUCT_STATUS, PRODUCT_STAFF_ID FROM SYS02_MS_PRODUCT WHERE PRODUCT_STATUS = 'ACTIVE' ORDER BY PRODUCT_NAME "
            cls.func_SetDataSet(cls.strSql, "PRODUCT_DATA")
            For i As Integer = 0 To cls.ds.Tables("PRODUCT_DATA").Rows.Count - 1
                With cls.ds.Tables("PRODUCT_DATA").Rows(i)
%>
    <script>
        PRODUCT_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>", "<%response.Write(.Item(3).ToString)%>", "<%response.Write(.Item(4).ToString)%>"]);
    </script>
<%
        End With
    Next

    cls.strSql = "SELECT MODEL_ID, MODEL_PRODUCT_ID, MODEL_NAME, MODEL_STATUS FROM SYS02_MS_PRODUCT_MODEL ORDER BY MODEL_NAME "
    cls.func_SetDataSet(cls.strSql, "MODEL_DATA")
    For i As Integer = 0 To cls.ds.Tables("MODEL_DATA").Rows.Count - 1
        With cls.ds.Tables("MODEL_DATA").Rows(i)
%>
    <script>
        MODEL_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>", "<%response.Write(.Item(3).ToString)%>"]);
    </script>
<%
        End With
    Next

%>
<body>
	<div data-role="page" id="page_main">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[Data] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
            <div class="ui-bar ui-bar-a center">
                <h3>รายการขาย <a style="color:white;" href="sale01.aspx"  target='_blank' rel='external'>สิทธิ์ทีมขาย</a> | สิทธิ์การตลาด</h3>
            </div>

            <div class="container">   
                <div class="row">
                    <div class="panel panel-primary filterable">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <button class="ui-mini btn-filter">ใช้ Filter (กรอกและกด Enter)</button>
                            </h3>
                        </div>
                        <p>No.of Rows : <span id="rowcount"></span></p>
                        <p>Sum Total(Inc Vat) : <span id="sum_amout"></span> <br / >Export Excel : <a href="export.aspx" target="_blank">Download</a></p>
                        <div style="width: 100%; overflow-x:auto!important;">
                        <table id="tb_list"  class="table table-bordered table-striped table_list">
                            <thead>
                            <tr class="filters">
                                <th><input id="s_date" type="text" class="form-control" placeholder="วันที่ยื่นซอง"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_hospital" type="text" class="form-control" placeholder="โรงพยาบาล" onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_brand" type="text" class="form-control" placeholder="แบรนด์" onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_product" type="text" class="form-control" placeholder="สินค้า | โมเดล" onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_price" type="text" class="form-control" placeholder="ราคา/หน่วย"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_qty" type="text" class="form-control" placeholder="จำนวน"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_total" type="text" class="form-control" placeholder="ราคารวม Vat"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_status" type="text" class="form-control" placeholder="สถานะ"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_productin" type="text" class="form-control" placeholder="คาดการณ์สินค้าเข้า"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_month" type="text" class="form-control" placeholder="ปี / เดือน"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_prob" type="text" class="form-control" placeholder="ความน่าจะเป็น"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_budget" type="text" class="form-control" placeholder="ประเภทงบ"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_sale" type="text" class="form-control" placeholder="พนักงานขาย"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_am" type="text" class="form-control" placeholder="AM"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_bm" type="text" class="form-control" placeholder="BM"onkeyup = "check_filter(event)"  /></th>
                                <th><input id="s_remark" type="text" class="form-control" placeholder="หมายเหตุ" /></th>
                                <th><input id="s_mdate" type="text" class="form-control" placeholder="แก้ไขล่าสุด" /></th>
                            </tr>
                            </thead>
                            <tbody>
							        <% 
                                        If cls.ds.Tables("JOB_DATA").Rows.Count > 0 Then
                                            For i As Integer = 0 To cls.ds.Tables("JOB_DATA").Rows.Count - 1
                                                With cls.ds.Tables("JOB_DATA").Rows(i)
                                                    'Response.Write("<tr>")

                                                    'Response.Write("<td><a id='row_'" & .Item("UID").ToString() & "></a>" & .Item("SALE_DATE").ToString() & "</td>")

                                                    'Response.Write("<td onclick = ""set_detail('" & .Item("UID").ToString() & "')""><a href='#page_detail'>" & .Item("SALE_HOSPITAL").ToString())
                                                    'If .Item("SALE_DEPARTMENT").ToString().Length > 1 Then
                                                    '    Response.Write("<br />" & .Item("SALE_DEPARTMENT").ToString() & "</a></td>")
                                                    'Else
                                                    '    Response.Write("</td>")
                                                    'End If

                                                    'Response.Write("<td>" & .Item("BRAND_NAME").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("PRODUCT_NAME").ToString() & " | ")
                                                    'Response.Write(.Item("SALE_PRODUCT_MODEL_NAME").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("SALE_UNIT_PRICE").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("SALE_QTY").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("SALE_TOTAL_PRICE").ToString() & "</td>")

                                                    'Response.Write("<td> ลูกค้า : " & .Item("CUSTSTATE_NAME").ToString() & "<br />")
                                                    'Response.Write(" สินค้า : " & .Item("ORDERSTATE_NAME").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("SALE_ESTIMATE_IN").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("SALE_ORDER_YEAR").ToString() & " / ")
                                                    'Response.Write(.Item("SALE_ORDER_MONTH").ToString() & "</td>")

                                                    'Response.Write("<td>" & .Item("ORDERPROB_NAME").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("BUDGETTYPE_NAME").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("STAFF_NAME").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("AM_NAME").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("BM_NAME").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("SALE_REMARK").ToString() & "</td>")
                                                    'Response.Write("<td>" & .Item("SALE_MNAME").ToString() & "<br />" & .Item("SALE_MWHEN").ToString() & "</td>")

                                                    'Response.Write("</tr>")
                                                    ''1	SALE_DATE	วันที่ยื่นซอง
                                                    ''2	SALE_HOSPITAL	โรงพยาบาล
                                                    ''3	SALE_DEPARTMENT	หน่วยงาน
                                                    ''5	SALE_PRODUCT_MODEL_NAME	โมเดล
                                                    ''6	PRODUCT_NAME	สินค้า
                                                    ''7	BRAND_NAME	แบรนด์
                                                    ''8	SALE_UNIT_PRICE	ราคา/หน่วย
                                                    ''9	SALE_QTY	จำนวน
                                                    ''10	SALE_TOTAL_PRICE	ราคารวม Vat
                                                    ''12	CUSTSTATE_NAME	สถานะลูกค้า
                                                    ''14	ORDERSTATE_NAME	สถานะสินค้า
                                                    ''15	SALE_ESTIMATE_IN	คาดการณ์สินค้าเข้า
                                                    ''21	ORDERTYPE_NAME	B2
                                                    ''22	SALE_ORDER_YEAR	ปี
                                                    ''23	SALE_ORDER_MONTH	เดือน
                                                    ''25	ORDERPROB_NAME	ความน่าจะเป็น
                                                    ''27	BUDGETTYPE_NAME	ประเภทงบ
                                                    ''29	STAFF_NAME	พนักงานขาย
                                                    ''31	BM_NAME	BM
                                                    ''33	AM_NAME	AM
                                                    ''34	SALE_REMARK	หมายเหต

											        %>
                                                    <script>
                                                        JOB_DATA.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>", "<%response.Write(.Item(3).ToString)%>", "<%response.Write(.Item(4).ToString)%>", "<%response.Write(.Item(5).ToString)%>", "<%response.Write(.Item(6).ToString)%>", "<%response.Write(.Item(7).ToString)%>", "<%response.Write(.Item(8).ToString)%>", "<%response.Write(.Item(9).ToString)%>", "<%response.Write(.Item(10).ToString)%>", "<%response.Write(.Item(11).ToString)%>", "<%response.Write(.Item(12).ToString)%>", "<%response.Write(.Item(13).ToString)%>", "<%response.Write(.Item(14).ToString)%>", "<%response.Write(.Item(15).ToString)%>", "<%response.Write(.Item(16).ToString)%>", "<%response.Write(.Item(17).ToString)%>", "<%response.Write(.Item(18).ToString)%>", "<%response.Write(.Item(19).ToString)%>", "<%response.Write(.Item(20).ToString)%>", "<%response.Write(.Item(21).ToString)%>", "<%response.Write(.Item(22).ToString)%>", "<%response.Write(.Item(23).ToString)%>", "<%response.Write(.Item(24).ToString)%>", "<%response.Write(.Item(25).ToString)%>", "<%response.Write(.Item(26).ToString)%>", "<%response.Write(.Item(27).ToString)%>", "<%response.Write(.Item(28).ToString)%>", "<%response.Write(.Item(29).ToString)%>", "<%response.Write(.Item(30).ToString)%>", "<%response.Write(.Item(31).ToString)%>", "<%response.Write(.Item(32).ToString)%>", "<%response.Write(.Item(33).ToString)%>", "<%response.Write(.Item(34).ToString)%>", "<%response.Write(.Item(35).ToString)%>", "<%response.Write(.Item(36).ToString)%>", "<%response.Write(.Item(37).ToString)%>", "<%response.Write(.Item(38).ToString)%>", "<%response.Write(.Item(39).ToString)%>"]);
                                                    </script>
											        <%
                                                                End With
                                                            Next
                                                        End If
											        %>
			                </tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
                
		</div><!-- /content -->
        
		<div data-role="footer" data-position="fixed" style="background-color:#f1f1f3!important;vertical-align:middle;color:darkslategrey;border:none;">
			<div class="ui-grid-d center">
				<div class="ui-block-a"><div style="background-color:#43bf79!important;font-size:5px;">&nbsp;</div></div>
				<div class="ui-block-b"><div style="background-color:#43bf79!important;font-size:5px; display:none;  ">&nbsp;</div></div>
				<div class="ui-block-c"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-d"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-e"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>

				<div class="ui-block-a" style="min-height:50px;bottom:0;"><a href="#page_main" rel="external"><img src="../RESOURCE/themes/images/set02/049-home.png" style="margin-top: 5px!important; width:35px;"  /></a></div>
				<div class="ui-block-b" style="min-height:50px;margin:auto;"><a href="#page_detail" onclick="clear_form()" rel="external"><img src="../RESOURCE/themes/images/set02/022-copy.png" style="margin-top: 5px!important; width:35px; "/></a></div>
				<div class="ui-block-c" style="min-height:50px;margin:auto;"><a href="view_am.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:30px;" /></a> | <a href="view_bm.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:30px;" /></a></div>
				<div class="ui-block-d" style="min-height:50px;margin:auto;"><a href="list_approve.aspx" target="_blank" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:35px;" /></a></div>
				<div class="ui-block-e" style="min-height:50px;margin:auto;"><a href="log_out.aspx" onclick="log_out()" rel="external"><img src="../RESOURCE/themes/images/set02/061-outside.png" style="margin-top: 5px!important; width:35px;" /></a></div>
                
				<div class="ui-block-a" style="font-size:0.7em;" >หน้าหลัก</div>
				<div class="ui-block-b" style="font-size:0.7em;" >เพิ่ม/แก้ไขรายการ</div>
				<div class="ui-block-c" style="font-size:0.7em;" >Dashboard(AM | BM)</div>
				<div class="ui-block-d" style="font-size:0.7em;" >ขออนุมัติโครงการ</div>
				<div class="ui-block-e" style="font-size:0.7em;" >Logout</div>

				<div class="ui-block-a" ><div>&nbsp;</div></div>
				<div class="ui-block-b" ><div>&nbsp;</div></div>
				<div class="ui-block-c" ><div>&nbsp;</div></div>
				<div class="ui-block-d" ><div>&nbsp;</div></div>
				<div class="ui-block-e" ><div>&nbsp;</div></div>
			</div>
		</div><!-- /footer -->

	</div><!-- /page -->

    
	<div data-role="page" id="page_detail">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[Data] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
            <div class="ui-bar ui-bar-a center">
                <h3>เพิ่ม/แก้ไขรายการขาย</h3>
            </div>
            
	        <div class="ui-grid-b ui-responsive">
                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_date">วันที่ยื่นซอง:</label>
                    <input type="date" id="txt_sale_date" value="" />
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_hospital">โรงพยาบาล:</label>
                    <%--<input type="text" id="txt_sale_hospital" value="" />--%>
                    <div class="autocomplete" >
                        <input id="txt_sale_hospital" type="text" name="txt_sale_hospital" placeholder="Hospital" />
                    </div>
                    <%--<input data-type="search" id="txt_sale_hospital" value="" />
                    <ul data-role="listview" data-filter="true" data-filter-reveal="true" data-input="#txt_sale_hospital">
                        <%
                            For i = 0 To clss.ds.Tables("HOSPITAL_DATA").Rows.Count - 1
                                Response.Write("<li><a href='#' onclick='sel_hospital_data(""" & clss.ds.Tables("HOSPITAL_DATA").Rows(i).Item(0).ToString & """)'>" & clss.ds.Tables("HOSPITAL_DATA").Rows(i).Item(0).ToString & "</a></li>")
                            Next
                        %>
                    </ul>--%>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_department">หน่วยงาน:</label>
                    <input type="text" id="txt_sale_department" value="" />
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <label for="sel_brand_name">แบรนด์:</label>
                    <select  id="sel_brand_name">
                        <option value="">เลือก Brand</option>
                        <%
                For i As Integer = 0 To cls.ds.Tables("BRAND_DATA").Rows.Count - 1
                    With cls.ds.Tables("BRAND_DATA").Rows(i)
                        Response.Write("<option value='" & .Item("BRAND_ID").ToString & "'>" & .Item("BRAND_NAME").ToString & "</option>")
                    End With
                Next
                        %>
                    </select>
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                    <label for="sel_product_name">สินค้า:</label>
                    <select id="sel_product_name">                        
                        <option value="">เลือก สินค้า</option>
                    </select>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_product_model_name">โมเดล:</label>
                     <input type="text" id="txt_sale_product_model_name" value="" />
                    <%--<select id="sel_sale_product_model_name">
                        <option value="">เลือก MODEL</option>
                    </select>--%>
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_unit_price">ราคา/หน่วย:</label>
                    <input type="text" id="txt_sale_unit_price" value="" />
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_qty">จำนวน:</label>
                    <input type="text" id="txt_sale_qty" value="" />
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_total_price">ราคารวม vat:</label>
                    <input type="text" id="txt_sale_total_price" value="" />
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <label for="sel_custstate_name">สถานะลูกค้า:</label>
                    <select id="sel_custstate_name">
                        <option value="">เลือก สถานะลูกค้า</option>
                        <%
                            For i As Integer = 0 To cls.ds.Tables("CUSTSTATE_DATA").Rows.Count - 1
                                With cls.ds.Tables("CUSTSTATE_DATA").Rows(i)
                                    Response.Write("<option value='" & .Item("CUSTSTATE_ID").ToString & "'>" & .Item("CUSTSTATE_NAME").ToString & "</option>")
                                End With
                            Next
                        %>
                    </select>
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                    <label for="sel_orderstate_name">สถานะสินค้า:</label>
                    <select id="sel_orderstate_name">
                        <option value="">เลือก สถานะสินค้า</option>
                        <%
                            For i As Integer = 0 To cls.ds.Tables("ORDERSTATE_DATA").Rows.Count - 1
                                With cls.ds.Tables("ORDERSTATE_DATA").Rows(i)
                                    Response.Write("<option value='" & .Item("ORDERSTATE_ID").ToString & "'>" & .Item("ORDERSTATE_NAME").ToString & "</option>")
                                End With
                            Next
                        %>
                    </select>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
                    <label for="txt_sale_estimate_in">คาดการณ์สินค้าเข้า:</label>
                    <input type="text"  id="txt_sale_estimate_in" />
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
                    <label for="sel_ordertype_name">b2:</label>
                    <select id="sel_ordertype_name">
                        <option value="">เลือก ประเภท</option>
                        <%
                            For i As Integer = 0 To cls.ds.Tables("ORDERTYPE_DATA").Rows.Count - 1
                                With cls.ds.Tables("ORDERTYPE_DATA").Rows(i)
                                    Response.Write("<option value='" & .Item("ORDERTYPE_ID").ToString & "'>" & .Item("ORDERTYPE_NAME").ToString & "</option>")
                                End With
                            Next
                        %>
                    </select>
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
                    <label for="sel_sale_order_year">ปี:</label>
                    <select id="sel_sale_order_year">
                        <option value="">เลือก ประเภท</option>
                        <%
                            Dim this_year As Integer = Date.Now.Year
                            If this_year < 2560 Then this_year += 543
                            For i As Integer = 2563 To this_year + 2
                                If i = this_year Then
                                    Response.Write("<option value='" & i & "' selected ='selected' >" & i & "</option>")
                                Else
                                    Response.Write("<option value='" & i & "' >" & i & "</option>")
                                End If
                            Next
                        %>
                    </select>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
					<label for="sel_sale_order_month">เดือน:</label>
					<select id="sel_sale_order_month">
                        <%
                Dim this_month As Integer = Date.Now.Month
                For i As Integer = 0 To 12
                    If i = this_month Then
                        Response.Write("<option value='" & i & "' selected ='selected' >" & i & "</option>")
                    Else
                        Response.Write("<option value='" & i & "' >" & i & "</option>")
                    End If
                Next
                        %>
					</select>
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
					<label for="sel_orderprob_name">ความน่าจะเป็น:</label>
					<select id="sel_orderprob_name">
                        <option value="">เลือก ประเภท</option>
                        <%
                For i As Integer = 0 To cls.ds.Tables("PROB_DATA").Rows.Count - 1
                    With cls.ds.Tables("PROB_DATA").Rows(i)
                        Response.Write("<option value='" & .Item("ORDERPROB_ID").ToString & "'>" & .Item("ORDERPROB_NAME").ToString & "</option>")
                    End With
                Next
                        %>
					</select>
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
					<label for="sel_budgettype_name">ประเภทงบ:</label>
					<select id="sel_budgettype_name">
                        <option value="">เลือก งบประมาณ</option>
                        <%
                            For i As Integer = 0 To cls.ds.Tables("BUDGET_DATA").Rows.Count - 1
                                With cls.ds.Tables("BUDGET_DATA").Rows(i)
                                    Response.Write("<option value='" & .Item("BUDGETTYPE_ID").ToString & "'>" & .Item("BUDGETTYPE_NAME").ToString & "</option>")
                                End With
                            Next
                        %>
					</select>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
					<label for="txt_staff_name">พนักงานขาย:</label>
					<input type="text" id="txt_staff_id" value="" />
					<input type="text" id="txt_staff_name" value="" />
                </div>

                <div class="ui-block-a" style="padding-left:10px; padding-right:10px">
					<label for="txt_bm_name">BM:</label>
					<input type="text" id="txt_bm_name" readonly="readonly" />
                </div>
                <div class="ui-block-b" style="padding-left:10px; padding-right:10px">
					<label for="sel_am_name">AM:</label>
					<select id="sel_am_name">
                        <option value="">เลือก AM</option>
                        <%
                            For i As Integer = 0 To cls.ds.Tables("AM_DATA").Rows.Count - 1
                                With cls.ds.Tables("AM_DATA").Rows(i)
                                    Response.Write("<option value='" & .Item("STAFF_ID").ToString & "'>" & .Item("STAFF_NAME").ToString & "</option>")
                                End With
                            Next
                        %>
					</select>
                </div>
                <div class="ui-block-c" style="padding-left:10px; padding-right:10px">
					<label for="txt_sale_remark">หมายเหตุ:</label>
					<input type="text" id="txt_sale_remark" value="" />
                </div>

	        </div>
	        <div class="ui-grid-solo ui-responsive">
				<input type="text" id="txt_sale_id" style="display:none;"/>
				<input type="text" id="txt_user_name" style="display:none;" value="<%Response.Write(USER_STAFF_NAME)%>"/>
				<input type="text" id="txt_staff_uid" style="display:none;" value="<%Response.Write(USER_STAFF_ID)%>"/>
				<input type="text" id="txt_bm_id" style="display:none;"/>
                <div class="ui-grid-b" style="padding-left:10px; padding-right:10px">
                        <div class="ui-block-a">
	                        <input type="button" class="ui-btn ui-btn-active ui-btn-a" value="บันทึกข้อมูล" name="bt_save" id="bt_save" />
                        </div>
                        <div class="ui-block-b">
	                        <input type="button" class="ui-btn ui-btn-active ui-btn-b" value="ยกเลิก" name="bt_clear" id="bt_clear" />
                        </div>
                        <div class="ui-block-c">
	                        <input type="button" class="ui-btn ui-btn-active ui-btn-c" value="ลบข้อมูล" name="bt_delete" id="bt_delete" />
                        </div>
                </div>
            </div>
            
		</div><!-- /content -->
        
		<div data-role="footer" data-position="fixed" style="background-color:#f1f1f3!important;vertical-align:middle;color:darkslategrey;border:none;">
			<div class="ui-grid-d center">
				<div class="ui-block-a"><div style="background-color:#43bf79!important;font-size:5px; display:none;  ">&nbsp;</div></div>
				<div class="ui-block-b"><div style="background-color:#43bf79!important;font-size:5px;">&nbsp;</div></div>
				<div class="ui-block-c"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-d"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-e"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
                				
				<div class="ui-block-a" style="min-height:50px;bottom:0;"><a href="#page_main" rel="external"><img src="../RESOURCE/themes/images/set02/049-home.png" style="margin-top: 5px!important; width:35px;"  /></a></div>
				<div class="ui-block-b" style="min-height:50px;margin:auto;"><a href="#page_detail" onclick="clear_form()" rel="external"><img src="../RESOURCE/themes/images/set02/022-copy.png" style="margin-top: 5px!important; width:35px; "/></a></div>
				<div class="ui-block-c" style="min-height:50px;margin:auto;"><a href="view_am.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:30px;" /></a> | <a href="view_bm.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:30px;" /></a></div>
				<div class="ui-block-d" style="min-height:50px;margin:auto;"><a href="list_approve.aspx" target="_blank" rel="external"><img src="../RESOURCE/themes/images/set02/024-dashboard.png" style="margin-top: 5px!important; width:35px;" /></a></div>
				<div class="ui-block-e" style="min-height:50px;margin:auto;"><a href="log_out.aspx" onclick="log_out()" rel="external"><img src="../RESOURCE/themes/images/set02/061-outside.png" style="margin-top: 5px!important; width:35px;" /></a></div>
                
				<div class="ui-block-a" style="font-size:0.7em;" >หน้าหลัก</div>
				<div class="ui-block-b" style="font-size:0.7em;" >เพิ่ม/แก้ไขรายการ</div>
				<div class="ui-block-c" style="font-size:0.7em;" >Dashboard(AM | BM)</div>
				<div class="ui-block-d" style="font-size:0.7em;" >ขออนุมัติโครงการ</div>
				<div class="ui-block-e" style="font-size:0.7em;" >Logout</div>

				<div class="ui-block-a" ><div>&nbsp;</div></div>
				<div class="ui-block-b" ><div>&nbsp;</div></div>
				<div class="ui-block-c" ><div>&nbsp;</div></div>
				<div class="ui-block-d" ><div>&nbsp;</div></div>
				<div class="ui-block-e" ><div>&nbsp;</div></div>
			</div>
		</div><!-- /footer -->

	</div><!-- /page -->



    
	<div data-role="page" id="log_out.aspx">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[Data] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
            <div class="ui-bar ui-bar-a center">
                <h3>Thank you</h3>
            </div>

            
		</div><!-- /content -->        

	</div><!-- /page -->
<script>
    function autocomplete(inp, arr) {
        /*the autocomplete function takes two arguments,
        the text field element and an array of possible autocompleted values:*/
        var currentFocus;
        /*execute a function when someone writes in the text field:*/
        inp.addEventListener("input", function (e) {
            var a, b, i, val = this.value;
            /*close any already open lists of autocompleted values*/
            closeAllLists();
            if (!val) { return false; }
            currentFocus = -1;
            /*create a DIV element that will contain the items (values):*/
            a = document.createElement("DIV");
            a.setAttribute("id", this.id + "autocomplete-list");
            a.setAttribute("class", "autocomplete-items");
            /*append the DIV element as a child of the autocomplete container:*/
            this.parentNode.appendChild(a);
            /*for each item in the array...*/
            for (i = 0; i < arr.length; i++) {
                /*check if the item starts with the same letters as the text field value:*/
                if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                    /*create a DIV element for each matching element:*/
                    b = document.createElement("DIV");
                    /*make the matching letters bold:*/
                    b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                    b.innerHTML += arr[i].substr(val.length);
                    /*insert a input field that will hold the current array item's value:*/
                    b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                    /*execute a function when someone clicks on the item value (DIV element):*/
                    b.addEventListener("click", function (e) {
                        /*insert the value for the autocomplete text field:*/
                        inp.value = this.getElementsByTagName("input")[0].value;
                        /*close the list of autocompleted values,
                        (or any other open lists of autocompleted values:*/
                        closeAllLists();
                    });
                    a.appendChild(b);
                }
            }
        });
        /*execute a function presses a key on the keyboard:*/
        inp.addEventListener("keydown", function (e) {
            var x = document.getElementById(this.id + "autocomplete-list");
            if (x) x = x.getElementsByTagName("div");
            if (e.keyCode == 40) {
                /*If the arrow DOWN key is pressed,
                increase the currentFocus variable:*/
                currentFocus++;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 38) { //up
                /*If the arrow UP key is pressed,
                decrease the currentFocus variable:*/
                currentFocus--;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 13) {
                /*If the ENTER key is pressed, prevent the form from being submitted,*/
                e.preventDefault();
                if (currentFocus > -1) {
                    /*and simulate a click on the "active" item:*/
                    if (x) x[currentFocus].click();
                }
            }
        });
        function addActive(x) {
            /*a function to classify an item as "active":*/
            if (!x) return false;
            /*start by removing the "active" class on all items:*/
            removeActive(x);
            if (currentFocus >= x.length) currentFocus = 0;
            if (currentFocus < 0) currentFocus = (x.length - 1);
            /*add class "autocomplete-active":*/
            x[currentFocus].classList.add("autocomplete-active");
        }
        function removeActive(x) {
            /*a function to remove the "active" class from all autocomplete items:*/
            for (var i = 0; i < x.length; i++) {
                x[i].classList.remove("autocomplete-active");
            }
        }
        function closeAllLists(elmnt) {
            /*close all autocomplete lists in the document,
            except the one passed as an argument:*/
            var x = document.getElementsByClassName("autocomplete-items");
            for (var i = 0; i < x.length; i++) {
                if (elmnt != x[i] && elmnt != inp) {
                    x[i].parentNode.removeChild(x[i]);
                }
            }
        }
        /*execute a function when someone clicks in the document:*/
        document.addEventListener("click", function (e) {
            closeAllLists(e.target);
        });
    }
    <%
    Dim STR_TMP As String = ""
    For i As Integer = 0 To clss.ds.Tables("HOSPITAL_DATA").Rows.Count - 1
        STR_TMP &= """" & clss.ds.Tables("HOSPITAL_DATA").Rows(i).Item(0).ToString & ""","
    Next
    %>
    var countries = [<%=STR_TMP%>];

    /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
    autocomplete(document.getElementById("txt_sale_hospital"), countries);
</script>
</body>
<script src="../JS/sys02.sale01.js"></script>
    </html>
