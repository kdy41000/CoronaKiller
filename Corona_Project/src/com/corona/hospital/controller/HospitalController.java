package com.corona.hospital.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hospital.do")
public class HospitalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public HospitalController() {
     
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		if(command.equals("hospital")) {
			System.out.println("병원정보들어왔다.");
			///////////////////////////////////////////////
			response.sendRedirect("hospital/hospitalpage.jsp");
			
		}
	}
	


	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		doGet(request, response);
	}

}
