# Java-ituring

使用Spring Boot和Mybatis实现图灵社区的页面和功能，涉及大多数图书页面和大多数用户页面，未实现文章页面。

- **Dao层和Service层**

数据库使用PostgreSql。  
使用Mybatis Generator生成Model类、Mapper文件和接口，以注解方式书写SQL语句。  
涉及多种表间关系，主要使用JOIN处理表间关系。继承resultMap，跨文件引用Mapper文件元素，实现代码代码复用。使用Mybatis的动态SQL，实现多条件查询。  
使用PageHelper实现分页功能。

- **Web层和视图层**

以JSP作为模版。  
使用Spring MVC的文件上传API，实现用户头像的上传，以原生的Servlet方法，发送图片流，展示用户头像。使用Spring Boot默认的静态资源配置，提供js文件、css文件和字体文件给浏览器。通过发送JSON数据或HTML文本两种方式与AJAX交互。

- **用户注册和认证**

使用spring-boot-starter-mail,给用户发送注册确认文件。  
使用Shiro实现用户认证功能。重写相关的Shiro过滤器，以支持验证码和记住我选项。在相关的Shiro过滤器之后，使用自己的过滤器，简单地利用Shiro的会话管理功能，管理会话属性。

注意：未实现后台管理图书和用户的功能，目前方便进行图书管理和用户管理的方式，是使用数据库GUI(如DataGrip)。边写代码，边采集数据，一些记录采集不完全。