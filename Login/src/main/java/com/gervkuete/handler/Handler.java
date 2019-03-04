package com.gervkuete.handler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Handler extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	int clientId = 6862183;
	String clientSecret = "2kLZQBeoWC3DahIhXFLu";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Inside servlet");
		response.setContentType("text/html;charset=utf-8");
		response.setStatus(HttpServletResponse.SC_OK);
		response.sendRedirect(getOAuthUrl());
			
	}


	private String getOAuthUrl() {
		return "https://oauth.vk.com/authorize?client_id=" + clientId + "&display=page&redirect_uri=" + getRedirectUri()
				+ "&scope=friends&response_type=code";
	}
	
	private String getRedirectUri() {
		return "http://env-5417294.mircloud.host/apps/callback.jsp";
	}

}
