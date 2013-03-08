package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.GoodsDB;

public class AddGoods extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public AddGoods() {
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
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
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
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		//PrintWriter out = response.getWriter();


		String item_name = request.getParameter("item_name");
		String item_brand = request.getParameter("item_brand");
		int item_price = Integer.parseInt(request.getParameter("item_price"));
		int item_count = Integer.parseInt(request.getParameter("item_count"));
		String item_type = request.getParameter("item_type");
		String item_sex = request.getParameter("item_sex");
		String item_color = request.getParameter("item_color");
		String item_size = request.getParameter("item_size");
		String [] pics = request.getParameterValues("pic");
		String [] pics_desc = request.getParameterValues("pic-desc");

		GoodsDB goods_db = new GoodsDB();
		goods_db.add(item_name, item_brand, item_price, item_count, item_type, item_sex, item_color, item_size, pics, pics_desc);
		String path = request.getContextPath();
		response.sendRedirect(path+"/templates/adminnn.jsp");
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
