<%@ Page Language="VB" %>

<!DOCTYPE html>
<%
    Dim cls As New MY_CLASS
    Dim clss As New MY_CLASS_MSSQL("RUENGDECH_STMED", "ruengdech", "r4442440044ST")

    Session("URL") = "../../sys07/index.aspx"
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

                        clss.strSql = "SELECT STAFF_TYPE FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & Session("STAFF_ID") & ")"
                        clss.func_SetDataSet(clss.strSql, "TYPES")
                        Try
                            Session("USER_CATEGORY") = clss.ds.Tables("TYPES").Rows(0).Item(0).ToString
                        Catch ex As Exception

                        End Try

                    End With
                Else
                    Response.Redirect("../sys01/authentication/login.aspx")
                End If

            Else
                Response.Redirect("../sys01/authentication/login.aspx")
            End If
        Else
            'DO NOTHING

            ''Dim clss As New MY_CLASS_MSSQL
            clss.strSql = "SELECT STAFF_TYPE FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & Session("STAFF_ID") & ")"
            clss.func_SetDataSet(clss.strSql, "TYPES")
            Try
                Session("USER_CATEGORY") = clss.ds.Tables("TYPES").Rows(0).Item(0).ToString
            Catch ex As Exception

            End Try
        End If
    Catch ex As Exception
        Response.Redirect("../sys01/authentication/login.aspx")
    End Try




    'If Session("USER_CATEGORY").ToString().IndexOf("CUSTOMER") = -1 Or Session("USER_CATEGORY").ToString().IndexOf("MANAGER") = -1 Then
    '    Response.Redirect("../sys01/authentication/login.aspx")
    'End If


%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../sys05/RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="../sys05/RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />
    <link href="../sys01/themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../sys01/themes/jquery-1.11.1.min.js"></script>
	<script src="../sys01/themes/jquery.mobile-1.4.5.js"></script>
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
          font-size: 1em;
          padding: 5px;
     }
     .table_list tr:nth-child(even) {background-color: #f2f2f2;}
     .table_list tr:hover  {background-color: #ddd;}
     .table_list th {
          padding-top: 4px;
          padding-bottom: 4px;
          text-align: left;
          background-color: #0277bd;
          color: white;
     }
     /*.container {margin:150px auto;}*/
	   
	</style>
</head>
<body>
    <div data-role="header" style="background-color:ghostwhite !important;border-color:#43bf79!important;text-shadow:none; color:darkcyan">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >SAINTMED Custmer Register LINE <a href="#" class="ui-btn ui-btn-inline" style="text-align:right!important" onclick="createFile()" id="bt_create_file">เตรียม Download File</a><a href="data.txt" class="ui-btn ui-btn-inline" rel="external" target="_blank" onclick="downloadFile()" id="bt_download_file">Download File</a></p>
            </div>
	</div>
    <div style="width:100%; align-content:center; overflow-x:auto;"> 
        <input id="myInput" style="width:50%!important; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
        <table id="tb_order_list" style="width:100%;" class="table_list">
                    <tr>
                        <th>NO.</th>
                        <th>ชื่อลูกค้า / บริษัท</th>
                        <th>เลขที่ผู้เสียภาษี</th>
                        <th>รหัส SAP (CardCode)</th>
                        <th>เบอร์มือถือ (1)</th>
                        <th>เบอร์มือถือ (2)</th>
                        <th>อีเมล์</th>
                        <th>จังหวัด</th>
                        <th>เขต</th>
                        <th>LINEID</th>
                    </tr>
                    <tbody id="myTable">                        
                            <%
                                Try
                                    clss.strSql = " SELECT UID, CUSTOMER_NAME, TAXID, CardCode, LINEID, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, DATE_ADD " &
                                            " FROM SYS03_MS_CUSTOMER " &
                                            " ORDER BY CUSTOMER_NAME "
                                    clss.func_SetDataSet(clss.strSql, "CUSTOMER")
                                    For i As Integer = 0 To clss.ds.Tables("CUSTOMER").Rows.Count - 1
                                        With clss.ds.Tables("CUSTOMER").Rows(i)
                                            Response.Write("<tr style='background-color:" & If(i Mod 2 = 0, "#e3f2fd", "000000") & "'>")
                                            '//////
                                            Response.Write("<td style='text-align:right;'>" & i + 1 & "</td>")
                                            Response.Write("<td>" & .Item("CUSTOMER_NAME").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("TAXID").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("CardCode").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("CUSTOMER_MOB").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("CUSTOMER_MOB2").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("C_EMAIL").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("C_PROVINCE").ToString() & "</td>")
                                            Response.Write("<td>" & .Item("C_DISTRICT").ToString() & "</td>")
                                            Response.Write("<td onclick='show_parent();' class='line_id' data-num=" & .Item("LINEID").ToString() & ">" & .Item("LINEID").ToString() & "</td>")
                                            '//////
                                            Response.Write("</tr>")
                                        End With
                                    Next

                                Catch ex As Exception

                                End Try

                            %>
                    </tbody>

        </table>
    </div>
</body>
</html>
<script type="text/javascript">
    $("#myInput").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#myTable tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

    $(document).ready(function () {
        downloadFile();
    });

    function createFile() {
        var str_tmp = '';
        $('.line_id').each(function (index) {
            var tmp = $(this).parent().attr("style");
            if (tmp.indexOf("display: none") == -1) {
                str_tmp += $(this).text() + "\n";
            }
        });


        $.post("createFile.aspx", { data: str_tmp }).done(function (data) {
            if (data == "SUCCESS") {
                $("#bt_download_file").show();
                $("#bt_create_file").show();
            } else {
                alert("ไม่สามารถสร้างไฟล์ได้ กรุณาลองใหม่");
            }
        });
    }

    function downloadFile() {
        $("#bt_create_file").show();
        $("#bt_download_file").hide();
    }

</script>