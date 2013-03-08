package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.UserDB;
import utils.Utils;
import beans.User;

public class Login extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public Login() {
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
		Utils utils = new Utils();
		String path = request.getContextPath();

		if(request.getSession().getAttribute("user") != null){
			response.sendRedirect(path);
			return;
		}
		
		
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		if(password == null && email == null){
			response.sendRedirect(path);
			return;
		}
		UserDB user_db = new UserDB();
		User user = user_db.get(email, utils.crypt_password(password));

		if (user != null){
	        if(request.getSession().getAttribute("user") != null){
	        	request.getSession().removeAttribute("user");
	        }
	        if(null != request.getSession().getAttribute("SearchByName")){
				request.getSession().removeAttribute("SearchByName");
			}
			request.getSession().setAttribute("user", user);
		}else{
			request.getSession().setAttribute("msg", "邮箱或密码错误");
		}
		response.sendRedirect(request.getHeader("Referer"));
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
