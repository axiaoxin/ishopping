package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.UserDB;
import utils.Utils;
import beans.User;

public class Register extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public Register() {
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
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		//PrintWriter out = response.getWriter();
		Utils utils = new Utils();

		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		
		ArrayList<String> errors=new ArrayList<String>();
		if (!utils.check_password(password1, password2)){
			errors.add("密码不一致");
		}
		if (utils.exist_email(email)){
			errors.add("邮箱已被注册");
		}
		if (utils.exist_username(username)){
			errors.add("昵称已被使用");
		}

		if (errors.size() != 0){
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/templates/register.jsp").forward(request, response);
			return;
		}else{
			User user = new User();
			user.setUsername(username);
			user.setPassword(utils.crypt_password(password1));
			user.setEmail(email);
			UserDB user_db = new UserDB();
			user_db.add(user);
			user = user_db.get(email, utils.crypt_password(password1));
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("msg", "注册成功");
			response.sendRedirect(request.getHeader("Referer"));
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
