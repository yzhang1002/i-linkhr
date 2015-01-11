<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%
hotelrate = 0
set rs = GetRecordSet("select hotelrate from customer where cusname='" & Request("hotelname") & "'")

If (Not rs.eof) And (Not rs.bof) Then
  hotelrate = rs("hotelrate")
End If


sql = "insert into sign_base(signdate,joborder,timein,timeout,hotelname,hotelrate,venuename,attention,staffnum) values ('" & formatSpString(Request("signdate")) & "','" & formatSpString(Request("joborder")) & "','" & formatSpString(Request("timein")) & "','" & formatSpString(Request("timeout")) & "','" & formatSpString(Request("hotelname")) & "','" & hotelrate & "','" & formatSpString(Request("venuename")) & "','" & formatSpString(Request("attention")) & "'," & Request("staffnum") & ")"

Response.Write ExecQuery(sql)

set rs = GetRecordSet("select top 1 signid from sign_base order by signid desc")
If (Not rs.eof) And (Not rs.bof) Then
  sID = rs("signid")
End If

staffid = Split(Request("staffid"),",")
timein = Split(Request("row_timein"),",")
timeout = Split(Request("row_timeout"),",")
hours = Split(Request("hours"),",")

For i=LBound(staffid) To UBound(staffid)

  sql = "insert into sign_list(signid,staffid,timein,timeout,hours,hotelrate,amount) values (" & sID & "," & staffid(i) & ",'" & formatSpString(timein(i)) & "','" & formatSpString(timeout(i)) & "'," & formatSpString(hours(i)) & "," & hotelrate & "," & CDbl(hours(i)) * CDbl(hotelrate) & ")"

  Response.Write ExecQuery(sql)

Next

%>