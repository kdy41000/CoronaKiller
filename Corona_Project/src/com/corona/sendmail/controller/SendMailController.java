package com.corona.sendmail.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sendmail.do")
public class SendMailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SendMailController() {
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		if(command.equals("sendmail")) {
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_content = request.getParameter("user_content");
			
			System.out.println("들어왓다");
			System.out.println(user_name+"::"+user_email+""+user_content);
			
			try {
	            String mail_from =  "<" + user_email + ">"; //보낸사람 
	           // String mail_to =    "admin<admin@83rpm.com>";
	            String mail_to =    "kdy41000@gmail.com";     //메일 받는 사람
	            String title =      "CoronaKiller 고객의 메일 입니다. "; //제목
	            String contents =   "보낸 사람 : CoronaKiller";
	          
	            System.out.println("222");
	            mail_from = new String(mail_from.getBytes("UTF-8"), "UTF-8");
	            mail_to = new String(mail_to.getBytes("UTF-8"), "UTF-8");
	 
	            Properties props = new Properties();
	            props.put("mail.transport.protocol", "smtp");
	            props.put("mail.smtp.host", "smtp.gmail.com");
	            props.put("mail.smtp.port", "465");
	            props.put("mail.smtp.starttls.enable", "true");
	            props.put("mail.smtp.socketFactory.port", "465");
	            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.smtp.auth", "true");
	 
	            Authenticator auth = new SMTPAuthenticator();  //보내는 사람 클래스 객체생성
	 
	            Session sess = Session.getDefaultInstance(props, auth);
	 
	            MimeMessage msg = new MimeMessage(sess);
	 
	            msg.setFrom(new InternetAddress(mail_from));
	            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));
	            msg.setSubject(title, "UTF-8");
	            msg.setContent(contents, "text/html; charset=UTF-8");
	            msg.setText(new StringBuffer().append("<fieldset style='text-align:center; height: 600px;'>")
	            			.append("<legend><h1>CoronaKiller 고객의 메일입니다.</h1></legend><br/>")
	            			.append("<img alt='png01;' src='https://kr.seaicons.com/wp-content/uploads/2015/09/Mail-icon1.png' />")
	            			.append("<p style='font-weight:bold; font-size:12px; '>이 메일은 CoronaKiller에서 보낸 고객의 요청메일입니다.</p><br/>")
	            			.append("<p style='font-weight:bold; font-size:12px; color:blue;'>이름 : ["+user_name+"]</p><br/>")
	            			.append("<p style='font-weight:bold; font-size:12px; color:blue;'>이메일 : ["+user_email+"]</p><br/>")
	            			.append("<p style='font-weight:bold; font-size:12px; color:blue;'>내용 : ["+user_content+"]</p><br/>")
	            			.append("</fieldset>").toString()
	            		);
	            msg.setHeader("Content-type", "text/html; charset=UTF-8");
	 
	            Transport.send(msg);
	            jsResponse("메일이 전송되었습니다.", "home/section.jsp", response);
	        
	        } catch (Exception e) {
	        	e.printStackTrace();
	        	System.out.println("[ERROR]:전송에러");
	            response.sendRedirect("home/section.jsp");
	        } finally {
	 
	        }
		}
		doGet(request, response);
	}

	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException { //스크립트 메시지를 편하게 사용하기 위한 메서드(out.println으로 사용해도 된다.)
		String res = "<script type='text/javascript'>"
				   + " alert('"+msg+"');"
				   + " location.href='"+url+"';"
				   + "</script>";
		PrintWriter out = response.getWriter();
		out.println(res);
	}
}
