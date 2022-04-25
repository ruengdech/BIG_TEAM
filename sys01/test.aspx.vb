
Partial Class sys01_test
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim cls As New MY_CLASS_MSSQL()
        Dim res As String = ""
        Dim EMAIL_TO_LIST(2) As String
        EMAIL_TO_LIST(0) = "ruengdech@gmail.com"
        EMAIL_TO_LIST(1) = "ruengdech@gmail.com"
        res = cls.sendEmail(EMAIL_TO_LIST, "noreply@saintmed.com", "TEST", "MYTEST")
        Label1.Text = res.ToString
    End Sub
End Class
