<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="com.goldhuman.auth.AuthFilter"%>
<%@ page import="com.goldhuman.service.interfaces.LogInfo"%>
<%@ page import="com.goldhuman.service.interfaces.SimpleRoleBean"%>
<%@ page import="com.goldhuman.service.interfaces.GMService"%>
<%@ page import="com.goldhuman.service.GMServiceImpl"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="com.goldhuman.util.LocaleUtil"%>
<%
			String userid = "";
			String roleid = "";
			String rname = "";
			String biao = request.getParameter("biao");
			if (biao != null && biao.equals("1")) {
				userid = request.getParameter("userid");
			}
			if (biao != null && biao.equals("2")) {
				roleid = request.getParameter("roleid");
				if (roleid != null && roleid.trim().length() > 0) {
					try {
						int rid = Integer.parseInt(roleid);
						GMService gs = new GMServiceImpl();
						int tmpid = gs.roleid2Uid(new Integer(rid), new LogInfo());
						if (-1 == tmpid)
							throw new Exception("roleid2uid return -1");
						userid = Integer.toString(tmpid);
					} catch (Exception e) {
						out.println(LocaleUtil.getMessage(request,"role_rolelist_inputnum") + "&nbsp;<font color=red size=2>" + e.getMessage() + "</font>");

					}
				}
			}
			if (biao != null && biao.equals("3")) {
				rname = request.getParameter("roname");
				if (rname != null && rname.trim().length() > 0) {
					try {
						GMService gs = new GMServiceImpl();
						int tem = gs.getRoleIdByName(rname, new LogInfo());
						if (-1 == tem)
							throw new Exception("getRoleIdByName return -1");
						int tmpid = gs.roleid2Uid(new Integer(tem), new LogInfo());
						if (-1 == tmpid)
							throw new Exception("roleid2uid return -1");
						userid = Integer.toString(tmpid);
					} catch (Exception e) {
						out.println("<font color=red size=2>" + LocaleUtil.getMessage(request,"role_rolelist_nofound") + "</font>");
					}
				}
			}
			LogFactory.getLog("rolelist.jsp").info(
					"userid=" + userid + "," + "operator="
							+ AuthFilter.getRemoteUser(session));

			%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title><%= LocaleUtil.getMessage(request,"role_rolelist_title") %></title>
		<link href="../include/style.css" rel="stylesheet" type="text/css">
	</head>

	<body>
		<%@include file="../include/header.jsp"%>
		<table width="100%" height="514" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">

			<tr>
				<td>
					<TABLE border="1" cellpadding="0" cellspacing="1" width="500px" align="center" bgcolor="#FFFFFF">
						<TR>
							<TH>
								<%= LocaleUtil.getMessage(request,"role_rolelist_roleid") %>
							</TH>
							<TH>
								<%= LocaleUtil.getMessage(request,"role_rolelist_rolename") %>
							</TH>
							<TH>
								<%= LocaleUtil.getMessage(request,"role_rolelist_rolelevel") %>
							</TH>
						</TR>

						<%LogInfo info = null;
			int uid = -1;
			GMService gs = new GMServiceImpl();
			if (userid != null && userid.trim().length() > 0) {
				try {
					uid = Integer.parseInt(userid);
				} catch (Exception e) {
					 out.println(LocaleUtil.getMessage(request,"role_rolelist_inputnum") + "&nbsp;<font color=red size=2>" + e.getMessage() + "</font>");
				}
				info = new LogInfo(uid, "", LocaleUtil.getMessage(request,"role_rolelist_showrolelist"));
				Vector v = gs.getRolelist(uid, info);
				if (v != null) {
					for (int i = 0; i < v.size(); i++) {
						SimpleRoleBean bean = (SimpleRoleBean) v.get(i);

						%>
						<TR>
							<TD>
								<%=bean.roleid%>
							</TD>
							<TD>
								<%=bean.rolename%>
							</TD>
							<TD>
								<%=bean.level%>
							</TD>
						</TR>
						<%}
				}
			}%>
					</TABLE>
				</td>
			</tr>

			<tr>
				<td align="center">
					<form name="form1" action="rolelist.jsp" method="post">
						<%= LocaleUtil.getMessage(request,"role_rolelist_searchlist") %>
						<table border="0">
							<tr>
								<td>
									<input type="radio" name="biao" value="1" onclick="show(1)" checked="checked">
									<%= LocaleUtil.getMessage(request,"role_rolelist_inputuserid") %>
								</td>
								<td>
									<div id="uid" style="display:">
										<input type="text" name="userid" value="<%=userid%>" size="16" maxlength="10" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="biao" value="2" onclick="show(2)">
									<%= LocaleUtil.getMessage(request,"role_rolelist_inputroleid") %>
								</td>
								<td>
									<div id="rid" style="display:none">
										<input type="text" name="roleid" value="<%=roleid%>" size="16" maxlength="10" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="biao" value="3" onclick="show(3)">
									<%= LocaleUtil.getMessage(request,"role_rolelist_inputrolename") %>
								</td>
								<td>
									<div id="rname" style="display:none">
										<input type="text" name="roname" value="<%=rname%>" size="16" maxlength="10" />
									</div>
								</td>
							</tr>
						</table>
						<input type="submit" value="<%= LocaleUtil.getMessage(request,"role_rolelist_submit") %>">
					</form>
				</td>
			</tr>

		</table>
		<%@include file="../include/foot.jsp"%>
		<script language="javascript">
<!--

    function show(t){
      if(t==1)
        document.getElementById("uid").style.display="";
      else
        document.getElementById("uid").style.display="none";
      if(t==2)  
        document.getElementById("rid").style.display="";
      else
        document.getElementById("rid").style.display="none";  
      if(t==3)
        document.getElementById("rname").style.display="";
      else 
        document.getElementById("rname").style.display="none";          
    
    }

-->

</script>

	</body>
</html>
