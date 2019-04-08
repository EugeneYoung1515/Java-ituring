package com.example.demo.web;

import com.example.demo.captcha.GraphicHelper;
import com.example.demo.extmodel.UserExt;
import com.example.demo.model.FollowedUserFollowingUser;
import com.example.demo.model.User;
import com.example.demo.model.UserVO;
import com.example.demo.service.BookService;
import com.example.demo.service.UserService;
import com.example.demo.serviceImpl.MailService;
import com.google.common.base.Charsets;
import com.google.common.hash.Hasher;
import com.google.common.hash.Hashing;
import me.srhang.identicon.Identicon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

@Controller
public class UserManagerController {

    private UserService userService;
    private MailService mailService;
    private BookService bookService;

    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String getRegisterForm(){//这个重定向一定要吗
        return "redirect:/register/email";
    }

    //用这种方式来防止重复提交表单 到底有没有用 有没有意义 下面还有一个 isRepeatSubmit
    @RequestMapping(value = "/register/email",method = RequestMethod.GET)//原来是／register/email
    public ModelAndView registerForm(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("/registerForm");
        String token = UUID.randomUUID().toString().replace("-","");
        modelAndView.addObject("token",token);
        session.setAttribute("token",token);
        return modelAndView;
    }

    @RequestMapping(value = "/captcha",method = RequestMethod.GET)
    public void getCaptcha(HttpServletRequest httpServletRequest, HttpServletResponse httpResponse) throws IOException {
        HttpSession session = httpServletRequest.getSession();

        // 从请求中获得 URI ( 统一资源标识符 )
        //String uri = httpServletRequest.getRequestURI();
        //System.out.println(uri);测试

        final int width = 180; // 图片宽度
        final int height = 40; // 图片高度
        final String imgType = "jpeg"; // 指定图片格式 (不是指MIME类型)
        final OutputStream output = httpResponse.getOutputStream(); // 获得可以向客户端返回图片的输出流
        // (字节流)
        // 创建验证码图片并返回图片上的字符串
        String code = GraphicHelper.create(width, height, imgType, output);

        // 建立 uri 和 相应的 验证码 的关联 ( 存储到当前会话对象的属性中 )
        //session.setAttribute(uri, code);
        session.setAttribute("Captcha", code);
    }

    private boolean isRepeatSubmit(HttpServletRequest request) {
        String clientToken = request.getParameter("__RequestVerificationToken");
        //1、如果用户提交的表单数据中没有token，则用户是重复提交了表单
        if(clientToken==null){
            return true;
        }
        //取出存储在Session中的token
        String serverToken = (String) request.getSession().getAttribute("token");
        //2、如果当前用户的Session中不存在Token(令牌)，则用户是重复提交了表单
        if(serverToken==null){
            return true;
        }
        //3、存储在Session中的Token(令牌)与表单提交的Token(令牌)不同，则用户是重复提交了表单
        if(!clientToken.equals(serverToken)){
            return true;
        }

        return false;
    }

    @ResponseBody
    @RequestMapping(value = "/account/checkemail",method = RequestMethod.POST)
    public Map<String, Object> emailValidate(String email,String __RequestVerificationToken,HttpServletRequest httpServletRequest){//可以不使用@ResquestParam
        Map<String, Object> map = new HashMap<>();
        if(!isRepeatSubmit(httpServletRequest)) {
            int count = -1;
            if(userService.getCountBYUserEmail(email) != null) {
                count = userService.getCountBYUserEmail(email);
            }
            System.out.println("test");
            System.out.println(count);
            if (count > 0) {
                map.put("Status", Boolean.FALSE);
                map.put("Message", "该邮箱注册过");
                return map;
            }
            map.put("Status", Boolean.TRUE);
            return map;
        }else {
            map.put("Status", Boolean.FALSE);
            map.put("Message", "关闭其他注册页，并刷新当前注册页");
            return map;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/account/checknickname",method = RequestMethod.POST)
    public Map<String, Object> userNameValidate(String nickname,String __RequestVerificationToken,HttpServletRequest httpServletRequest){//可以不使用@ResquestParam
        Map<String, Object> map = new HashMap<>();
        if(!isRepeatSubmit(httpServletRequest)) {
            int count = 1;
            if(userService.getCountByUserName(nickname) != null){
                count = userService.getCountByUserName(nickname);
            }
            if (count > 0) {
                System.out.println(count);
                map.put("Status", Boolean.FALSE);
                map.put("Message", "该用户名注册过");
                return map;
            }
            map.put("Status", Boolean.TRUE);
            return map;
        }else {
            map.put("Status", Boolean.FALSE);
            map.put("Message", "关闭其他注册页，并刷新当前注册页");
            return map;
        }
    }
    @ResponseBody
    @RequestMapping(value = "/account/checkcaptcha",method = RequestMethod.POST)
    public Map<String, Object> captchaValidate(String captcha,String __RequestVerificationToken,HttpServletRequest httpServletRequest){//可以不使用@ResquestParam
        Map<String, Object> map = new HashMap<>();
        if(!isRepeatSubmit(httpServletRequest)) {
            if (captcha != null && !captcha.equals("")) {
                String captchaOnServer = (String) httpServletRequest.getSession().getAttribute("Captcha");
                if (captchaOnServer == null || !captchaOnServer.equals(captcha)) {//captcha==null||captcha.equals("")
                    map.put("Status", Boolean.FALSE);
                    map.put("Message", "验证码错误");
                    return map;
                }
            }
                map.put("Status", Boolean.TRUE);
                return map;

        } else {
                map.put("Status", Boolean.FALSE);
                map.put("Message", "关闭其他注册页，并刷新当前注册页");
                return map;
        }
    }

    @RequestMapping(value = "/register/email",method = RequestMethod.POST)
    public ModelAndView registerForm(String __RequestVerificationToken,String Email,String NickName,String Password,String Captcha,boolean Agree,HttpServletRequest httpServletRequest){
        ModelAndView modelAndView = new ModelAndView("/welcome");
        if(isRepeatSubmit(httpServletRequest)){
            modelAndView.setViewName("/registerForm");
            modelAndView.addObject("repeatSubmit","请勿重复提交");
        }else {
            Map<String, Object> map = emailValidate(Email, __RequestVerificationToken, httpServletRequest);
            if (!Agree) {
                modelAndView.setViewName("/registerForm");
                modelAndView.addObject("agreeMessage", "请同意注册协议");
            }
            if (!(Boolean) map.get("Status")) {
                modelAndView.setViewName("/registerForm");
                modelAndView.addObject("emailMessage", map.get("Message"));
            }
            map = userNameValidate(NickName, __RequestVerificationToken, httpServletRequest);
            if (!(Boolean) map.get("Status")) {
                modelAndView.setViewName("/registerForm");
                modelAndView.addObject("userNameMessage", map.get("Message"));
            }
            map = captchaValidate(Captcha, __RequestVerificationToken, httpServletRequest);
            if (!(Boolean) map.get("Status")) {
                modelAndView.setViewName("/registerForm");
                modelAndView.addObject("captchaMessage", map.get("Message"));
            }
            if (modelAndView.getViewName().equals("/welcome")) {
                User user = new User();
                user.setEmail(Email);
                user.setUserName(NickName);
                user.setPassword(Password);
                user.setRegisterDate(new Date());
                String largeAvatar =UUID.randomUUID().toString().replace("-","");
                user.setLargeAvatar(largeAvatar);

                File file = new File("/Users/eugeneyoung/Downloads/LargeAvatar/"+largeAvatar+".png");
                createIdenticon(Email+NickName,128,file);
                System.out.println(Email+NickName);
                File file2 = new File("/Users/eugeneyoung/Downloads/SmallAvatar/"+largeAvatar+".png");
                createIdenticon(Email+NickName,32,file2);

                user.setEmailConfirmed(0);
                String code = UUID.randomUUID().toString().replace("-","");
                user.setCode(code);

                userService.register(user);

                modelAndView.addObject("user",user);

                httpServletRequest.getSession().setAttribute("userSession",user);

                httpServletRequest.getSession().removeAttribute("token");

                mailService.sendSimpleMail(Email,"欢迎您加入XX社区",mailService.createConfirmedEmail(user,new Date(),code));
            }
            //httpServletRequest.getSession().removeAttribute("token");//放在这里可能有问题
            else{
                //modelAndView = registerForm(httpServletRequest.getSession());//下面也有post方法调用get方法的
                //就是get 得到表单 post 提交表单 表单信息不对 又变成了得到表单

                String token = UUID.randomUUID().toString().replace("-","");
                modelAndView.addObject("token",token);
                httpServletRequest.getSession().setAttribute("token",token);
            }
        }
        return modelAndView;
    }

    private void createIdenticon(String emailPlusUserName,int size,File file){
        Identicon identicon = new Identicon();

        Hasher hasher = Hashing.md5().newHasher();
        hasher.putString(emailPlusUserName, Charsets.UTF_8);
        String md5 = hasher.hash().toString();

        BufferedImage image = identicon.create(md5, size);

        try{
        ImageIO.write(image, "PNG", file);
        }catch (IOException ex){
            ex.printStackTrace();
        }
    }

    @RequestMapping(value = "/{item:^(?:Large|Small)Avatar$}/{avatar}")
    public void showSmallAvatar(@PathVariable("avatar")String avatar, @PathVariable("item") String item, HttpServletResponse httpServletResponse){
        try {
            FileInputStream fileInputStream = new FileInputStream(new File("/Users/eugeneyoung/Downloads/"+item+"/"+avatar + ".png"));
            byte[] data = new byte[fileInputStream.available()];
            fileInputStream.read(data);
            httpServletResponse.setContentType("image/png");
            OutputStream outputStream = httpServletResponse.getOutputStream();
            outputStream.write(data);
            outputStream.flush();
            outputStream.close();
        }catch (IOException ex){
            ex.printStackTrace();
        }
    }

    @RequestMapping(value = "/account/confirmemail",method = RequestMethod.GET)
    public ModelAndView getConfirmPage(String code,String userId,HttpServletRequest httpServletRequest){
        String token = UUID.randomUUID().toString().replace("-","");
        ModelAndView modelAndView = new ModelAndView("/confirmEmail");
        modelAndView.addObject("mailToken",token);
        modelAndView.addObject("code",code);
        modelAndView.addObject("userId",userId);
        httpServletRequest.getSession().setAttribute("mailToken",token);
        return modelAndView;
    }

    @RequestMapping(value = "/account/confirmemail",method = RequestMethod.POST)
    public ModelAndView getConfirmPage(String Code,String UserId,String __RequestVerificationToken,HttpServletRequest httpServletRequest){
        ModelAndView modelAndView = new ModelAndView("redirect:"+"/account/confirmemailconfirmation");
        String mailToken = (String)httpServletRequest.getSession().getAttribute("mailToken");
        if(mailToken==null||!mailToken.equals(__RequestVerificationToken)){
            modelAndView.setViewName("redirect:"+"/login");
        }else{//这种形式 写错了 用setView搜 可能还有 其他地方有问题
            User user = userService.getUserById(Integer.valueOf(UserId));
            if (user == null || !user.getCode().equals(Code)) {
                modelAndView.setViewName("redirect:" + "/login");
            }else{
                user.setEmailConfirmed(1);
                user.setCode(null);
                userService.updateUser(user);
                httpServletRequest.getSession().removeAttribute("mailToken");
            }
        }
        return modelAndView;
    }

    @RequestMapping(value = "/account/confirmemailconfirmation",method = RequestMethod.GET)
    public ModelAndView getConfirmPage(){
        return new ModelAndView("/confirmEmailConfirmation");
    }//把返回类型改成字符串 直接返回字符串也行

    @RequestMapping(value = "/log-in")
    public ModelAndView loginPage(HttpServletRequest httpServletRequest){
        ModelAndView modelAndView = new ModelAndView("/login");
        String token = UUID.randomUUID().toString().replace("-","");
        modelAndView.addObject("loginToken",token);//这里命名成token可能不太好
        httpServletRequest.getSession().setAttribute("loginToken",token);
        return modelAndView;
    }


    @RequestMapping(value = "/user/notification", method = RequestMethod.GET)
    public ModelAndView userNotification(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("/notification");
        User userSession = (User)session.getAttribute("userSession");
        UserExt userExt = userService.getUserWithVoteAndFavById(userSession.getUserId());
        modelAndView.addObject("user",userExt);
        modelAndView.addObject("formatAge",formatAge(userExt.getRegisterDate(),new Date()));
        modelAndView.addObject("item","notification");
        return modelAndView;
    }

    @RequestMapping(value = "/message",method = RequestMethod.GET)
    public ModelAndView message(HttpSession session){
        ModelAndView modelAndView = userNotification(session);
        modelAndView.addObject("item","message");
        return modelAndView;
    }

    @GetMapping("/user/index")//应该是spring 4.x最后最有一个版本添加的注解  看源码
    public String userIndex(){
        return "redirect:/message";
    }

    @RequestMapping(value = "/space/{userId}")
    public ModelAndView articleOrSpace(@PathVariable Integer userId,HttpSession session){
        User user = (User)session.getAttribute("userSession");
        ModelAndView modelAndView = new ModelAndView("/notification");
        //modelAndView.addObject("user",userService.getUserWithVoteAndFavById(userId));
        UserExt userExt = userService.getUserWithVoteAndFavById(userId);
        modelAndView.addObject("user",userExt);
        modelAndView.addObject("formatAge",formatAge(userExt.getRegisterDate(),new Date()));
        modelAndView.addObject("item","articleOrSpace");
        modelAndView.addObject("attendtion",userService.attendtionOrNot2(userId,user.getUserId()));

        return modelAndView;
    }

    @RequestMapping(value = "/user/toggleattendtion/{userId}",method = RequestMethod.POST)
    public void toggleAttendtion(@PathVariable Integer userId,HttpSession session,HttpServletResponse httpServletResponse){//在bookManageController那里有一个相似的
        User user = (User)session.getAttribute("userSession");
        try {
            if (user != null) {
                httpServletResponse.sendRedirect("/user/toggleattendtion/" + userId);
            }else {
                System.out.println("redirect");
                httpServletResponse.sendError(500);
            }
        }catch (IOException ex){
            ex.printStackTrace();
        }
    }

    @RequestMapping(value = "/user/toggleattendtion/{userId}",method = RequestMethod.GET)
    public ModelAndView toggleAttendtion2(@PathVariable Integer userId,HttpSession session){//这个方法是关注或不关注
        //另一个方法是展示关注数或者被关注数的
        //在下面另一个方法那里
        ModelAndView modelAndView = new ModelAndView("/attendtion");
        User user = (User)session.getAttribute("userSession");
        FollowedUserFollowingUser followedUserFollowingUser = userService.attendtionOrNot(userId,user.getUserId());
        modelAndView.addObject("ffUser",followedUserFollowingUser);
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }



    @RequestMapping(value = "/change-password",method = RequestMethod.GET)
    public ModelAndView changePasswordPage(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("/changePassword");
        String token = UUID.randomUUID().toString().replace("-","");
        modelAndView.addObject("passwordToken",token);
        session.setAttribute("passwordSessionToken",token);//这个设置请求token应该可以有过滤器加包装类做
        return modelAndView;
    }

    @RequestMapping(value = "/change-password",method = RequestMethod.POST)
    public ModelAndView changePassword(String NewPassword,String OldPassword,String __RequestVerificationToken,HttpServletRequest httpServletRequest) {
        String token = (String) httpServletRequest.getSession().getAttribute("passwordSessionToken");
        ModelAndView modelAndView = new ModelAndView("/changePasswordSuccess");
        if (token == null || !token.equals(__RequestVerificationToken)) {
            modelAndView.setViewName("redirect:" + "/change-password");//这里不一定要用重定向 直接发到视图可以吧
        }else{
            User user = (User) httpServletRequest.getSession().getAttribute("userSession");//直接从会话里拿不再从数据库里拿
            User user2 = userService.getUserById(user.getUserId());
            //这样不行 连续改密码 就不行了 上面的user记录的是最早的密码
        if (user == null || !user2.getPassword().equals(OldPassword)) {
            modelAndView = changePasswordPage(httpServletRequest.getSession());
            modelAndView.addObject("Incorrect", "密码不正确");
        }else {
            //User user1 = new User();
            //user1.setUserId(user.getUserId());
            //user1.setPassword(NewPassword);

            user2.setPassword(NewPassword);
            userService.updateUserSelective(user2);
            httpServletRequest.getSession().removeAttribute("passwordSessionToken");
            httpServletRequest.getSession().setAttribute("userSession",user2);
        }
    }
        return modelAndView;

    }

    @RequestMapping(value = "/user/edit",method = RequestMethod.GET)
    public ModelAndView editProfile(HttpSession session){
        User user = (User)session.getAttribute("userSession");//从会话属性中拿到userSession 只使用不变的部分 如id
        //这里更新了profile userSession里也要跟着改

        User user1 = userService.getUserById(user.getUserId());
        String token = UUID.randomUUID().toString().replace("-","");

        ModelAndView modelAndView = new ModelAndView("/edit");
        modelAndView.addObject("user",user1);
        modelAndView.addObject("profileToken",token);

        session.setAttribute("profileToken",token);
        return modelAndView;
    }

    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    @ResponseBody
    public Map fileUpload(@RequestParam("upload-avatar") MultipartFile file,HttpSession session){
        if(!file.isEmpty()) {
            String uuid = UUID.randomUUID().toString().replace("-", "");
            String fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf("."));
            File file1 = new File("/Users/eugeneyoung/Downloads/LargeAvatar/" + uuid + suffix);//这里有问题传进来任意格式的图片 但是上面只展示png格式的
            try {
                file.transferTo(file1);//大图存完了还有小图

                zoomOutImage(file1,"/Users/eugeneyoung/Downloads/SmallAvatar/" + uuid + suffix,4);

                Map<String, String> map = new HashMap<>();
                map.put("file_length", file.getSize() + "");
                map.put("file_path", "/LargeAvatar/" + uuid);
                map.put("ext", suffix);
                map.put("success", "true");
                map.put("file_name", fileName);

                User user = (User)session.getAttribute("userSession");
                User user1 = userService.getUserById(user.getUserId());
                user1.setLargeAvatar(uuid);
                userService.updateUser(user1);
                user.setLargeAvatar(uuid);//跟着更新userSession中的对象的实例变量

                String uuid2 = UUID.randomUUID().toString().replace("-","");
                map.put("key",uuid2);
                session.setAttribute("uploadFileKey",uuid2);
                return map;
            }catch (IOException ex){
                ex.printStackTrace();
            }
        }
        return null;
    }

    @RequestMapping(value = "/user/setavatar",method = RequestMethod.POST)
    public String fileUpload2(String key,HttpSession httpSession){
        String uploadFileKey = (String)httpSession.getAttribute("uploadFileKey");
        if(uploadFileKey!=null&&uploadFileKey.equals(key)){
            return "/fileAvatarHTMLAttribute";
        }
        return null;//这里可能有问题
    }

    @RequestMapping(value = "/user/edit",method = RequestMethod.POST)
    public String editProfile(String __RequestVerificationToken, UserVO userVO,HttpSession session){//表单参数映射到java属性时 表单参数是大写开头的 没问题
        String profileToken = (String)session.getAttribute("profileToken");
        if(profileToken==null||!profileToken.equals(__RequestVerificationToken)){
            return "redirect:/user/edit";//重定向到这个可能不够好
            //重定向之前 要不要移除会话属性`
        }
        User user=(User)session.getAttribute("userSession");
        User user1 = new User();
        //user1.setUserId(user.getUserId());
        user1.setUserId(userVO.getId());
        user1.setUserName(userVO.getNickName());
        user1.setPersonalWebsite(userVO.getWebsite());
        user1.setUserIntro(userVO.getMemo());
        userService.updateUserSelective(user1);
        session.removeAttribute("profileToken");
        return "redirect:/user/notification";
    }

    @RequestMapping(value = "/user/fav",method = RequestMethod.GET)
    public ModelAndView userFav(HttpSession session){//这个方法可以放到另一个BookManagerController里
        User user =(User)session.getAttribute("userSession");//用过滤器 加包装类 设置把会话属性设置成请求参数 避免这句话？
        ModelAndView modelAndView = userNotification(session);//可以和userNotification用同一份视图文件
        modelAndView.setViewName("/favPage");
        modelAndView.addObject("fBook",bookService.getAllFavBooksByUserId(user.getUserId()));
        return modelAndView;
    }

    @RequestMapping(value = "/user/{item:^(?:following|followme)$}",method = RequestMethod.GET)
    public ModelAndView followingOrFollowMe(@PathVariable String item, HttpSession session){
        User user = (User)session.getAttribute("userSession");//可以和userNotification用同一份视图文件
        ModelAndView modelAndView = userNotification(session);
        modelAndView.setViewName("/following");
        if(item.equals("following")) {
            modelAndView.addObject("following", userService.usersFollowedByMe(user.getUserId()));
        }else {
            modelAndView.addObject("followme",userService.usersFollowingMe(user.getUserId()));
        }
        return modelAndView;
    }

    @RequestMapping(value = "/user/following/{userId}",method = RequestMethod.GET)
    public ModelAndView followingOrFollowMe(String type,@PathVariable Integer userId,HttpSession session){
        ModelAndView modelAndView = userNotification(session);
        modelAndView.setViewName("/following");
        if(type.equals("follow")) {
            modelAndView.addObject("following", userService.usersFollowedByMe(userId));
        }else {
            modelAndView.addObject("followme",userService.usersFollowingMe(userId));
        }
        return modelAndView;
    }

    public String formatAge(Date date1,Date date2) {//另一个web类还有一个工具方法 这些工具方法可以放到一个工具类中
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);

        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        int day1 = cal1.get(Calendar.DAY_OF_YEAR);
        int day2 = cal2.get(Calendar.DAY_OF_YEAR);

        int year1 = cal1.get(Calendar.YEAR);
        int year2 = cal2.get(Calendar.YEAR);
        if (year1 != year2){
            return (year2-year1)+" 年";
        }else{
            int days = day2 - day1;
            int month=days/30;
            if(month>1){
                return month+" 个月";
            }else {
                if(days%7==0){
                    return days/7+" 周";
                }else{
                    return days+" 天";
                }
            }
        }
    }

    public  BufferedImage  zoomOutImage(BufferedImage  originalImage, Integer times){
        int width = originalImage.getWidth()/times;
        int height = originalImage.getHeight()/times;
        BufferedImage newImage = new BufferedImage(width,height,originalImage.getType());
        Graphics g = newImage.getGraphics();
        g.drawImage(originalImage, 0,0,width,height,null);
        g.dispose();
        return newImage;
    }
    public  boolean zoomOutImage(File of,String newPath,Integer times) {
        BufferedImage bufferedImage = null;
        try {
            if (of.canRead()) {
                bufferedImage = ImageIO.read(of);
            }
        } catch (IOException e) {
            //TODO: 打印日志
            return false;
        }
        if (bufferedImage != null) {
            bufferedImage = zoomOutImage(bufferedImage, times);
            try {
                //TODO:
                ImageIO.write(bufferedImage, "JPG", new File(newPath)); //保存修改后的图像,全部保存为JPG格式
            } catch (IOException e) {
                // TODO 打印错误信息
                return false;
            }
        }
        return true;
    }
    //图片相关的工具类方法
    //按照图片名(不包括后缀)找图片
    //按图片的短边伸缩图片到32或者128 之后取中间部分
    //可能还需要有一个路径保存原图


    //到现在为止 有4个还是5个工具方法
    //可以提出来作为工具类了


    //工具类
    //把一些代码放到业务层里
    //事务

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }
}
//if嵌套的问题
//会话属性删除的问题

//token的作用
//以及会话属性中token属性的移除

//前面一些往视图里填属性的 也再设置会话属性的 可以把往视图里填属性那一步去掉
