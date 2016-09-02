package ldcc.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		if("login".equals(action)){
			doLogin(request,response);
		}
		else if("logout".equals(action)){
			doLogout(request,response);
		}
		else if("join".equals(action)){
			doJoin(request,response);
		}
		else if("user_withdraw".equals(action)){
			doUser_withdraw(request,response);
		}
		else if("user_info".equals(action)){
			doUser_info(request,response);
		}
		else if("user_info_modify".equals(action)){
			doUser_info_modify(request,response);
		}
		else if("user_list".equals(action)){
			doUser_list(request,response);
		}
			
	}

	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String result = "fail";
		UserDAO dao = new UserDAO();
		User user = new User();
		
		if(request.getParameter("user_id")!=null&request.getParameter("user_pw")!=null&request.getParameter("user_name")!=null&request.getParameter("user_phone")!=null&request.getParameter("user_email")!=null&request.getParameter("team_code")!=null)
		{
			user.setUser_id(request.getParameter("user_id"));
			user.setUser_pw(request.getParameter("user_pw"));
			user.setUser_accept(0);
			user.setTeam_code(Integer.parseInt(request.getParameter("team_code")));
			user.setUser_name(request.getParameter("user_name"));
			user.setUser_phone(request.getParameter("user_phone"));
			user.setUser_email(request.getParameter("user_email"));
			
			boolean flag = dao.doInsert(user);
			if(flag){
				result = user.getUser_name();
			}
			
		}
		else
		{
			System.out.println("형식을 모두 채워주세요");
		}
		
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
		
	}


	private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(true);
		session.invalidate();
		response.sendRedirect("login.jsp");
		
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
	
	
	private void doUser_withdraw(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserDAO dao = new UserDAO();
		User user = new User();
		
		if(request.getParameter("user_pw")!=null)
		{
			user.setUser_id(request.getParameter("user_id"));
			user.setUser_pw(request.getParameter("user_pw"));

			boolean flag = dao.doWithdraw(user);

			if(flag == true)
			{
				System.out.println("회원탈퇴 성공, 로그아웃 합니다.");
				doLogout(request,response);
			}
			else
			{
				System.out.println("회원탈퇴 실패");
			}
		}
		else
		{
			System.out.println("비밀번호를 입력해 주세요.");
		}
//		String result = "fail";
//		if(user.getUser_name()!=null){
//			result = user.getUser_name();
//		}
		
//		request.setAttribute("result", result);
//		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
//		dispatcher.forward(request, response);
	}

	
	private void doUser_list(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doUser_info_modify(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	private void doUser_info(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


	
}
