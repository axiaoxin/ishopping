<%@ page language="java" import="java.util.*, beans.*, utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user=(User)session.getAttribute("user");
if(user==null){
    session.setAttribute("msg", "请先登录");
    response.sendRedirect(path);
    return;
}

OrderDB order_db = new OrderDB();
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
    <script src="<%=path%>/js/jquery.js"></script>
    <script src="<%=path%>/js/bootstrap.js"></script>
    <script src="<%=path%>/js/application.js"></script>
    <script src="<%=path%>/js/tooltip.js"></script>
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
              <li><a href="<%=path%>">首页</a></li>
              <li><a href="<%=path%>/templates/about.jsp">关于</a></li>
              <%if (session.getAttribute("user_goods_ids") != null) {%>
              <li><a href="<%=path%>/templates/shoppingcar.jsp">购物车</a></li>
              <%} %>
              <li class="divider-vertical"></li>
              <form class="navbar-search" action="<%=path %>/servlet/SearchByName" method="post">
                <input id="id_search" name="search" type="text" class="input-medium search-query">
                <button type="submit" class="btn">搜索</button>
              </form>
              <%
                if(session.getAttribute("user")==null){
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
                user = (User)session.getAttribute("user");
              %>
              <div style="margin:8px;" class="pull-right">
                <small>欢迎光临，<a href="<%=path %>/templates/usercenter.jsp" title="个人中心"><%=user.getUsername() %></a> 上帝~ | <a href="<%=path %>/servlet/Logout" title="退出本次登录">注销</a></small>
              </div>
              <%} %>
            </ul>
        </div><!-- subnav -->
  
        <div class="row">
            <div class="span12">
              <div class="well">
                <div class="tabbable" style="margin-bottom: 9px;">
                    <ul class="nav nav-tabs">
                      <li class="active"><a href="#1" data-toggle="tab">我的订单</a></li>
                      <li><a href="#2" data-toggle="tab">个人资料</a></li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane active" id="1">
                        <% 
                            if (order_db.get_user_orders(user.getEmail()).size() != 0){
                                ArrayList<Order> orders = order_db.get_user_orders(user.getEmail());
                        %>
                        <table class="table table-condensed table-striped table-bordered">
                        
                                <thead>
                                    <tr>
                                       <th>订单号</th>
                                       <th>商品货号</th>
                                       <th>购买数量</th>
                                       <th>收货人</th>
                                       <th>收货地址</th>
                                       <th>邮编</th>
                                       <th>电话</th>
                                       <th>是否发货</th>
                                       <th>操作</th>
                                    </tr>
                                    
                                </thead>
                                <tbody>
                            <%
                                            for(int i=0; i < orders.size(); ++i)
                                            {
                                                Order order = new Order();
                                                order = orders.get(i);
                                      %>
                                    <tr>
                                        <td><%=order.getId() %></td>
                                        <td><%=order.getGoods_id() %></td>
                                        <td><%=order.getHow_many() %></td>
                                        <td><%=order.getWho() %></td>
                                        <td><%=order.getAddr() %></td>
                                        <td><%=order.getCode() %></td>
                                        <td><%=order.getCall() %></td>
                                        <td><%=order.isIs_ok() %></td>
                                        <%if (!order.isIs_ok()) {%>
                                        <td>
                                        <a class="btn btn-warning" href="<%=path %>/servlet/DeleteOrder?id=<%=order.getId() %>" title="取消订单">取消订单</a> 
                                        </td>
                                        <%}else {%>
                                            <%if(!order.isReceive()) {%>
                                            <td><a class="btn btn-info" href="<%=path %>/servlet/ReceiveGoods?id=<%=order.getId() %>" title="确认收货">确认收货</a></td>
                                            <%}else{ %>
                                            <td><a class="btn btn-success disabled " href="javascript:void(0)" title="已收货">已经收货</a></td>
                                            <%} %>
                                        <%} %>
                                    </tr>
                                    
                                        <%} 
                                         %>
                                         </tbody>
                        </table>
                        <%
                         }else{%>
                            没有订单记录
                        <%} %>
                      </div>
                      <div class="tab-pane" id="2">
                          
                          <form method="post" action="<%=path %>/servlet/ModifyPassword?id=<%=user.getId() %>" class="form-inline well pull-right">
                            <fieldset>
                                <legend>修改密码</legend>
                                <div>
                                    <p><label for="id_old_password">旧的密码:</label> <input id="id_old_password" type="password" name="old_password" maxlength="16" minlength="6" required placeholder="请填写您的登录密码" /></p>
                                    <p><label for="id_password1">新的密码:</label> <input id="id_password1" type="password" name="password1" maxlength="16" minlength="6" required placeholder="请填写新的登录密码" /></p>
                                    <p><label for="id_password2">确认密码:</label> <input id="id_password2" type="password" name="password2" maxlength="16" minlength="6" required placeholder="请确认您的登录密码" /></p>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">修改昵称</button>
                                </div>
                            </fieldset>
                          </form>
                          <form method="post" action="<%=path %>/servlet/ModifyNickName?id=<%=user.getId() %>" class="form-inline well">
                            <fieldset>
                                <legend>修改昵称</legend>
                                <div>
                                    <p><label for="id_email">登录邮箱:</label> <input type="email" name="email" id="id_email" maxlength="45" required value="<%=user.getEmail() %>" disabled="disabled"/></p>
                                    <p><label for="id_reg_time">注册时间:</label> <input type="text" name="reg_time" id="id_reg_time" maxlength="45" required value="<%=user.getReg_time() %>" disabled="disabled"/></p>
                                    <p><label for="id_username">用户昵称:</label> <input id="id_username" type="text" name="username" minlength="2" maxlength="9" required value="<%=user.getUsername() %>" /></p>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">修改昵称</button>
                                </div>
                            </fieldset>
                          </form>
                      </div>
                    </div>
                  </div> <!-- /tabbable -->
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
    <%
    if(session.getAttribute("msg") != null){
    %>
        <script>alert("<%=session.getAttribute("msg") %>");</script>    
    <%
        session.removeAttribute("msg");
    } 
    %>
  </body>
</html>