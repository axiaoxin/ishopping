<%@ page language="java" import="java.util.*, beans.*,utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int id = Integer.parseInt(request.getParameter("id"));
GoodsDB goods_db = new GoodsDB();
Goods goods = new Goods();
goods = goods_db.get(id);
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

        <header class="jumbotron subhead" id="overview">
          <div class="row">
            <div class="span6">
              <h4><%=goods.getItem_name() %></h4>
              <p class="lead"></p>
            </div>
          </div>
        </header>
        
        <div class="row">
            <div class="span7">
                <div id="myCarousel" class="carousel slide well">
                    <div class="carousel-inner">
                    <% ArrayList<String> pics = goods.getPics(); 
                       ArrayList<String> descs = goods.getPics_desc();
                       if (pics != null){
                       for (int j=0; j<pics.size();j++) {
                       if (j==0){
                    %>
                      <div class="item active">
                        <img src="<%=pics.get(j) %>" alt="" width=700 height=556>
                        <div class="carousel-caption">
                          <h4><%=descs.get(j) %></h4>
                          <p><small>IShopping - 爱&middot;瞎&middot;拼 独家专卖  Orz~</small></p>
                        </div><!-- carousel-cartion -->
                      </div><!-- item -->
                      <%
                      }else{
                      %>
                      <div class="item">
                        <img src="<%=pics.get(j) %>" alt="" width=700 height=556>
                        <div class="carousel-caption">
                          <h4><%=descs.get(j) %></h4>
                          <p><small>IShopping - 爱&middot;瞎&middot;拼 独家专卖  Orz~</small></p>
                        </div><!-- carousel-cartion -->
                      </div><!-- item -->
                      <%
                      }
                      }
                      }
                      %> 
                    </div><!-- carousel-inner -->
                    <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                    <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
                </div><!-- myCarousel -->
            </div><!-- span7 -->
            <div class="span5">
                <div class="well">
                    <table class="table table-striped table-bordered table-condensed">
                        <caption><h3>商品参数</h3></caption>
                        <tbody>
                          <tr>
                            <td>名称</td>
                            <td><%=goods.getItem_name() %></td>
                          </tr>
                          <tr>
                            <td>所属分类</td>
                            <td><%=goods.getItem_type() %></td>
                          </tr>
                          <tr>
                            <td>品牌</td>
                            <td><%=goods.getItem_brand() %></td>
                          </tr>
                          <tr>
                            <td>货号</td>
                            <td>No.<%=goods.getId() %></td>
                          </tr>
                          <tr>
                            <td>适用人群</td>
                            <td><%=goods.getItem_sex() %></td>
                          </tr>
                          <tr>
                            <td>上架时间</td>
                            <td><%=goods.getPub_time() %></td>
                          </tr>
                          <tr>
                            <td>售价</td>
                            <td>￥<%=goods.getItem_price() %></td>
                          </tr>
                          <tr>
                            <td>颜色</td>
                            <td><%=goods.getItem_color() %></td>
                          </tr>
                          <tr>
                            <td>尺码</td>
                            <td><%=goods.getItem_size() %></td>
                          </tr>
                          <tr>
                            <td>销量</td>
                            <td><%=goods.getSales() %></td>
                          </tr>
                          <tr>
                            <td>库存量</td>
                            <td><%=goods.getItem_count() %></td>
                          </tr>
                        </tbody>
                    </table>
                </div><!-- well -->
                <div class="well">
                    <form action="<%=path %>/templates/order.jsp" method="post">
                    <input type="hidden" name="id" value="<%=goods.getId()%>">
                                                                     购买数量：<input type="number" class="input-mini" name="how_many" min="1" max="<%=goods.getItem_count()%>" value="1" id="id_how_many">
                    <button type="submit" class="btn btn-middle btn-primary" style="margin-bottom:8px;"><i class="icon-heart icon-white"></i> 立即购买</button>
                    </form>
                    <form action="<%=path %>/servlet/AddToCar" method="post">
                    <input type="hidden" name="id" value="<%=goods.getId()%>">
                                                                     加入数量：<input type="number" class="input-mini" name="how_many" min="1" max="<%=goods.getItem_count()%>" value="1" id="id_how_many">
                    <button type="submit" class="btn btn-middle btn-inverse" style="margin-bottom:8px;"><i class="icon-shopping-cart icon-white"></i> 加入购物车</button>
                    </form>
                </div>
            </div><!-- span5 -->
        </div><!-- row -->
        <!-- Duoshuo Comment BEGIN -->
        <div class="row">
        <div class="ds-thread span12"></div>
            <script type="text/javascript">
                var duoshuoQuery = {short_name:"ishopping"};
                (function() {
                    var ds = document.createElement('script');
                    ds.type = 'text/javascript';ds.async = true;
                    ds.src = 'http://static.duoshuo.com/embed.js';
                    ds.charset = 'UTF-8';
                    (document.getElementsByTagName('head')[0] 
                    || document.getElementsByTagName('body')[0]).appendChild(ds);
                })();
            </script>
        </div>
        <!-- Duoshuo Comment END -->
        
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
    <script src="<%=path%>/js/carousel.js"></script>
    
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