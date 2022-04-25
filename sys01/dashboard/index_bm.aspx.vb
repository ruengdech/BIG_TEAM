
Partial Class sys01_dashboard_index_am
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ddl_year.SelectedValue = Request.QueryString("bm")
        End If
    End Sub

    Protected Sub ddl_year_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_year.SelectedIndexChanged
        Label1.Text = ddl_year.SelectedItem.Text
    End Sub

    Protected Sub ddl_year_DataBound(sender As Object, e As EventArgs) Handles ddl_year.DataBound
        Label1.Text = ddl_year.SelectedItem.Text
    End Sub
End Class
