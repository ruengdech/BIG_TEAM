
Partial Class sys06_admin_perform
    Inherits System.Web.UI.Page


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles bt_reload.Click
        gv_staff_filter.DataBind()
        gv_staff_all.DataBind()

        gv_staff_filter.Visible = False
        gv_staff_all.Visible = True
    End Sub

    Protected Sub ddl_staff_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_staff.SelectedIndexChanged
        gv_staff_filter.DataBind()
        gv_staff_all.DataBind()


        gv_staff_filter.Visible = True
        gv_staff_all.Visible = False
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
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
                            Response.Redirect("../sys01/authentication/login.aspx")
                        End If

                    Else
                        Response.Redirect("../sys01/authentication/login.aspx")
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
                Response.Redirect("../sys01/authentication/login.aspx")
            End Try

        End If


        If Session("USER_CATEGORY").ToString().IndexOf("MANAGER") = -1 Then
            Response.Redirect("../sys01/authentication/login.aspx")
        End If
    End Sub
End Class
