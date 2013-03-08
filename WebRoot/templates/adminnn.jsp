<%@ page language="java" import="java.util.*, beans.*, utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

if(session.getAttribute("admin")==null){  
 response.sendRedirect(path+"/templates/loginnn.jsp");
 return;
}
User user=(User)session.getAttribute("admin");

TypeDB type_db = new TypeDB();
GoodsDB goods_db = new GoodsDB();
AdminDB admin_db = new AdminDB();
UserDB user_db = new UserDB();
OrderDB order_db = new OrderDB();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        
        <title>IShopping 站点管理</title>
        <link rel="stylesheet" href="<%=path%>/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%=path%>/css/style.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%=path%>/css/invalid.css" type="text/css" media="screen" />
    </head>
  
    <body>
    
    <div id="body-wrapper"> 
        
        <div id="sidebar">
        
          <div id="sidebar-wrapper">
            
            <h1 id="sidebar-title"><a href="#">IShopping 站点管理</a></h1>
          
            <!-- Logo (221px wide) -->
            <a href="#"><img id="logo" src="<%=path%>/img/logo.png" alt="Admin logo" /></a>
          
            <!-- Sidebar Profile links -->
            <div id="profile-links">
                Hello, <%=user.getUsername() %><br />
                <br />
                <a href="<%=path%>" title="返回网站首页">返回IShopping</a> | <a href="<%=path %>/servlet/AdminLogout" title="注销登录">注销</a>
            </div>        
            
            <ul id="main-nav"> 
                <li> 
                    <a href="#" class="nav-top-item">
                                                                      商品
                    </a>
                    <ul>
                        <li><a href="#" id="id_nav_add_item_button">添加新商品</a></li>
                        <li><a href="#" id="id_nav_manage_item_button">管理商品</a></li> <!-- Add class "current" to sub menu items also -->
                        <li><a href="http://ishopping.duoshuo.com/admin/" target="_blank">管理评论</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#" class="nav-top-item">
                                                                      分类
                    </a>
                    <ul>
                        <li><a href="#" id="id_nav_add_type_button">添加分类</a></li>
                        <li><a href="#" id="id_nav_manage_type_button">管理分类</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#" class="nav-top-item">
                                                                      订单
                    </a>
                    <ul>
                        <li><a href="#" id="id_nav_manage_order_button">处理订单</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#" class="nav-top-item">
                                                                      管理员
                    </a>
                    <ul>
                        <li><a href="#" id="id_nav_add_admin_button">添加管理员</a></li>
                        <li><a href="#" id="id_nav_manage_admin_button">管理帐号</a></li>
                    </ul>
                </li>
                
                <li>
                    <a href="#" class="nav-top-item">
                                                                      用户
                    </a>
                    <ul>
                        <li><a href="#" id="id_nav_manage_user_button">管理用户</a></li>
                    </ul>
                </li>
                
            </ul> <!-- End #main-nav -->
          </div>
        </div> <!-- End #sidebar -->
        
        <div id="main-content"> 
            
            <!-- Page Head -->
            <h2>热烈欢迎<%=user.getUsername() %>老板的到来~</h2>
            <p id="page-intro">老板，您想做些什么呢??</p>
            
            <ul class="shortcut-buttons-set">
                
                <li><a class="shortcut-button" href="#" id="id_add_item_button"><span>
                    <img src="<%=path%>/img/icons/pencil_48.png" alt="icon" /><br />
                                                                      添加新商品
                </span></a></li>
                
                <li><a class="shortcut-button" href="#" id="id_add_type_button"><span>
                    <img src="<%=path%>/img/icons/type.png" alt="icon" /><br />
                                                                        添加分类
                </span></a></li>
                
                <li><a class="shortcut-button" href="#" id="id_add_img_button" onClick="javascript:void(function(){var d = document,a = 'setAttribute',s = d.createElement('script');s[a]('tyle','text/javascript');s[a]('src','<%=path %>/js/uploadpic.js');d.head.appendChild(s);})();" ><span>
                    <img src="<%=path%>/img/icons/image_add_48.png" alt="icon" /><br />
                                                                      上传图片
                </span></a></li>
                
                
            </ul><!-- End .shortcut-buttons-set -->
            
            <div class="clear"></div> <!-- End .clear -->
            <div id="content">
                <div class="" id="id_all_items" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="">
                        <h3>所有商品</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="">
                        
                        <div class="tab-content default-tab">
                            <table>
                                
                                <thead>
                                    <tr>
                                       <th>名称</th> <th>品牌</th> <th>货号</th>  <th>售价</th>
                                       <th>总量</th>  <th>分类</th>  <th>人群</th> <th>颜色</th>
                                       <th>尺码</th>  <th>图片</th> <th>操作</th>
                                    </tr>
                                    
                                </thead>
                             
                                <tbody>
                                    <% 
                                        if (goods_db.get_all_goods() != null){
                                            ArrayList<Goods> all_goods = goods_db.get_all_goods();
                                            for(int i=0; i < all_goods.size(); ++i)
                                            {
                                                Goods goods = new Goods();
                                                goods = all_goods.get(i);
                                      %>
                                    <tr>
                                        <form action="<%=path %>/servlet/ModifyGoods?id=<%=goods.getId() %>" method="post">
                                        <td><input value="<%=goods.getItem_name() %>" name="item_name" required/></td>
                                        <td><input value="<%=goods.getItem_brand() %>" name="item_brand" required/></td>
                                        <td><input value="<%=goods.getId() %>" name="id" required disabled="disabled"/></td>
                                        <td><input value="<%=goods.getItem_price() %>" name="item_price" required max="999999999"/></td>
                                        <td><input value="<%=goods.getItem_count() %>" name="item_count" required max="999999999"/></td>
                                        <td><select name="item_type" class="small-input">
                                                <option value="<%=goods.getItem_type() %>"><%=goods.getItem_type() %></option>
                                            <% 
                                                if (type_db.get_all_types() != null){
                                                    ArrayList<Type> types = type_db.get_all_types();
                                                    for(int k=0; k < types.size(); ++k)
                                                    {
                                                        Type type = new Type();
                                                        type = types.get(k);
                                                        if (!type.getType_name().equals(goods.getItem_type())){
                                              %>
                                                <option value="<%=type.getType_name() %>"><%=type.getType_name() %></option>
                                                <%}
                                                 }
                                                }
                                                 %>
                                            </select> </td>
                                        <td><select name="item_sex" class="small-input">
                                            <option value="<%=goods.getItem_sex() %>"><%=goods.getItem_sex() %></option>
                                            <option value="不限">不限</option>
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                            </select>
                                            </td>
                                        <td><select name="item_color" class="small-input">
                                            <option value="<%=goods.getItem_color() %>"><%=goods.getItem_color() %></option>
                                            <option value="红色">红色</option>
                                            <option value="橙色">橙色</option>
                                            <option value="黄色">黄色</option>
                                            <option value="绿色">绿色</option>
                                            <option value="青色">青色</option>
                                            <option value="蓝色">蓝色</option>
                                            <option value="紫色">紫色</option>
                                            <option value="-">-</option>
                                            </select></td>
                                        <td><select name="item_size" class="small-input">
                                            <option value="<%=goods.getItem_size() %>"><%=goods.getItem_size() %></option>
                                            <option value="S">S</option>
                                            <option value="M">M</option>
                                            <option value="L">L</option>
                                            <option value="XL">XL</option>
                                            <option value="XXL">XXL</option>
                                            <option value="-">-</option>
                                            </select>
                                        </td>
                                        <td>
                                            <p><a id="id_show_pics" href="javascript:void(0)">图片</a></p>
                                            <div id="id_the_pics" style="display:none;">
                                            <% ArrayList<String> pics = goods.getPics(); 
                                               ArrayList<String> descs = goods.getPics_desc();
                                              for (int j=0; j<pics.size();j++) {%>
                                            <p><label>图片</label><input value="<%=pics.get(j) %>" name="pic"/> <br><label>描述</label> <input value="<%=descs.get(j) %>" name="pic-desc"/></p><br>
                                            <%} %>
                                            </div>
                                        </td>
                                        <td>
                                            <!-- Icons -->
                                             <p><input type="submit" value="保存">
                                             <a href="<%=path %>/servlet/DeleteGoods?id=<%=goods.getId() %>" title="删除"><img src="<%=path%>/img/icons/cross.png" alt="删除" /></a> 
                                            </p>
                                        </td>
                                        </form>
                                    </tr>
                                    <%}
                                    } %>
                                </tbody>
                                
                            </table>
                            
                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box  id_all_items -->
                
                <div class="content-box" id="id_add_item" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>添加商品</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab" style="text-align:center;">
                            <form action="<%=path %>/servlet/AddGoods" method="post">
                            
                            <fieldset>
                                
                                <p>
                                    <label>商品名称</label>
                                    <input class="text-input small-input" type="text" id="id_item_name" name="item_name" required />
                                </p>
                                <p>
                                    <label>商品品牌</label>
                                    <input class="text-input small-input" type="text" id="id_item_brand" name="item_brand" required />
                                </p>
                                <p>
                                    <label>商品售价</label>
                                    <input class="text-input small-input" type="number" id="id_item_price" name="item_price" required max="999999999" />
                                </p>
                                <p>
                                    <label>商品总量</label>
                                    <input class="text-input small-input" type="number" id="id_item_count" name="item_count" required max="999999999" />
                                </p>
                                <p>
                                    <label>商品分类</label>              
                                    <select name="item_type" class="small-input">
                                    <% 
                                        if (type_db.get_all_types() != null){
                                            ArrayList<Type> types = type_db.get_all_types();
                                            for(int i=0; i < types.size(); ++i)
                                            {
                                                Type type = new Type();
                                                type = types.get(i);
                                      %>
                                        <option value="<%=type.getType_name() %>"><%=type.getType_name() %></option>
                                        <%}
                                        }
                                         %>
                                    </select> 
                                </p>
                                <p>
                                    <label>适用人群</label> 
                                    <select name="item_sex" class="small-input">
                                        <option value="不限">不限</option>
                                        <option value="男">男</option>
                                        <option value="女">女</option>
                                    </select> 
                                </p>
                                <p>
                                    <label>商品颜色</label>
                                    <select name="item_color" class="small-input">
                                        <option value="红色">红色</option>
                                        <option value="橙色">橙色</option>
                                        <option value="黄色">黄色</option>
                                        <option value="绿色">绿色</option>
                                        <option value="青色">青色</option>
                                        <option value="蓝色">蓝色</option>
                                        <option value="紫色">紫色</option>
                                        <option value="-">-</option>
                                    </select> 
                                </p>
                                <p>
                                    <label>商品尺码</label>
                                    <select name="item_size" class="small-input">
                                        <option value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                        <option value="XXL">XXL</option>
                                        <option value="-">-</option>
                                    </select> 
                                </p>
                                <p class="pic">
                                    <label>商品图片</label>
                                    <input class="text-input small-input" type="text" name="pic" required />
                                    <label>图片描述</label><input class="text-input small-input" type="text" name="pic-desc" required />
                                </p>
                                <p>
                                <a id="id_add_pic" style="cursor:pointer;">
                                 +增加一张图片
                                </a>
                                </p>
                                <p>
                                    <input class="button" type="submit" value="保存" />
                                </p>
                                
                            </fieldset>
                            
                            <div class="clear"></div><!-- End .clear -->
                            
                        </form>

                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box id_add_item -->
                
                <div class="content-box" id="id_add_type" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>添加分类</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab" style="text-align:center;">
                            <form action="<%=path %>/servlet/AddType" method="post">
                            
                            <fieldset>
                                
                                <p>
                                    <label>分类名称</label>
                                    <input class="text-input small-input" type="text" id="id_type_name" name="type_name" />
                                </p>
                                <p>
                                    <input class="button" type="submit" value="保存" />
                                </p>
                                
                            </fieldset>
                            
                            <div class="clear"></div><!-- End .clear -->
                            
                        </form>

                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box id_add_type -->
                
                
                <div class="content-box" id="id_all_types" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>所有分类</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab">
                            <table>
                                
                                <thead>
                                    <tr>
                                       <th>分类名称</th>
                                       <th>操作</th>
                                    </tr>
                                    
                                </thead>
                             
                                <tbody>
                                    <% 
                                        if (type_db.get_all_types() != null){
                                            ArrayList<Type> types = type_db.get_all_types();
                                            for(int i=0; i < types.size(); ++i)
                                            {
                                                Type type = new Type();
                                                type = types.get(i);
                                      %>
                                    <tr>
                                        <form action="<%=path %>/servlet/ModifyType?id=<%=type.getId() %>" method="post">
                                            <td><input type="text" name="type_name" value="<%=type.getType_name() %>"/></td>
                                            <td>
                                                <!-- Icons -->
                                                 <input type="submit" value="保存" />
                                                 <a href="<%=path %>/servlet/DeleteType?id=<%=type.getId() %>" title="删除"><img src="<%=path%>/img/icons/cross.png" alt="删除" /></a> 
                                            </td>
                                        </form>
                                    </tr>
                                    
                                        <%}
                                        }
                                         %>
                                </tbody>
                                
                            </table>
                            
                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box  id_all_items -->
                
               
                <div class="content-box" id="id_add_admin" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>添加管理员帐号</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab" style="text-align:center;">
                            <form action="<%=path %>/servlet/AddAdmin" method="post">
                            
                            <fieldset>
                                
                                <p>
                                    <label>登录邮箱</label>
                                    <input class="text-input small-input" type="email" id="id_email" name="email" required />
                                </p>
                                <p>
                                    <label>密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码</label>
                                    <input class="text-input small-input" type="password" id="id_password1" name="password1" required />
                                </p>
                                <p>
                                    <label>确认密码</label>
                                    <input class="text-input small-input" type="password" id="id_password2" name="password2" required />
                                </p>
                                <p>
                                    <label>昵 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 称</label>
                                    <input class="text-input small-input" type="text" id="id_name" name="username" required/>
                                </p>
                                <p>
                                    <input class="button" type="submit" value="保存" />
                                </p>
                                
                            </fieldset>
                            
                            <div class="clear"></div><!-- End .clear -->
                            
                        </form>

                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box id_add_admin -->
                
                
                <div class="content-box" id="id_all_admins" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>所有管理员帐号</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab">
                            <table>
                                
                                <thead>
                                    <tr>
                                       <th>邮箱</th>
                                       <th>昵称</th>
                                       <th>旧密码</th>
                                       <th>新密码</th>
                                       <th>确认密码</th>
                                       <th>操作</th>
                                    </tr>
                                    
                                </thead>
                             
                                <tbody>
                                    <% 
                                        if (admin_db.get_all_admins() != null){
                                            ArrayList<User> admins = admin_db.get_all_admins();
                                            for(int i=0; i < admins.size(); ++i)
                                            {
                                                User admin = new User();
                                                admin = admins.get(i);
                                      %>
                                    <tr>
                                        <form action="<%=path %>/servlet/ModifyAdmin?id=<%=admin.getId() %>" method="post">
                                            <td><input class="text-input small-input" type="text" name="email" value="<%=admin.getEmail() %>" required/></td>
                                            <td><input class="text-input small-input" type="text" name="username" value="<%=admin.getUsername() %>" required/></td>
                                            <td><input class="text-input small-input" type="text" name="old_password" placeholder="输入原来的密码"  required/></td>
                                            <td><input class="text-input small-input" type="text" name="password1" placeholder="修改资料必须重设密码"  required/></td>
                                            <td><input class="text-input small-input" type="text" name="password2" placeholder="请填写确认密码"  required/></td>
                                            
                                            <td>
                                                <!-- Icons -->
                                                 <input type="submit" value="保存" />
                                                 <a href="<%=path %>/servlet/DeleteAdmin?id=<%=admin.getId() %>" title="删除"><img src="<%=path%>/img/icons/cross.png" alt="删除" /></a> 
                                            </td>
                                        </form>
                                    </tr>
                                    
                                        <%}
                                        }
                                         %>
                                </tbody>
                                
                            </table>
                            
                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box  id_all_admins -->
                
                
                
                <div class="content-box" id="id_all_users" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>所有用户帐号</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab">
                            <table>
                                
                                <thead>
                                    <tr>
                                       <th>邮箱</th>
                                       <th>昵称</th>
                                       <th>操作</th>
                                    </tr>
                                    
                                </thead>
                             
                                <tbody>
                                    <% 
                                        if (user_db.get_all_users() != null){
                                            ArrayList<User> users = user_db.get_all_users();
                                            for(int i=0; i < users.size(); ++i)
                                            {
                                                User theuser = new User();
                                                theuser = users.get(i);
                                      %>
                                    <tr>
                                            <td><%=theuser.getEmail() %></td>
                                            <td><%=theuser.getUsername() %></td>
                                            <td>
                                                 <a href="<%=path %>/servlet/DeleteUser?id=<%=theuser.getId() %>" title="删除"><img src="<%=path%>/img/icons/cross.png" alt="删除" /></a> 
                                            </td>
                                    </tr>
                                    
                                        <%}
                                        }
                                         %>
                                </tbody>
                                
                            </table>
                            
                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box  id_all_users -->
                
                
                <div class="content-box" id="id_all_orders" style="display:none;"><!-- Start Content Box -->
                    
                    <div class="content-box-header">
                        <h3>所有订单</h3>
                    </div> <!-- End .content-box-header -->
                    
                    <div class="content-box-content">
                        
                        <div class="tab-content default-tab">
                            <table>
                                
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
                                        if (order_db.get_all_orders() != null){
                                            ArrayList<Order> orders = order_db.get_all_orders();
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
                                            <td>
                                            <a href="javascript:void(0)" title="发货" onClick="deal('<%=path%>', '<%=order.getId()%>');">发货</a> 
                                            </td>
                                    </tr>
                                    
                                        <%}
                                        }
                                         %>
                                </tbody>
                                
                            </table>
                            
                        </div> <!-- End #tab -->
                        
                    </div> <!-- content-box-content -->
                </div> <!-- content-box  id_all_orders -->
                
            </div><!-- content -->
            
            <div id="footer">
                <small> <!-- Remove this notice or replace it with whatever you want -->
                        &#169; Copyright 2012 IShopping
                </small>
            </div><!-- End #footer -->
            
        </div> <!-- End #main-content -->
        
    </div>
    
  
        <script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/js/configuration.js"></script>
    
                        <% 
                        if (request.getAttribute("errors") != null){
                            ArrayList errors = (ArrayList)request.getAttribute("errors");
                            for(int i=0; i < errors.size(); ++i)
                            {
                      %>
                                <script> 
                                   alert("<%=errors.get(i) %>");  
                                </script>
                      <%
                            }
                            request.removeAttribute("errors");
                        }
                      %>
    </body>
  

</html>
