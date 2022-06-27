
Partial Class sys01_dashboard_New_DataTable
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not (Me.IsPostBack) Then

            ddl_year.Items.FindByValue(DateTime.Now.ToString("yyyy")).Selected = True

        End If

        'ddl_year.SelectedValue = DateTime.Now.ToString("yyyy")
        Dim req_group, req_year As String
        req_group = ddl_reqGroup.Text
        req_year = ddl_year.Text
        '*** Create Session ***'
        Session.Timeout = 20
        Session("Group") = req_group
        Session("Year") = req_year
    End Sub

End Class
