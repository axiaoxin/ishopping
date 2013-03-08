<%@ page language="java" import="java.util.*, beans.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>IShopping</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="description" content="ishopping is a site for shopping online">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap-responsive.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/docs.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/prettify.css">
    <link rel="shortcut icon" href="<%=path%>/img/favicon.jpg">
    <style type="text/css">
      body {
        padding-top: 30px;
        background:url("<%=path%>/img/bodybg.jpg") center top repeat fixed;
      }
    </style>
    <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
  </head>
  
  <body>
    <div class="container">
        <div class="hero-unit" style="background-image:url(<%=path%>/img/bannerbg.jpg);">
            <h1><a id="id_banner" href="<%=path %>" rel="tooltip" data-original-title="IShopping，地球人值得拥有~mia~" style="cursor:pointer;text-decoration:none;">IShopping  爱&middot;瞎&middot;拼</a></h1>
            <p>
                IShopping 可能是整个火星最牛逼最豪华最可靠的在线百货商店
            </p>
        </div><!-- hero -->
        
        <div class="subnav">
            <ul class="nav nav-pills">
              <li><a href="<%=path %>">首页</a></li>
              <li class="active"><a href="<%=path%>/templates/about.jsp">关于</a></li>
              <%if (session.getAttribute("user_goods_ids") != null) {%>
              <li><a href="<%=path%>/templates/shoppingcar.jsp">购物车</a></li>
              <%} %>
              <li class="divider-vertical"></li>
              <form class="navbar-search" action="<%=path %>/servlet/SearchByName" method="post">
                <input id="id_search" name="search" type="text" class="input-medium search-query">
                <button type="submit" class="btn">搜索</button>
              </form>
              <%
                User user=(User)session.getAttribute("user");
                if(user==null){
              %>
                <form class="form-inline" style="margin:3px;" action="<%=path %>/servlet/Login" method="post">
                <div class="pull-right">
                  <input id="id_email" name="email" type="email" class="input-medium" required placeholder="邮箱" rel="tooltip" data-original-title="请填写您的注册邮箱">
                  <input id="id_password" name="password" type="password" class="input-medium" required placeholder="密码" rel="tooltip" data-original-title="请填写您的登录密码">
                  <button type="submit" class="btn btn-primary">登录</button>
                  <a href="<%=path%>/templates/register.jsp" class="btn">注册</a>
                    </div>
                </form>
              
              <%
                }else{
              %>
              <div style="margin:8px;" class="pull-right">
                <small>欢迎光临，<a href="<%=path %>/templates/usercenter.jsp" title="个人中心"><%=user.getUsername() %></a> 上帝~ | <a href="<%=path %>/servlet/Logout" title="退出本次登录">注销</a></small>
              </div>
              <%} %>
            </ul>
        </div><!-- subnav -->


        <div class="row">
            <div class="span12">
                <div>
                    <object style="display: block; margin-left: auto; margin-right: auto;" width="100%" height="200" data="http://ashin.sinaapp.com/welcome_medias/clock.swf" type="application/x-shockwave-flash"><param name="src" value="http://ashin.sinaapp.com/welcome_medias/clock.swf" /></object>
                </div>
                <div class="well">
                    <p>我们来自于火星，为地球人提供最优质的火星百货~支持货到付款，“谁会注意和谐号”专业物流，急速为你送达货物~</p>
                    <p>好吧，说点正经的~IShopping由成都信息工程学院软工102班阿小信大人和alex-lin共同开发~该网站为我们“web企业应用软件”的课程设计作业~</p>
                    <p>阿小信大人负责网页设计，alex-lin负责数据库设计，jsp代码两人共同编写~分工明确，配合完美~作业版权，严禁抄袭，否则凌迟处死~</p>
                    <p>在此，我们特别感谢为我们讲授“web企业应用软件”这门课的胡道海老师，这是一位认真负责，学院所有老师公认技术最强的老师，谢谢您的指导~</p>
                    <hr>
                    <p>关于阿小信大人</p>
                    <p>
                                                                                阿小信大人来自CUIT软件工程学院2010级2班~<br>
                                                                                喜欢使用python，linux，vim。对java无爱，c++亦无爱~<br>
                                                                               细叶抽轻翠，圆花簇嫩黄。菊蕊独盈枝，虽枯不改香。<br>
                      ---没错，我就是三叶草小组的阿小信学姐~mia~<br>
                                                                               欢迎访问<a href="http://ashin.sinaapp.com/blog/" target="_blank">阿小信的个人博客</a>，欢迎关注<a href="http://weibo.com/minisnakeashin" target="_blank">阿小信的新浪微博</a>
                    </p>
                    <hr>
                    <p>关于alex-lin</p>
                    <p>alex-lin来自CUIT软件工程学院2010级2班~<br>
                                                                                喜欢使用c++,最近钟爱c#，仙剑迷，win8开发者，苹果粉~<br>
                      ---没错，我就是CUIT6413智能信息处理实验室的林妹妹~<br>
                                                                            欢迎访问<a href="http://tearsinstars.diandian.com/" target="_blank">alex-lin的点点博客</a>，欢迎关注<a href="http://weibo.com/iwillcomeback" target="_blank">alex-lin的新浪微博</a>
                </div>
            </div><!-- span12 -->
        </div><!-- row -->
        
        
        <hr class="soften">
        <div class="row">
            <div class="span4">
                    <h3>关于 IShopping</h3>
                    <p><small>IShopping由成都信息工程学院软工102班阿小信大人和alex-lin开发~<br>我们来自于火星，服务于地球，为可怜的地球人提供在线选购百货的天堂~<br>IShopping - 爱瞎拼， 地球人都知道~mia~</small></p>
            </div><!-- span4 -->
            <div class="span4">
                <h3>浏览器支持</h3>
                <p><small>我们尽量兼容以下主流浏览器，IE是什么，可以吃吗?</small></p>
                <img src="<%=path%>/img/browser_logos.png" width="280" height="52" alt="Tested and supported in Chrome and Firefox">
                <ul>
                    <li>Latest Safari</li>
                    <li>Latest Google Chrome</li>
                    <li>Firefox 4+</li>
                    <li>Opera 11</li>
                </ul>
            </div><!-- span4 -->
            <div class="span4">
                <h3>友情链接</h3>
                <p>A life without a friend is a life without a sun.</p>
                <ul>
                    <li><a href="http://ashin.sinaapp.com" target="_blank">AshIn's Site</a></li>
                    <li><a href="http://tearsinstars.diandian.com/" target="_blank">alex-lin's blog</a></li>
                    <li><a href="http://tech.cuit.edu.cn" target="_blank">三叶草小组</a></li>
                    <li><a href="http://iip.cuit.edu.cn/iip/" target="_blank">智能信息处理实验室</a></li>
                </ul>
            </div><!-- span4 -->
        </div><!-- row -->
        
        <div id="footer"  style="background-image:url(<%=path%>/img/footerbg.jpg);">
            <a href="<%=path%>/templates/loginnn.jsp" title="秘密洞穴" style="color:black;"><small>盘丝洞</small></a> 
            <span class="pull-right">ashin.myclover@gmail.com&nbsp;&nbsp;&copy; 2012 <a href="#" title="IShopping">IShopping</a></span>
        </div><!-- footer -->
    </div><!-- container -->
    
    
    <script src="<%=path%>/js/jquery.js"></script>
    <script src="<%=path%>/js/bootstrap.js"></script>
    <script src="<%=path%>/js/application.js"></script>
    <script src="<%=path%>/js/tooltip.js"></script>
    
  </body>
</html>