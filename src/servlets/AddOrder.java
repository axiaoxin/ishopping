package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.OrderDB;
import beans.User;

public class AddOrder extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public AddOrder() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		User user = (User)request.getSession().getAttribute("user");
		Map<Integer, Integer> user_goods_ids = new HashMap<Integer, Integer>();
		OrderDB order_db = new OrderDB();
		if(request.getSession().getAttribute("user_goods_ids")==null){
			int goods_id = Integer.parseInt(request.getParameter("id"));
			int how_many = Integer.parseInt(request.getParameter("how_many"));
			user_goods_ids.put(goods_id, how_many);
			String who = request.getParameter("who");
			String addr = request.getParameter("addr");
			String code = request.getParameter("code");
			String call = request.getParameter("call");
			order_db.add(user_goods_ids, who, addr, code, call, user.getEmail());
			request.getSession().setAttribute("msg", "成功提交订单");
			
		}else{
			user_goods_ids = (Map<Integer, Integer>)request.getSession().getAttribute("user_goods_ids");
			String who = request.getParameter("who");
			String addr = request.getParameter("addr");
			String code = request.getParameter("code");
			String call = request.getParameter("call");
			request.getSession().removeAttribute("user_goods_ids");
			order_db.add(user_goods_ids, who, addr, code, call, user.getEmail());
			request.getSession().setAttribute("msg", "成功提交订单");
		}
		String path = request.getContextPath();
		response.sendRedirect(path+"/templates/shoppingcar.jsp");
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
