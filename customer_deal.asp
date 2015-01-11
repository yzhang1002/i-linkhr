<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

sql = ""
If Request("op") = "0" Then '// insert
  sql = "insert into customer(cusname,address,tel,fax,accountno,email,termpay,cregno,hotelrate,attention) values ('" & formatSpString(Request("cusname")) & "','" & formatSpString(Request("address")) & "','" & formatSpString(Request("tel")) & "','" & formatSpString(Request("fax")) & "','" & formatSpString(Request("accountno")) & "','" & formatSpString(Request("email")) & "','" & formatSpString(Request("termpay")) & "','" & formatSpString(Request("cregno")) & "'," & formatSpString(Request("hotelrate")) & ",'"&formatSpString(Request("attention"))&"')"
ElseIf Request("op") = "1" Then '// update
  sql = "update customer set cusname='" & formatSpString(Request("cusname")) & "',address='" & formatSpString(Request("address")) & "',tel='" & formatSpString(Request("tel")) & "',fax='" & formatSpString(Request("fax")) & "',accountno='" & formatSpString(Request("accountno")) & "',email='" & formatSpString(Request("email")) & "',termpay='" & formatSpString(Request("termpay")) & "',cregno='" & formatSpString(Request("cregno")) & "',hotelrate=" & formatSpString(Request("hotelrate")) & ",attention='" & formatSpString(Request("attention")) & "' where cusid=" & Request("cusid")

ElseIf Request("op") = "2" Then '// delete
  sql = "delete from customer where cusid=" & Request("cusid")
End If


Response.Write ExecQuery(sql)

%>