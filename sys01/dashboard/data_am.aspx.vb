Imports System.Data
Imports System.Data.SqlClient

Partial Class sys01_dashboard_Default
    Inherits System.Web.UI.Page

    Dim cls As New MY_CLASS_MSSQL()

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim input_am_id, input_staff_id, input_year As String
        input_am_id = Request.Form("req_am_id")
        input_staff_id = Request.Form("req_staff_id")
        input_year = Request.Form("req_year")
        'Label1_am.Text = "Page Load can use | AM ID : " + input_am_id + " | Staff ID : " + input_year
        'Label2.Text = "Year >> " + input_year
        'Label3.Text = "Request Form AM ID >>" + input_am_id

        'Dim query_am_id, am_name As String
        'am_name = Request.QueryString("req_am_name")
        'Label3.Text = Request.QueryString("req_am_name")
    End Sub




    Sub ShowReqDataTable()
        Try
            'Get Value from Search Form
            'Dim am_id = DropDownList_req_am.Text
            'Dim sales_staff_id = DropDownList_req_sales.Text
            Dim am_id = "207008"
            Dim sales_staff_id = ""
            'Label1_am.Text = "AM ID : " + am_id
            'Label3.Text = "| Sale ID : " + sales_staff_id


            'Query Command
            Dim conn As New MY_CLASS_MSSQL()
            Dim select_query As String
            select_query = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job1, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_amid = " + am_id

            conn.strSql = select_query
            conn.func_SetDataSet(conn.strSql, "JobAMRequest")

            If conn.ds.Tables("JobAMRequest").Rows.Count > 0 Then
                Dim RESPONSES As String = ""
                For i As Integer = 0 To conn.ds.Tables("JobAMRequest").Rows.Count - 1
                    With conn.ds.Tables("JobAMRequest").Rows(i)
                        RESPONSES &= i.ToString() &
                            .Item("uid").ToString & "|" & .Item("staff_name").ToString & "|" &
                            .Item("req_installlocation").ToString & "|" & .Item("req_date").ToString & "|" &
                            .Item("req_jobtype1").ToString & "|" & .Item("req_job1").ToString & "|" &
                            .Item("req_staffname1").ToString & "|" & .Item("req_jobdatefinish").ToString & "|" &
                            .Item("req_status").ToString &
                        "^"
                    End With
                Next
                Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
            Else
                Response.Write("FAIL")
            End If
        Catch ex As Exception
            Response.Write("FAIL")
            Response.Write(ex.ToString)
        End Try
    End Sub


End Class
