
Partial Class check_connection
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim cls As New MY_CLASS
        lb_error.Text = cls.connect_database_connection
    End Sub
End Class
