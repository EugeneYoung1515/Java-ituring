package com.example.demo.serviceImpl;

import com.example.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class MailService{//使用使用gmail 就不行 尔用javamail 使用gmail就行
    //spring mail starter 使用163邮箱就行

    private JavaMailSender mailSender;

    public void sendSimpleMail(String to, String subject, String content) {
        MimeMessage message = mailSender.createMimeMessage();
        try{
        MimeMessageHelper helper = new MimeMessageHelper(message,true);
            helper.setFrom("更改为自己的邮箱地址");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(content,true);
        mailSender.send(message);
        }catch (Exception e) {
            e.printStackTrace();
        }

    }

    public String createConfirmedEmail(User user, Date date, String code){
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        InputStream input = classLoader.getResourceAsStream("templates/template.html");
        try {
            byte[] data = new byte[input.available()];
            input.read(data);
            String template= new String(data,"UTF-8");
            template = template.replace("#userName",user.getUserName()).replace("#userId",user.getUserId().toString()).replace("#code",code);
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String str = format.format(date);
            template = template.replace("#dateTime",str);
            input.close();
            return template;
        }catch (IOException ex){
            ex.printStackTrace();
            return null;
        }

    }
    @Autowired
    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
}