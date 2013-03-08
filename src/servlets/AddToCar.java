package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddToCar extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public AddToCar() {
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

		Map<Integer, Integer> user_goods_ids = new HashMap<Integer, Integer>();
		
		if(null == request.getSession().getAttribute("user_goods_ids")){
			int goods_id = Integer.parseInt(request.getParameter("id"));
			int how_many = Integer.parseInt(request.getParameter("how_many"));
			user_goods_ids.put(goods_id, how_many);
			request.getSession().setAttribute("user_goods_ids", user_goods_ids);
		}
		else{
			user_goods_ids = (HashMap<Integer, Integer>)request.getSession().getAttribute("user_goods_ids");
			int goods_id = Integer.parseInt(request.getParameter("id"));
			int how_many = Integer.parseInt(request.getParameter("how_many"));
			user_goods_ids.put(goods_id, how_many);
			request.getSession().setAttribute("user_goods_ids", user_goods_ids);
		}
		
		request.getSession().setAttribute("msg", "已加入到购物车！");
		response.sendRedirect(request.getHeader("Referer"));
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
