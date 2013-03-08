$(document).ready(function(){
	
	//Sidebar Accordion Menu:
		
		$("#main-nav li ul").hide(); // Hide all sub menus
		$("#main-nav li a.current").parent().find("ul").slideToggle("slow"); // Slide down the current menu item's sub menu
		
		$("#main-nav li a.nav-top-item").click( // When a top menu item is clicked...
			function () {
				$(this).parent().siblings().find("ul").slideUp("normal"); // Slide up all sub menus except the one clicked
				$(this).next().slideToggle("normal"); // Slide down the clicked sub menu
				$(this).toggleClass('current').parent().siblings().find('a').removeClass('current');
				return false;
			}
		);
		
		$("#main-nav li ul li a").click(
			function () {
				$(this).addClass('current').parent().siblings().find('a').removeClass('current');
				//return false;
			}
		);
		
		$("#main-nav li a.no-submenu").click( // When a menu item with no sub menu is clicked...
			function () {
				window.location.href=(this.href); // Just open the link instead of a sub menu
				return false;
			}
		); 

    // Sidebar Accordion Menu Hover Effect:
		
		$("#main-nav li .nav-top-item").hover(
			function () {
				$(this).stop().animate({ paddingRight: "25px" }, 200);
			}, 
			function () {
				$(this).stop().animate({ paddingRight: "15px" });
			}
		);

    //Minimize Content Box
		
		$(".content-box-header h3").css({ "cursor":"s-resize" }); // Give the h3 in Content Box Header a different cursor
		$(".closed-box .content-box-content").hide(); // Hide the content of the header if it has the class "closed"
		$(".closed-box .content-box-tabs").hide(); // Hide the tabs in the header if it has the class "closed"
		
		$(".content-box-header h3").click( // When the h3 is clicked...
			function () {
			  $(this).parent().next().toggle(); // Toggle the Content Box
			  $(this).parent().parent().toggleClass("closed-box"); // Toggle the class "closed-box" on the content box
			  $(this).parent().find(".content-box-tabs").toggle(); // Toggle the tabs
			}
		);

    // Content box tabs:
		
		$('.content-box .content-box-content div.tab-content').hide(); // Hide the content divs
		$('ul.content-box-tabs li a.default-tab').addClass('current'); // Add the class "current" to the default tab
		$('.content-box-content div.default-tab').show(); // Show the div with class "default-tab"
		
		$('.content-box ul.content-box-tabs li a').click( // When a tab is clicked...
			function() { 
				$(this).parent().siblings().find("a").removeClass('current'); // Remove "current" class from all tabs
				$(this).addClass('current'); // Add class "current" to clicked tab
				var currentTab = $(this).attr('href'); // Set variable "currentTab" to the value of href of clicked tab
				$(currentTab).siblings().hide(); // Hide all content divs
				$(currentTab).show(); // Show the content div with the id equal to the id of clicked tab
				return false; 
			}
		);

    //Close button:
		
		$(".close").click(
			function () {
				$(this).parent().fadeTo(400, 0, function () { // Links with the class "close" will close parent
					$(this).slideUp(400);
				});
				return false;
			}
		);

    // Alternating table rows:
		
		$('tbody tr:even').addClass("alt-row"); // Add class "alt-row" to even table rows

    // Check all checkboxes when the one in a table head is checked:
		
		$('.check-all').click(
			function(){
				$(this).parent().parent().parent().parent().find("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
			}
		);

		//content show
		$('#id_add_item_button, #id_nav_add_item_button').click(function(){
			$('#id_add_item').show().siblings().hide();
			$('#id_nav_add_item_button').addClass('current').parent().siblings().find('a').removeClass('current');
		});
		$('#id_add_item_button').click(function(){
			$('#id_nav_add_item_button').parent().parent().parent().find('a:first').addClass('current');
			$('#id_nav_add_item_button').parent().parent().parent().siblings().find('a').removeClass('current');
			$('#id_nav_add_item_button').parent().parent().parent().siblings().find('ul').slideUp("normal");
			$('#id_nav_add_item_button').parent().parent().slideDown("normal");
		});

		$('#id_nav_manage_item_button').click(function(){
			$('#id_all_items').show().siblings().hide();
		});
		
		$('#id_add_type_button, #id_nav_add_type_button').click(function(){
			$('#id_add_type').show().siblings().hide();
			$('#id_nav_add_type_button').addClass('current').parent().siblings().find('a').removeClass('current');
		});
		$('#id_add_type_button').click(function(){
			
			$('#id_nav_add_type_button').parent().parent().parent().find('a:first').addClass('current');
			$('#id_nav_add_type_button').parent().parent().parent().siblings().find('a').removeClass('current');
			$('#id_nav_add_type_button').parent().parent().parent().siblings().find('ul').slideUp("normal");
			$('#id_nav_add_type_button').parent().parent().slideDown("normal");
		});

		$('#id_nav_manage_type_button').click(function(){
			$('#id_all_types').show().siblings().hide();
		});
		
		$("#id_add_pic").click(function(){
			html = '<p class="pic"><label>商品图片</label><input class="text-input small-input" type="text" name="pic" required /> <label>图片描述</label><input class="text-input small-input" type="text" name="pic-desc" required /><a href="javascript:void(0)" class="del" style="font-size:small;">删除</a></p>';
			$('.pic:last').after(html);
			$('.del').click(function(){
			       $(this).parent().remove();	
			   });

		})
		$('#id_nav_manage_user_button').click(function(){
			$('#id_all_users').show().siblings().hide();
		});
		$('#id_nav_manage_admin_button').click(function(){
			$('#id_all_admins').show().siblings().hide();
		});
		$('#id_nav_add_admin_button').click(function(){
			$('#id_add_admin').show().siblings().hide();
		});
		$('#id_nav_manage_order_button').click(function(){
			$('#id_all_orders').show().siblings().hide();
		});
		$('#id_show_pics').click(function(){
			
			$('#id_the_pics').toggle();
		})
		
});
  

function deal(path, id){
	$.get(path+"/servlet/DealOrder", {'id':id}, function(data){
		alert(data);
	})
}
  
  