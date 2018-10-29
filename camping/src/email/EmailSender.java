package email;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
    @Autowired
    protected JavaMailSender mailSender;
    public void SendEmail(Email email) throws Exception {
         
    	String from = "nikel9205@gmail.com";
    	
        MimeMessage msg = mailSender.createMimeMessage();
        try {
        	msg.setFrom(new InternetAddress(from));
            msg.setSubject(email.getSubject());
            msg.setText(email.getContent());
            msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver()));
            mailSender.send(msg);
           System.out.println("성공");
        }catch(MessagingException e) {
            System.out.println("MessagingException");
            e.printStackTrace();
        }
        try {
            
        }catch(MailException e) {
            System.out.println("MailException발생");
            e.printStackTrace();
        }
    }
}
