<%@ page language="java" import="java.util.*, beans.*, utils.*" pageEncoding="UTF-8"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sort_type = request.getParameter("SortType");
GoodsDB goods_db = new GoodsDB();
TypeDB	type_db = new TypeDB();
ArrayList<Goods> all_goods = goods_db.get_all_goods();
int intPageSize;
int intRowCount;
int intPageCount;
int intPage;
String strPage;

intPageSize = 9;
strPage = request.getParameter("page");
if (strPage==null)
{
	intPage = 1;
}
else {
	intPage = Integer.parseInt(strPage);
	if (intPage < 1) intPage = 1;
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
              <li class="active"><a href="">首页</a></li>
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

        <div id="shopping-options">
            <span class="btn-group">
              <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                                                                    商品分类
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
              <li><a href="<%=path%>">全部分类</a></li>
              <% 
                if (type_db.get_all_types() != null){
                    ArrayList<Type> all_types = type_db.get_all_types();
                    for(int i=0; i < all_types.size(); ++i)
                    {
                        Type type = new Type();
                        type = all_types.get(i);
              %>
               <li><a href="<%=path%>/index.jsp?SortType=<%=type.getType_name()%>"><%=type.getType_name()%></a></li>
               <%}
               } %>
              </ul>
            </span>
            <!-- <span class="btn-group">
              <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                                                        排序
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
               <li><a href="">按时间排序</a></li>
               <li><a>按价格排序</a></li>
               <li><a>按人气排序</a></li>
              </ul>
            </span> -->
        </div>

        <div class="row">
            <div class="span12">
              <ul class="thumbnails">
              <% 
                ArrayList<Goods> goodsList = null;
                ArrayList<Goods> searchList = (ArrayList<Goods>)session.getAttribute("SearchByName");
                session.removeAttribute("SearchByName");
                if (searchList != null)
                {
                	 goodsList = searchList;
                }
              	else if (sort_type!=null)
              	{
              		goodsList = goods_db.get_type_goods(new String(sort_type.getBytes("iso-8859-1"), "utf-8"));
                }
                else if (all_goods != null)
                {
                    goodsList = all_goods;
                }
                intRowCount = goodsList.size();
                intPageCount = (intRowCount+intPageSize-1) / intPageSize;
                if (intPage > intPageCount) intPage = intPageCount;
                
                if (intPageCount>0) {
                	int i=0;
                	int n = (intPage-1)*intPageSize;
                	while(i < intPageSize && (i+n)<intRowCount)
                	{
                		Goods goods = new Goods();
                    	goods = goodsList.get(i+n);
              %>
                <li class="span4">
                  <div class="well">
                      <h6><a href="<%=path%>/templates/detail.jsp?id=<%=goods.getId() %>"><%=goods.getItem_name()%></a></h6>
                      <a href="<%=path%>/templates/detail.jsp?id=<%=goods.getId() %>" class="thumbnail"  rel="tooltip" data-original-title="点击查看详情">
                        <img src="<%=goods.getPics().get(0) %>" alt="" width=320 height=210>
                      </a>
                      <small>
                        <span title="售价"><i class="icon-shopping-cart icon-white"></i> ￥<%=goods.getItem_price() %></span> &nbsp;&nbsp;&nbsp; 
                        <span title="库存量"><i class="icon-inbox icon-white"></i> <%=goods.getItem_count() %></span> &nbsp;&nbsp;&nbsp; 
                        <span title="人气"><i class="icon-heart icon-white"></i> <%=goods.getSales() %></span>
                      </small>
                  </div>
                </li>
                <%i++;}
                }
                %>
              </ul>
            </div><!-- span12 -->
        </div><!-- row -->
        
        <div class="row">
            <div class="span12">
                <div class="pull-right">
                    <ul class="pager">
                          <li>
                          <% if (intPage>1) {%>
                          <a href="<%=path%>/index.jsp?page=<%=intPage-1%>">上一页</a>
                          <% }else {%>
                          	上一页
                          	<%} %>
                          </li>
                        <li >第<%=intPage%>页</li>
                        <li>共<%=intPageCount%>页</li>
                          <li>
                          <% if (intPage < intPageCount) { %>
                          <a href="<%=path%>/index.jsp?page=<%=intPage+1%>">下一页</a>
                          <%}else{ %>
                          	下一页
                          	<%} %>
                          </li>
                    </ul>
                </div><!--pagination-->
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
