
Partial Class services_listbm
    Inherits System.Web.UI.Page

    Dim AM As String = ""
    Dim YEARS As Integer = Date.Now.Year
    Dim cls As New MY_CLASS
    Dim SALE As String = ""
    Dim TYPE_ As String = ""
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            pan_dashboard.Visible = True
            pan_warning.Visible = False
            Try
                If (Session("USER_TYPE") = "ALL") Or (Session("USER_TYPE") = "EN_ALL") Then
                    'DO NOTHING ผ่านสบาย
                ElseIf (Session("USER_TYPE") = "AM_ALL") And (Session("USER_FNAME") = Request("am")) Then
                    'DO NOTHING ผ่านสบาย
                Else
                    pan_dashboard.Visible = False
                    pan_warning.Visible = True
                    Exit Sub
                End If
            Catch ex As Exception
                pan_dashboard.Visible = False
                pan_warning.Visible = True
                Exit Sub
            End Try



            AM = Request("am")
            YEARS = Request("yyy")
            lb_year.Text = YEARS
            lb_am.Text = AM

            ''<FOR AM>
            'cls.strSql = "SELECT * FROM RUENGDECH_SERVICE_SUM_BM WHERE YY = " & YEARS & " AND BM = '" & AM & "' ORDER BY BM ASC"
            'cls.func_SetDataSet(cls.strSql, "AM")
            'gv_am.DataSource = cls.ds.Tables("AM")
            'gv_am.DataBind()
            ''</FOR AM>



            '<FOR SALE>
            cls.strSql = "SELECT BM, [ALL], CLOSED, PENDING, WAIT , ('services_listbm.aspx?am=' & BM & '&YYY=' & YY & '&s=all') as SALE_LINK_ALL " &
                                ", ('services_listbm.aspx?am=' & BM & '&YYY=' & YY & '&s=closed') as SALE_LINK_CLOSE " &
                                ", ('services_listbm.aspx?am=' & BM & '&YYY=' & YY & '&s=pending') as SALE_LINK_PEND " &
                                ", ('services_listbm.aspx?am=' & BM & '&YYY=' & YY & '&s=wait') as SALE_LINK_WAIT " &
                        " FROM RUENGDECH_SERVICE_SUM_BM WHERE YY = " & YEARS & " AND BM = '" & lb_am.Text & "'  ORDER BY BM ASC"
            cls.func_SetDataSet(cls.strSql, "SALE")
            gv_sale.DataSource = cls.ds.Tables("SALE")
            gv_sale.DataBind()
            '</FOR SALE>

            Try
                TYPE_ = Request("S")
                lb_sale.Text = SALE
            Catch ex As Exception

            End Try

            If TYPE_ <> "" Then
                Dim extendSQL As String = ""
                Select Case TYPE_.ToUpper
                    Case "ALL"
                        extendSQL = " ORDER BY date_created ASC "
                    Case "CLOSED"
                        extendSQL = " AND CLOSE_JOB = 'YES' ORDER BY LAST_STATUS_DATE DESC "
                    Case "WAIT"
                        extendSQL = " AND WAIT_PO = 'YES' ORDER BY date_created ASC "
                    Case "PENDING"
                        extendSQL = " AND CLOSE_JOB = 'NO' AND WAIT_PO = 'NO'  ORDER BY date_created ASC "
                End Select


                '<FOR DETAIL>
                cls.strSql = "SELECT RUENGDECH_SERVICE_JOB.job_code AS [NO], RUENGDECH_SERVICE_JOB.date_created as JOB_DATE, RUENGDECH_SERVICE_JOB.job_name as [NAME], RUENGDECH_SERVICE_JOB.model as MODEL" &
                            ", RUENGDECH_SERVICE_JOB.serial1 as [SERIAL NO], RUENGDECH_SERVICE_JOB.Customer as [Customer], RUENGDECH_SERVICE_JOB.currepairStatus, RUENGDECH_SERVICE_JOB.LAST_STATUS_DATE" &
                            ", RUENGDECH_SERVICE_JOB.desc as STATUS, IIF(reservm = 1,'Yes','NO') as [Have Spare]  " &
                        "FROM RUENGDECH_SERVICE_JOB " &
                        "WHERE BM= '" & lb_am.Text & "' AND YY = " & YEARS & extendSQL
                cls.func_SetDataSet(cls.strSql, "HEAD")
                gv_detail.DataSource = cls.ds.Tables("HEAD")
                gv_detail.DataBind()
                '</FOR DETAIL>
            End If

        End If
    End Sub

    Protected Sub gv_sale_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim tmp As String = e.CommandName.ToString.ToUpper
        Dim extendSQL As String = ""
        If e.CommandName.ToString.ToUpper = "SELECT" Then
            'ALL Do Nothing
            extendSQL = " ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "EDIT" Then
            'Wait
            extendSQL = " AND WAIT_PO = 'YES' ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "DELETE" Then
            'PENDING
            extendSQL = " AND CLOSE_JOB = 'NO' ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "NEW" Then
            'CLOSE
            extendSQL = " AND CLOSE_JOB = 'YES' ORDER BY LAST_STATUS_DATE DESC "
        End If
        lb_sale.Text = gv_sale.Rows(rowIndex).Cells(1).Text
        '<FOR DETAIL>
        cls.strSql = "SELECT RUENGDECH_SERVICE_JOB.job_code AS [NO], RUENGDECH_SERVICE_JOB.date_created as JOB_DATE, RUENGDECH_SERVICE_JOB.job_name as [NAME], RUENGDECH_SERVICE_JOB.model as MODEL" &
                            ", RUENGDECH_SERVICE_JOB.serial1 as [SERIAL NO], RUENGDECH_SERVICE_JOB.Customer as [Customer], RUENGDECH_SERVICE_JOB.currepairStatus, RUENGDECH_SERVICE_JOB.LAST_STATUS_DATE" &
                            ", RUENGDECH_SERVICE_JOB.desc as STATUS, IIF(reservm = 1,'Yes','NO') as [Have Spare]  " &
                        "FROM RUENGDECH_SERVICE_JOB " &
                        "WHERE BM= '" & lb_am.Text & "' AND YY = " & lb_year.Text & extendSQL &
        cls.func_SetDataSet(cls.strSql, "HEAD")
        gv_detail.DataSource = cls.ds.Tables("HEAD")
        gv_detail.DataBind()
        '</FOR HEAD>

    End Sub


End Class