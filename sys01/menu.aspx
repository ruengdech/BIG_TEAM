<%@ Page Language="VB" %>

<!DOCTYPE html>
<%
    Dim cls As New MY_CLASS
    Session("URL") = "../menu.aspx"
    Try
        If IsNothing(Session("USER_TYPE")) Then
            If Request.QueryString("user_id") <> Nothing Then
                cls.strSql = "SELECT " &
                                "users.ID, users.username, users.pswd, employee2.uid, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
                            "FROM  " &
                                "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                                "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                            "WHERE (((users.ID)=" & Request.QueryString("user_id") & ") );"
                cls.func_SetDataSet(cls.strSql, "LOGIN")
                If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                    With cls.ds.Tables("LOGIN").Rows(0)
                        Session("STAFF_ID") = .Item("uid").ToString
                        Session("USER_ID") = .Item("ID").ToString
                        Session("USER_NAME") = .Item("username").ToString
                        Session("USER_FNAME") = .Item("name").ToString
                        Session("USER_ABR") = .Item("abr").ToString
                        Session("USER_TYPE") = .Item("USER_TYPE").ToString

                        Dim clss As New MY_CLASS_MSSQL
                        clss.strSql = "SELECT STAFF_TYPE FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & Session("STAFF_ID") & ")"
                        clss.func_SetDataSet(clss.strSql, "TYPES")
                        Try
                            Session("USER_CATEGORY") = clss.ds.Tables("TYPES").Rows(0).Item(0).ToString
                        Catch ex As Exception

                        End Try

                    End With
                Else
                    Response.Redirect("authentication/login.aspx")
                End If

            Else
                Response.Redirect("authentication/login.aspx")
            End If
        Else
            'DO NOTHING

            Dim clss As New MY_CLASS_MSSQL
            clss.strSql = "SELECT STAFF_TYPE FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & Session("STAFF_ID") & ")"
            clss.func_SetDataSet(clss.strSql, "TYPES")
            Try
                Session("USER_CATEGORY") = clss.ds.Tables("TYPES").Rows(0).Item(0).ToString
            Catch ex As Exception

            End Try
        End If
    Catch ex As Exception
        Response.Redirect("authentication/login.aspx")
    End Try

    %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</title>
	<link rel="stylesheet" href="themes/ST_MED.css" />
	<link rel="stylesheet" href="themes/jquery.mobile.icons.min.css" />
    <link href="themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="themes/jquery-1.11.1.min.js"></script>
    <script src="themes/jquery.mobile-1.4.5.min.js"></script>
    <link href="../css/w3.css" rel="stylesheet" />
    <script type="text/javascript" >
        var JOB_DATA = [];
        var STAFF_ID = "";
    </script>
    <style>
        #tb_history, .table_job_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
          /*width:900px; */
        }

        #tb_history td, #tb_history th , .table_job_list th, .table_job_list td {
          border: 1px solid #ddd;
          padding: 8px;
        }

        #tb_history tr:nth-child(even), .table_job_list tr:nth-child(even) {background-color: #f2f2f2;}

        #tb_history tr:hover, .table_job_list tr:hover  {background-color: #ddd;}

        #tb_history th, .table_job_list th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
        }

        .center {
            text-align:center !important;
        }

        .textboxAslabel {
            border:none!important;
            background-color:#FFF!important;
            border-color:#FFF!important;
            }
   </style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<style>
    .fa-star {
        color:#ccc;
        font-size:2.5em;
    }
    /* Hover state of the stars */
    .fa-star:hover{
        color:#FFCC36;
    }

    /* Selected state of the stars */
    .fa-star:active  {
      color:#FF912C;
    }

    /* Selected state of the stars */
    .fa-star-active  {
      color:#FF912C;
      font-size:2.5em;
    }
</style>   
<%
    Response.Write("<SCRIPT>")
    Response.Write("STAFF_ID = '" & Session("STAFF_ID") & "';")
    Response.Write("</SCRIPT>")

%> 
</head>
<body>
<div data-role="page" id="page_main" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div id="request" class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h3>MENU FOR ALL</h3>
                        
                    </div>
                    <div class="ui-body ui-body-a">
                        <div class="ui-grid-solo ui-responsive">
                            <a href="index.aspx" rel="external" target="_blank" class="ui-btn-a ui-btn ui-btn-active ">สำหรับผู้ขอรับบริการ</a>
                            <%try
                                    If Session("USER_CATEGORY").ToString().IndexOf("SUPERVISOR") > -1 Then %>
                            <a href="admin/index.aspx" rel="external" target="_blank" class="ui-btn ui-btn-b ui-btn-active ">สำหรับ Admin</a>
                            <a href="dashboard/index.aspx" rel="external" target="_blank" class="ui-btn ui-btn-b ui-btn-active ">Dashboard</a>
                            <a href="dashboard/index_csi.aspx" rel="external" target="_blank" class="ui-btn ui-btn-b ui-btn-active ">รายงาน ปิดงานเทียบ CSI</a>
                            <a href="../sys04/admin_s.aspx" rel="external" target="_blank" class="ui-btn ui-btn-b ui-btn-active ">ข้อมูล CSI</a>
                                <%if  Session("USER_CATEGORY").ToString().IndexOf("MANAGER") > -1 Then %>
                                    <a href="../sys06/admin_perform.aspx" rel="external" target="_blank" class="ui-btn ui-btn-b ui-btn-active ">Staff KPI Performance</a>
                                <%End if %>
                            <%End if %>
                            <%If Session("USER_CATEGORY").ToString().IndexOf("ENGINEER") > -1 Then %>
                            <a href="engineer/index.aspx" rel="external" target="_blank" class="ui-btn ui-btn-c ui-btn-active ">สำหรับ Engineer</a>
                            <%End if
                                catch exx As Exception
                                End Try
                                    %>
                        </div>
                    </div><%--<div class="ui-body ui-body-a">--%>
                </div><%--<div id="request" class="ui-body-d ui-content ui-corner-all">--%>
                
		</div>
</div>




</body>
</html>
