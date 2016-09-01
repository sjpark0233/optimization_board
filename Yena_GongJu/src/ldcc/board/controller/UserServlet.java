package ldcc.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ldcc.board.dao.UserDAO;
import ldcc.board.vo.User;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserServlet() {
        super();
     }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if(action == "login"){
			doLogin(request,response);
		}
		else if(action == "logout"){
			doLogout(request,response);
		}
		else if(action == "join"){
			doJoin(request,response);
		}
		else if(action == "user_withdraw"){
			doUser_withdraw(request,response);
		}
		else if(action == "user_info"){
			doUser_info(request,response);
		}
		else if(action == "user_info_modify"){
			doUser_info_modify(request,response);
		}
		else if(action == "user_list"){
			doUser_list(request,response);
		}
			
	}


	private void doUser_list(HttpServletRequest request, HttpServletResponse response) {
		
		
	}


	private void doUser_info_modify(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doUser_info(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doUser_withdraw(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doJoin(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doLogout(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		User user = new User();
		
		user.setUser_id(request.getParameter("user_id"));
		user.setUser_pw(request.getParameter("user_pw"));
		
		dao.doLogin(user);
		String result = "fail";
		if(user.getUser_name()!=null){
			result = user.getUser_name();
		}
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
	}

}
