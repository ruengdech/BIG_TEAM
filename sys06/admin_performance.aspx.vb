Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Partial Class sys06_admin_performance
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ''Dim cls As New MY_CLASS
        ''Session("URL") = "../admin/index.aspx"
        ''Try
        ''    If IsNothing(Session("USER_TYPE")) Then
        ''        If Request.QueryString("user_id") <> Nothing Then
        ''            cls.strSql = "SELECT " &
        ''                            "users.ID, users.username, users.pswd, employee2.uid, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
        ''                        "FROM  " &
        ''                            "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
        ''                            "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
        ''                        "WHERE (((users.ID)=" & Request.QueryString("user_id") & ") );"
        ''            cls.func_SetDataSet(cls.strSql, "LOGIN")
        ''            If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
        ''                With cls.ds.Tables("LOGIN").Rows(0)
        ''                    Session("STAFF_ID") = .Item("uid").ToString 'รหัสพนักงานเก็บที่นี่
        ''                    Session("USER_ID") = .Item("ID").ToString
        ''                    Session("USER_NAME") = .Item("username").ToString
        ''                    Session("USER_FNAME") = .Item("name").ToString
        ''                    Session("USER_ABR") = .Item("abr").ToString
        ''                    Session("USER_TYPE") = .Item("USER_TYPE").ToString
        ''                End With
        ''            Else
        ''                Response.Redirect("../authentication/login.aspx")
        ''            End If

        ''        Else
        ''            Response.Redirect("../authentication/login.aspx")
        ''        End If
        ''    Else
        ''        'DO NOTHING
        ''    End If
        ''Catch ex As Exception
        ''    Response.Redirect("../authentication/login.aspx")
        ''End Try


        'If Not Me.IsPostBack Then
        '    Me.BindGrid()
        'End If



    End Sub

    Private Sub BindGrid()
        'Dim conString As String = "Data Source=192.168.0.4;Initial Catalog=RUENGDECH_STMED;Persist Security Info=True;User ID=ruengdech;Password=r4442440044ST"
        'Dim query As String = "SELECT SYS06_TS_STAFF_PERFORM.uid, SYS01_MS_STAFF.STAFF_ID AS [STAFF ID], SYS01_MS_STAFF.STAFF_NAME + ' ' + SYS01_MS_STAFF.STAFF_LNAME AS [STAFF NAME], SYS06_MS_PERFORMANCE.no, SYS06_MS_PERFORMANCE.objective AS KPI, SYS06_TS_STAFF_PERFORM.kpi AS TARGET, SYS06_TS_STAFF_PERFORM.jan, SYS06_TS_STAFF_PERFORM.feb, SYS06_TS_STAFF_PERFORM.mar, SYS06_TS_STAFF_PERFORM.apr, SYS06_TS_STAFF_PERFORM.may, SYS06_TS_STAFF_PERFORM.jun, SYS06_TS_STAFF_PERFORM.jul, SYS06_TS_STAFF_PERFORM.aug, SYS06_TS_STAFF_PERFORM.sep, SYS06_TS_STAFF_PERFORM.oct, SYS06_TS_STAFF_PERFORM.nov, SYS06_TS_STAFF_PERFORM.dec, SYS06_TS_STAFF_PERFORM.avg, SYS06_TS_STAFF_PERFORM.remark FROM SYS06_TS_STAFF_PERFORM INNER JOIN SYS06_MS_PERFORMANCE ON SYS06_TS_STAFF_PERFORM.kpi_uid = SYS06_MS_PERFORMANCE.uid INNER JOIN SYS01_MS_STAFF ON SYS06_TS_STAFF_PERFORM.staff_id = SYS01_MS_STAFF.STAFF_ID WHERE (SYS06_MS_PERFORMANCE.dept_id = 2) AND (SYS06_TS_STAFF_PERFORM.year = " & ddl_year.SelectedValue & ") AND (1=1) ORDER BY [STAFF ID], SYS06_MS_PERFORMANCE.no "

        'Dim condition As String = String.Empty
        'For Each item As ListItem In list_staff.Items
        '    condition += If(item.Selected, String.Format("'{0}',", item.Value), "")
        'Next

        'If Not String.IsNullOrEmpty(condition) Then
        '    condition = String.Format(" SYS01_MS_STAFF.STAFF_ID in  ({0})", condition.Substring(0, condition.Length - 1))
        'Else
        '    condition = "1=1"
        'End If

        'Using con As New SqlConnection(conString)
        '    Using cmd As New SqlCommand(query.Replace("1=1", condition))
        '        Using sda As New SqlDataAdapter(cmd)
        '            cmd.Connection = con
        '            Using dt As New DataTable()
        '                sda.Fill(dt)
        '                GridView1.DataSource = dt
        '                GridView1.DataBind()
        '            End Using
        '        End Using
        '    End Using
        'End Using
    End Sub

    Protected Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles list_staff.SelectedIndexChanged
        Me.BindGrid()
    End Sub

    Protected Sub ddl_staff_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_staff.SelectedIndexChanged
        GridView1.Visible = False
        GridView2.Visible = True
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        GridView1.DataBind()
        GridView2.DataBind()
        GridView1.Visible = True
        GridView2.Visible = False
    End Sub
End Class
