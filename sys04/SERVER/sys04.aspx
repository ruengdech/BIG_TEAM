<%@ Page Language="VB" %>

<% 
    Dim cls As New MY_CLASS
    Dim clsSQL As New MY_CLASS_MSSQL
    Dim feature As String = Request.Form("feature")



    Select Case feature
        Case "save_csi"
            Try
                Dim ctrl_csi_1_1 As String = Request.Form("ctrl_csi_1_1")
                Dim ctrl_csi_1_2 As String = Request.Form("ctrl_csi_1_2")
                Dim ctrl_csi_1_3 As String = Request.Form("ctrl_csi_1_3")
                Dim ctrl_csi_2_1 As String = Request.Form("ctrl_csi_2_1")
                Dim ctrl_csi_2_2 As String = Request.Form("ctrl_csi_2_2")
                Dim ctrl_csi_2_3 As String = Request.Form("ctrl_csi_2_3")
                Dim ctrl_csi_3_1 As String = Request.Form("ctrl_csi_3_1")
                Dim ctrl_csi_3_2 As String = Request.Form("ctrl_csi_3_2")
                Dim ctrl_csi_3_3 As String = Request.Form("ctrl_csi_3_3")
                Dim ctrl_csi_4_1 As String = Request.Form("ctrl_csi_4_1")
                Dim ctrl_csi_4_2 As String = Request.Form("ctrl_csi_4_2")
                Dim ctrl_csi_4_3 As String = Request.Form("ctrl_csi_4_3")
                Dim ctrl_csi_4_4 As String = Request.Form("ctrl_csi_4_4")
                Dim ctrl_csi_5_1 As String = Request.Form("ctrl_csi_5_1")
                Dim ctrl_csi_5_2 As String = Request.Form("ctrl_csi_5_2")
                Dim ctrl_txt_date As String = Request.Form("ctrl_txt_date")
                Dim ctrl_txt_dept As String = Request.Form("ctrl_txt_dept")
                Dim ctrl_txt_hospital As String = Request.Form("ctrl_txt_hospital")
                Dim ctrl_txt_ref1 As String = Request.Form("ctrl_txt_ref1")
                Dim ctrl_txt_ref2 As String = Request.Form("ctrl_txt_ref2")
                Dim ctrl_csi_suggestion As String = Request.Form("ctrl_csi_suggestion")

                If ctrl_txt_ref1 = "" Then ctrl_txt_ref1 = "0"

                clsSQL.strSql = "INSERT INTO SYS04_TS_CSIRESULT " &
            "(C_DEPT, C_HOSPITAL, C_DATE" &
            ", C_REFERENCE, C_REFERENCE2 " &
            ", CSI_1_1, CSI_1_2, CSI_1_3" &
            ", CSI_2_1, CSI_2_2, CSI_2_3" &
            ", CSI_3_1, CSI_3_2, CSI_3_3" &
            ", CSI_4_1, CSI_4_2, CSI_4_3, CSI_4_4" &
            ", CSI_5_1, CSI_5_2" &
            ", CS_SUGGESTION, CS_STAFF_REMARK) " &
        "VALUES ( " &
            "'" & ctrl_txt_dept & "', '" & ctrl_txt_hospital & "', CONVERT(DATETIME, '" & ctrl_txt_date & " 00:00:00', 102)" &
            ", " & ctrl_txt_ref1 & ", '" & ctrl_txt_ref2 & "'" &
            ", " & ctrl_csi_1_1 & ", " & ctrl_csi_1_2 & ", " & ctrl_csi_1_3 &
            ", " & ctrl_csi_2_1 & ", " & ctrl_csi_2_2 & ", " & ctrl_csi_2_3 &
            ", " & ctrl_csi_3_1 & ", " & ctrl_csi_3_2 & ", " & ctrl_csi_3_3 &
            ", " & ctrl_csi_4_1 & ", " & ctrl_csi_4_2 & ", " & ctrl_csi_4_3 & ", " & ctrl_csi_4_4 &
            ", " & ctrl_csi_5_1 & ", " & ctrl_csi_5_2 &
            ", '" & ctrl_csi_suggestion & "', ''" &
        ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")
                Else
                    Response.Write("FAIL")
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try

    End Select

%>
