
Partial Class sys01_authentication_bypassLINE
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try

            Dim STAFF_ID_ENCRYP As String = Request.QueryString("sid")
            Dim cls As New MY_CLASS
            Dim STAFF_ID As String = cls.decryp_staffSMD(STAFF_ID_ENCRYP)
            Dim URL_ As String = Request.QueryString("url")


            cls.strSql = "SELECT " &
                            "users.ID, users.username, users.pswd, employee2.uid, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
                        "FROM  " &
                            "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                            "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                        "WHERE (employee2.uid = " & STAFF_ID & ");"
            cls.func_SetDataSet(cls.strSql, "LOGIN")
            If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                With cls.ds.Tables("LOGIN").Rows(0)
                    Session("STAFF_ID") = .Item("uid").ToString
                    Session("USER_ID") = .Item("ID").ToString
                    Session("USER_NAME") = .Item("username").ToString
                    Session("USER_FNAME") = .Item("name").ToString & " " & .Item("lastname").ToString
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
                Try
                    Response.Redirect(URL_)
                Catch ex As Exception
                    'Response.Redirect("../index.aspx")
                End Try
            Else
                Session("USER_ID") = ""
                Session("USER_NAME") = ""
                Session("USER_FNAME") = ""
                Session("USER_ABR") = ""
                Session("USER_TYPE") = ""
                Response.Redirect(URL_)
            End If
        Catch ex As Exception
            Response.Redirect("login.aspx")
        End Try
    End Sub
End Class
