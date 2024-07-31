package com.coincare.helper;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {
  /*
  requriements
  mail source acc [from]
  mail destination acc [to]
  message
  subject 
  
 */
  private String message;
  private String subject;
  private String mailTo;
  private final String mailFrom = "coincare.personalexpense@gmail.com";
  
  public SendMail(){
    
  }

  public SendMail(String message, String subject, String mailTo) {
    this.message = message;
    this.subject = subject;
    this.mailTo = mailTo;
  }
  
    //this method is responsible to send email
    public void sendEmail() {
    //variable for gmail host server
    String host ="smtp.gmail.com";
    //get system properties
    Properties properties = new Properties();
    System.out.println("Properties: " + properties);
    //setting important info to properties object **important

    //host set
    properties.put("mail.smtp.host", host);
    properties.put("mail.smtp.port", "587");
    properties.put("mail.smtp.auth", "true");
//      properties.put("mail.smtp.ssl.enable", "true");//ssl enabled
    properties.put("mail.smtp.starttls.enable", "true");

    //step1: to get session object 
    Authenticator auth = new Authenticator(){
      public PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(mailFrom, "hags cruz dukw qfse");
      }
    };
    Session session = Session.getInstance(properties, auth);
    session.setDebug(true);
    //step2: compose the message [text or attachment or multimedia]
    MimeMessage mimeMessage = new MimeMessage(session);
    try {
      //from email
      mimeMessage.setFrom(mailFrom);

      //adding recipient to message
      mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));

      //adding subject to message
      mimeMessage.setSubject(subject);

      //adding text to message
      mimeMessage.setText(message);

      //send
      //step 3: send message using transport class
      Transport.send(mimeMessage);

      System.out.println("Sent successfully");

    } catch (MessagingException ex) {
      ex.printStackTrace();
    }
  }
}
