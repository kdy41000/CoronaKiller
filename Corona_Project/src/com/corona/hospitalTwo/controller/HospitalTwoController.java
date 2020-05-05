package com.corona.hospitalTwo.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hospitalTwo.do")
public class HospitalTwoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HospitalTwoController() {
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		if(command.equals("hospitalTwo")) {
			response.sendRedirect("hospitalTwo/hospitalTwopage.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		doGet(request, response);
	}

}
