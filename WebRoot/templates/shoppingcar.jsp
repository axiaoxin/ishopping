<%@ page language="java" import="java.util.*, beans.*, utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map<Integer, Integer> user_goods_ids = new HashMap<Integer, Integer>();
user_goods_ids = (Map<Integer, Integer>)session.getAttribute("user_goods_ids");
if (user_goods_ids == null){
    response.sendRedirect(path);
    return;
}
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
              <li class="active"><a href="<%=path%>/templates/shoppingcar.jsp">购物车</a></li>
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
                User user = (User)session.getAttribute("user");
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
                <table class="table table-condensed">
                    <caption><h3>购物车</h3></caption>
                  <thead>
                    <tr>
                       <th>商品货号</th>
                       <th>商品品牌</th>
                       <th>商品名称</th>
                       <th>购买数量</th>
                       <th>操作</th>
                    </tr>
                  </thead>
                  <tbody>
                  <%
                  Set<Integer> keys = user_goods_ids.keySet();
                  if(keys != null){
                      Iterator iter = keys.iterator();
                      GoodsDB goods_db = new GoodsDB();
                      Goods goods = new Goods();

                      while(iter.hasNext()) {
                        Object id = iter.next();
                        Object how_many = user_goods_ids.get(id);
                        goods = goods_db.get((Integer)id);
                  %>
                    <tr>
                      <td><%=goods.getId() %></td>
                      <td><%=goods.getItem_brand() %></td>
                      <td><%=goods.getItem_name() %></td>
                      <td><%=how_many %></td>
                      <td><a href="<%=path%>/servlet/DeleteFromCar?id=<%=id%>">删除</a></td>
                    </tr>
                  <%
                        }
                  } %>
                    
                    
                  </tbody>
                </table>
                
              </div>
              <div>
              <a href="<%=path %>/templates/order.jsp" class="btn btn-large btn-primary pull-right">立即结算</a>
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