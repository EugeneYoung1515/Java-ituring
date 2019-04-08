package com.example.demo.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class CaptchaFormAuthenticationFilter extends FormAuthenticationFilter {

    public static final String DEFAULT_CAPTCHA_PARAM = "captcha";
    private String captchaParam = DEFAULT_CAPTCHA_PARAM;
    private String captchaSessionAttributeName;

    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
        //这个方法从是FormAuthenticationFilter的父类继承来的

        /*
        System.out.println("getParam");
        System.out.println(getUsernameParam());
        System.out.println(getPasswordParam());
        System.out.println(getCaptchaParam());
        System.out.println("getParam");
        */

        CaptchaUsernamePasswordToken token = createToken(request, response);

        try {
            doCaptchaValidate((HttpServletRequest) request, token);//这个会抛出异常 是AuthenticationException的子类IncorrectCaptchaException
            Subject subject = getSubject(request, response);
            subject.login(token);//这个会抛出异常AuthenticationException
            return onLoginSuccess(token, subject, request, response);//这个会抛出Exception

        } catch (AuthenticationException e) {
            return onLoginFailure(token,e,request,response);//这个里面的结果是设置了请求属性 名是shiroLoginFailure 值是异常名
        }
    }

    //验证码校验
    protected void doCaptchaValidate(HttpServletRequest request, CaptchaUsernamePasswordToken token) {

        // 从session中获取图形码字符串
        String captcha = (String) request.getSession().getAttribute(captchaSessionAttributeName);
        /*
        System.out.println("beforeshiro");
        System.out.println(captcha);
        System.out.println(token.getCaptcha());
        System.out.println("aftershiro");
        */

        // 校验
        if (captcha == null || !captcha.equals(token.getCaptcha())) {
            throw new IncorrectCaptchaException();
        }
        System.out.println("removeCaptchaSessionAttribute");
        request.getSession().removeAttribute(captchaSessionAttributeName);
        //throw new IncorrectCaptchaException();
    }

    @Override
    protected CaptchaUsernamePasswordToken createToken(ServletRequest request, ServletResponse response) {
        //System.out.println(((HttpServletRequest)request).getParameter("Email"));

        String username = getUsername(request);
        //System.out.println(username);
        String password = getPassword(request);
        boolean rememberMe = isRememberMe(request);
        String host = getHost(request);
        String captcha = getCaptcha(request);

        return new CaptchaUsernamePasswordToken(username,password,rememberMe,host,captcha);
    }

    protected  String getCaptcha(ServletRequest request) {
        return WebUtils.getCleanParam(request, getCaptchaParam());
    }

    public String getCaptchaParam() {
        return captchaParam;
    }

    public void setCaptchaParam(String captchaParam) {
        this.captchaParam = captchaParam;
    }

    public void setCaptchaSessionAttributeName(String captchaSessionAttributeName) {
        this.captchaSessionAttributeName = captchaSessionAttributeName;
    }
}
