<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@ page import="com.vk.api.sdk.client.VkApiClient" %>  
 <%@ page import="com.vk.api.sdk.client.actors.UserActor" %> 
 <%@ page import="com.vk.api.sdk.objects.UserAuthResponse" %>
 <%@ page import="java.io.IOException" %>
 <%@ page import="com.vk.api.sdk.httpclient.HttpTransportClient"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Callback</title>
</head>
<body>

<%try {
	
	int clientId = 6862183;
	String clientSecret = "2kLZQBeoWC3DahIhXFLu";
	VkApiClient vk = new VkApiClient(new HttpTransportClient());
	UserAuthResponse authResponse = vk.oauth().userAuthorizationCodeFlow(clientId, clientSecret,
			"http://env-5417294.mircloud.host/apps/callback.jsp", request.getParameter("code")).execute();
	response.sendRedirect(
			"http://env-5417294.mircloud.host/apps/info.jsp?token=" + authResponse.getAccessToken() + "&user=" + authResponse.getUserId());
} catch (Exception e) {

	try {
		response.sendRedirect("http://env-5417294.mircloud.host/apps/accessDenied.html");
	} catch (IOException e1) {
		e1.printStackTrace();
	}
} %>

</body>
</html>