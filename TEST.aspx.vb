Imports SMS_NEW
Partial Class TEST
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim x As New SMS_NEW()
        ''x.SEND_SMS("0814443772", "OK ไทย ได้")

        'Dim y As New LINE_DIRECT()
        'y.SEND_MSG(y.GENERATE_TEXT_MSG("U61ddf41b2bdbe1ebd6594b66eabac086", "MSG"))

        Dim url As String = Request.QueryString("url")
        Dim xx As String = url


    End Sub
End Class
