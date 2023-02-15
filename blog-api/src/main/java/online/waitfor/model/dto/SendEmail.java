package online.waitfor.model.dto;

import online.waitfor.util.comment.EmailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SendEmail {

    @Autowired
    private EmailUtil emailUtil;

    public void sendEmail(String email, String code) {
        String content = "您的验证码为: ";
        emailUtil.sendSimpleMail(email, "主题：Mybolg邮箱验证", content + code);
    }

}
