Imports ClosedXML.Excel
Imports System.IO
Partial Class sys02_sale_export
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim cls As New MY_CLASS_MSSQL
        Dim USER_STAFF_ID As String = Session("STAFF_ID")

        Dim CONDITION_ As String = ""
        cls.strSql = "SELECT VIEW_STAFF_ID, VIEW_PRODUCT_UID FROM SYS02_MS_STAFF_PRIVILED WHERE (STAFF_ID = '" & USER_STAFF_ID & "')"
        cls.func_SetDataSet(cls.strSql, "STAFF")
        If cls.ds.Tables("STAFF").Rows.Count > 0 Then
            With cls.ds.Tables("STAFF").Rows(0)
                'If .Item(0).ToString = "ALL" And .Item(1).ToString = "ALL" Then
                '    CONDITION_ = "  " ' Nothing to Fillter
                'ElseIf .Item(0).ToString = "ALL" And .Item(1).ToString = "ALL" Then
                'End If
                CONDITION_ = " AND ( (" & .Item(0).ToString & ") AND (" & .Item(1).ToString & ") )  "
            End With
        Else
            Response.End()
        End If

        cls.strSql = "SELECT UID, convert(varchar, SALE_DATE, 23) as SALE_DATE, SALE_HOSPITAL, SALE_DEPARTMENT, SALE_PRODUCT_ID, SALE_PRODUCT_MODEL_NAME, PRODUCT_NAME, BRAND_NAME, SALE_UNIT_PRICE, SALE_QTY, SALE_TOTAL_PRICE, SALE_CUSTSTATE_ID, CUSTSTATE_NAME, SALE_ORDERSTATE_ID, ORDERSTATE_NAME, SALE_ESTIMATE_IN, SALE_STAFF_ID, SALE_STAFF_AM_ID, SALE_STAFF_BM_ID, SALE_STAFF_SUP_ID, SALE_ORDER_TYPE, ORDERTYPE_NAME, SALE_ORDER_YEAR, SALE_ORDER_MONTH, SALE_PROB_ID, ORDERPROB_NAME, SALE_BUDGET_ID, BUDGETTYPE_NAME, STAFF_ID, STAFF_NAME, BM_ID, BM_NAME, AM_ID, AM_NAME, SALE_REMARK, SALE_CWHEN, SALE_MWHEN, SALE_CNAME, SALE_MNAME,BRAND_ID FROM SYS02_VIEW_TS_SALE WHERE SALE_STATUS = 'ACTIVE' " & CONDITION_ & " ORDER BY SALE_MWHEN DESC,  UID DESC"
        cls.func_SetDataSet(cls.strSql, "JOB_DATA")

        Using wb As New XLWorkbook()
            wb.Worksheets.Add(cls.ds.Tables("JOB_DATA"), "SALEFUNNEL")

            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            Response.AddHeader("content-disposition", "attachment;filename=SaleFunnel.xlsx")
            Using MyMemoryStream As New MemoryStream()
                wb.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(Response.OutputStream)
                Response.Flush()
                Response.End()
            End Using
        End Using
    End Sub
End Class
