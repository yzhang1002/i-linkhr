
<%
Session("admin")=""
Session.Abandon()
%>
<script language="javascript">
window.open("login.asp","_top")
</script>