<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.lang.*"%>
<%@page import="protocol.*"%>
<%@page import="com.goldhuman.auth.*"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%
request.setCharacterEncoding("UTF-8");
	String msg = request.getParameter("msg");
	boolean success = DeliveryDB.broadcast((byte)9,-1,msg);
			if( success )
			{%>
				{"success":1,"message":"Message successfully broadcasted."}
				<%	  
			} else 
			{%>
				{"success":0,"message":"Fail to Broadcast"}
				<%
			}%>    
