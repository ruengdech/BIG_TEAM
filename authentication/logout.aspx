<%@ Page Language="VB" %>
<%

    Session("USER_ID") = Nothing
    Session("USER_NAME") = Nothing
    Session("USER_FNAME") = Nothing
    Session("USER_ABR") = Nothing
    Session("USER_TYPE") = Nothing

    Response.Redirect("Login.aspx")

    %>
