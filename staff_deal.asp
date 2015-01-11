<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

sql = ""
If Request("op") = "0" Then '// insert
  sql = "insert into staff(name,gender,ic,passport,birthday,birthplace,photo,address,postcode,hpno,homeno,email,bankacc,school,mainhotel,nationality,join_date) values ('" & formatSpString(Request("name")) & "','" & formatSpString(Request("gender")) & "','" & formatSpString(Request("ic")) & "','" & formatSpString(Request("passport")) & "','" & formatSpString(Request("birthday")) & "','" & formatSpString(Request("birthplace")) & "','" & formatSpString(Request("photo")) & "','" & formatSpString(Request("address")) & "','" & formatSpString(Request("postcode")) & "','" & formatSpString(Request("hpno")) & "','" & formatSpString(Request("homeno")) & "','" & formatSpString(Request("email")) & "','" & formatSpString(Request("bankacc")) & "','" & formatSpString(Request("school")) & "','" & formatSpString(Request("mainhotel")) & "','" & formatSpString(Request("nationality")) & "','" & formatSpString(Request("join_date")) & "')"
ElseIf Request("op") = "1" Then '// update
  sql = "update staff set name='" & formatSpString(Request("name")) & "',gender='" & formatSpString(Request("gender")) & "',ic='" & formatSpString(Request("ic")) & "',passport='" & formatSpString(Request("passport")) & "',birthday='" & formatSpString(Request("birthday")) & "',birthplace='" & formatSpString(Request("birthplace")) & "',photo='" & formatSpString(Request("photo")) & "',address='" & formatSpString(Request("address")) & "',postcode='" & formatSpString(Request("postcode")) & "',hpno='" & formatSpString(Request("hpno")) & "',homeno='" & formatSpString(Request("homeno")) & "',email='" & formatSpString(Request("email")) & "',bankacc='" & formatSpString(Request("bankacc")) & "',school='" & formatSpString(Request("school")) & "',mainhotel='" & formatSpString(Request("mainhotel")) & "',nationality='" & formatSpString(Request("nationality")) & "',join_date='" & formatSpString(Request("join_date")) & "' where staffid=" & Request("staffid")

ElseIf Request("op") = "2" Then '// delete
  sql = "delete from staff where staffid=" & Request("staffid")
End If


Response.Write ExecQuery(sql)

%>