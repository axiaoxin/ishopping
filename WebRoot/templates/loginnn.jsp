<%@ page language="java" import="java.util.*, beans.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

User user=(User)session.getAttribute("admin");
if(user != null){
    response.sendRedirect(path+"/templates/adminnn.jsp");  
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
        <title>IShopping 站点管理 | 登录</title>
        <link rel="stylesheet" href="<%=path%>/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%=path%>/css/style.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%=path%>/css/invalid.css" type="text/css" media="screen" />   
        
    </head>
  
    <body id="login">
        
        <div id="login-wrapper" class="png_bg">
            <div id="login-top">
            
                <h1>IShopping 站点管理</h1>
                <!-- Logo (221px width) -->
                <img id="logo" src="<%=path%>/img/logo.png" alt="Admin logo" />
            </div> <!-- End #logn-top -->
            
            <div id="login-content">
                
              <%
                if(request.getAttribute("msg") != null){
                %>
                    <div class="notification error png_bg">
                        <a href="#" class="close"><img src="<%=path %>/img/icons/cross_grey_small.png" title="关闭" alt="close" /></a>
                        <div>
                            <%=request.getAttribute("msg") %>
                        </div>
                    </div>   
                <%
                }
              %>
                <form action="<%=path%>/servlet/AdminLogin" method="post">
                    <p>
                        <label>邮 &nbsp; 箱</label>
                        <input class="text-input" name="email" type="email" maxlength="45" minlength="6" required placeholder="请填写您的登录邮箱" />
                    </p>
                    <div class="clear"></div>
                    <p>
                        <label>密  &nbsp; 码</label>
                        <input class="text-input" name="password" type="password" maxlength="16" minlength="6" required placeholder="请填写您的登录密码" />
                    </p>
                    <div class="clear"></div>
                    <p>
                        <input class="button" type="submit" value="登录" />
                    </p>
                    
                </form>
            </div> <!-- End #login-content -->
            
        </div> <!-- End #login-wrapper -->
        <script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/js/configuration.js"></script>
        
  </body>
  </html>
