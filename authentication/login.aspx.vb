
Partial Class authentication_login
    Inherits System.Web.UI.Page

    Protected Sub Login1_Authenticate(sender As Object, e As AuthenticateEventArgs) Handles Login1.Authenticate
        Dim cls As New MY_CLASS
        cls.strSql = "SELECT " &
                        "users.ID, users.username, users.pswd, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE, employee2.uid  " &
                    "FROM  " &
                        "(users INNER JOIN employee2 ON users.id = employee2.id)  " &
                        "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                    "WHERE (((users.username)='" & Login1.UserName.ToString & "') AND ((users.pswd)='" & Login1.Password.ToString & "'));"
        cls.func_SetDataSet(cls.strSql, "LOGIN")
        If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
            With cls.ds.Tables("LOGIN").Rows(0)
                Session("STAFF_ID") = .Item("uid").ToString
                Session("USER_ID") = .Item("ID").ToString
                Session("USER_NAME") = .Item("username").ToString
                Session("USER_FNAME") = .Item("name").ToString
                Session("USER_ABR") = .Item("abr").ToString
                Session("USER_TYPE") = .Item("USER_TYPE").ToString
            End With
            Response.Redirect("../services_dashboard.aspx")
        Else
            Session("USER_ID") = ""
            Session("USER_NAME") = ""
            Session("USER_FNAME") = ""
            Session("USER_ABR") = ""
            Session("USER_TYPE") = ""
        End If
    End Sub
End Class
