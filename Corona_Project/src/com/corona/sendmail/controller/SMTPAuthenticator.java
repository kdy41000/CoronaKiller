package com.corona.sendmail.controller;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

/**
* @author viper9
*
*/
public class SMTPAuthenticator extends Authenticator {
   public SMTPAuthenticator() {
       super();
   }

   public PasswordAuthentication getPasswordAuthentication() {   //보내는 사람
	   
       String username = "kdy41000@gmail.com";
       String password = "vqgolmjiwlulwfwk";
       return new PasswordAuthentication(username, password);
   }
}