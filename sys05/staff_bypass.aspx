<%@ Page Language="VB" AutoEventWireup="false" CodeFile="staff_bypass.aspx.vb" Inherits="sys05_staff_bypass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%

        Dim cls As New MY_CLASS
        Dim STAFF_ID As String = cls.decryp_staffSMD(Request.QueryString("sid"))
        cls.strSql = "SELECT users.username, users.pswd FROM users INNER JOIN employee2 ON users.sales_code = employee2.abr WHERE (((employee2.uid)=" & STAFF_ID & ") AND ((employee2.active)=1));"
        cls.func_SetDataSet(cls.strSql, "STAFF")
        If cls.ds.Tables("STAFF").Rows.Count > 0 Then
            Try
                Dim strPost As String = ""
                strPost += "<form name=""postdata"" id=""postdata"" action=""https://saintmed.dyndns.biz/verifyf.asp?path=https://saintmed.dyndns.biz"" method=""post""   >"
                strPost += "<input type=""hidden"" name=""username"" id=""username"" value=""" & cls.ds.Tables("STAFF").Rows(0).Item("username").ToString() & """>"
                strPost += "<input type=""hidden"" name=""password"" id=""password"" value=""" & cls.ds.Tables("STAFF").Rows(0).Item("pswd").ToString() & """>"
                strPost += "<h3>Please wait while login . . .</h3>"
                strPost += "<script language=""JavaScript"">document.postdata.submit();</script>"
                strPost += "</form>"
                Response.Write(strPost)
            Catch ex As Exception
                Response.Redirect("https://saintmed.dyndns.biz/")
            End Try
        Else
            Response.Redirect("https://saintmed.dyndns.biz/")
        End If

%>
</body>
</html>
