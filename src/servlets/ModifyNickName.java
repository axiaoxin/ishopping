package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.UserDB;
import utils.Utils;
import beans.User;

public class ModifyNickName extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ModifyNickName() {
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
		UserDB db = new UserDB();
		Utils utils = new Utils();
		int id = Integer.parseInt(request.getParameter("id"));
		String username = request.getParameter("username");
		String path = request.getContextPath();


		if(utils.exist_username(username)){
			request.getSession().setAttribute("msg","昵称已被使用");
			response.sendRedirect(path+"/templates/usercenter.jsp");
			return;
		}else{
			db.modify_username(id, username);
			User user = new User();
			user = db.get_by_id(id);
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("msg","昵称修改成功");
			response.sendRedirect(path+"/templates/usercenter.jsp");
		}

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
