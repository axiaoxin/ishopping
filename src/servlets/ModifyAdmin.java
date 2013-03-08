package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.User;

import utils.AdminDB;
import utils.Utils;

public class ModifyAdmin extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ModifyAdmin() {
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
		AdminDB admin_db = new AdminDB();
		Utils utils = new Utils();
		int id = Integer.parseInt(request.getParameter("id"));
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String old_password = request.getParameter("old_password");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		ArrayList<String> errors=new ArrayList<String>();
		
		User user = admin_db.get(admin_db.get_by_id(id).getEmail(), utils.crypt_password(old_password));
		if (user == null)
		{
			errors.add("原密码错误");
		}

		if (!utils.check_password(password1, password2)){
			errors.add("两次密码不一致");
		}
		if (!admin_db.get_by_id(id).getEmail().equals(email)){
			if(utils.exist_admin_email(email)){
				errors.add("邮箱已存在");
			}
		}
		if (!admin_db.get_by_id(id).getUsername().equals(username)){
			if(utils.exist_adminname(username)){
				errors.add("昵称已被使用");
			}
		}

		if (errors.size() != 0){
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/templates/adminnn.jsp").forward(request, response);
			return;
		}else{
			
			admin_db.modify(id, email, utils.crypt_password(password2), username);
			String path = request.getContextPath();
			response.sendRedirect(path+"/servlet/AdminLogin");
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
