<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@ page import="com.vk.api.sdk.client.VkApiClient"%>
<%@ page import="com.vk.api.sdk.client.actors.UserActor"%>
<%@ page import="com.vk.api.sdk.objects.UserAuthResponse"%>
<%@ page import="com.vk.api.sdk.objects.friends.responses.GetResponse"%>
<%@ page import="com.vk.api.sdk.objects.users.UserXtrCounters"%>
<%@ page import="com.vk.api.sdk.queries.friends.FriendsGetQuery"%>
<%@ page import="com.vk.api.sdk.queries.users.UserField"%>
<%@ page import="com.vk.api.sdk.httpclient.HttpTransportClient"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.IOException"%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Info</title>
</head>
<body>


	<%
		try {
			VkApiClient vk = new VkApiClient(new HttpTransportClient());
			UserActor actor = new UserActor(Integer.parseInt(request.getParameter("user")),
					request.getParameter("token"));
			List<UserXtrCounters> getUsersResponse = vk.users().get(actor).userIds(request.getParameter("user"))
					.fields(UserField.PHOTO_100, UserField.CITY).execute();
			UserXtrCounters user = getUsersResponse.get(0);

			response.setContentType("text/html;charset=utf-8");
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().println("<h1>" + user.getFirstName() + " <small>Vk account</small></h1>");
			response.getWriter().println(displayUser(user));
			response.getWriter().println("<h2>" + user.getFirstName() + " <small>Friends list</small></h2>");

			// Friends
			FriendsGetQuery friendsList = vk.friends().get(actor).userId(user.getId());
			GetResponse friendsResponse = friendsList.count(8).execute();
			List<Integer> friendsId = friendsResponse.getItems();

			List<UserXtrCounters> getFriendsResponse = vk.users().get(actor).userIds(friendsId.toString())
					.fields(UserField.PHOTO_100, UserField.CITY).execute();

			response.getWriter().println("<table>");
			if (getFriendsResponse.size() > 0) {
				for (UserXtrCounters friend : getFriendsResponse) {
					response.getWriter().println(displayFriend(friend));
				}
			}

			response.getWriter().println("</table>");

		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			try {
				response.getWriter().println("error");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			response.setContentType("text/html;charset=utf-8");
			e.printStackTrace();
		}
	%>

	<%!private String displayUser(UserXtrCounters user) {
		String userData = "<p>Name: <a href='https://vk.com/id" + user.getId() + "'>" + user.getFirstName() +" "
				+ user.getLastName() + "</a></p>";
		userData += "<p><a href='https://vk.com/id" + user.getId() + "'><img src='" + user.getPhoto100()
				+ "'/></a></p>";
		return userData;
	}%>

	<%!private String displayFriend(UserXtrCounters user) {
		String userData = "<tr>";
		if (user.getCity() == null) {
			userData += "<td><a href='https://vk.com/id" + user.getId() + "'>" + user.getFirstName() + " "
					+ user.getLastName() + "</a><br>City:</td>";
		} else {
			userData += "<td><a href='https://vk.com/id" + user.getId() + "'>" + user.getFirstName() + " "
					+ user.getLastName() + "</a><br>City: " + user.getCity().getTitle() + "</td>";
		}

		userData += "<td><a href='https://vk.com/id" + user.getId() + "'><img src='" + user.getPhoto100()
				+ "' width='50'/></a></td>";
		userData += "</tr>";
		return userData;
	}%>

</body>
</html>