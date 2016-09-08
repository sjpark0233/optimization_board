package ldcc.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
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
		System.out.println(action);
		
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
		else if("user_info2".equals(action)){
			doUser_info2(request,response);
		}
		else if("user_info_modify".equals(action)){
			doUser_info_modify(request,response);
		}
		else if("user_list".equals(action)){
			doUser_list(request,response);
		}
		else if("user_accept".equals(action)){
			doUser_accept(request,response);
		}
		else if("team_accept".equals(action)){
			doTeam_accept(request,response);
		}
		else if("user_check".equals(action)){
			doUser_check(request,response);
		}
			
	}

	
	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		User user = new User();
		String resultJson;
		
		if(request.getParameter("user_id")!=null&&request.getParameter("user_pw")!=null&&request.getParameter("user_name")!=null&&request.getParameter("user_phone")!=null&&request.getParameter("user_email")!=null&&request.getParameter("team_name")!=null)
		{
			user.setUser_id(request.getParameter("user_id"));
			user.setUser_pw(request.getParameter("user_pw"));
			user.setUser_accept(0);
			user.setTeam_name(request.getParameter("team_name"));
			user.setUser_name(request.getParameter("user_name"));
			user.setUser_phone(request.getParameter("user_phone"));
			user.setUser_email(request.getParameter("user_email"));
			
			boolean flag = dao.doInsert(user);
			if(flag){
				resultJson = "{ \"success\" : 1}";
				response.getWriter().print(resultJson);
			}
		}
		else
		{
			System.out.println("형식을 모두 채워주세요");
			resultJson = null;
			response.getWriter().print(resultJson);
		}
	}

	
	private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("로그아웃 중..");
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("post?action=list");
		
	}


	private void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		String resultJson;
		
		user.setUser_id(request.getParameter("user_id"));
		user.setUser_pw(request.getParameter("user_pw"));
			
		dao.doLogin(user);
		if(user.getUser_name()!=null&&user.getUser_accept()!=0){
			session.setAttribute("user",user);
			System.out.println("user connect : "+user.getUser_id());
			resultJson = "{ \"success\" : 1}";
			response.getWriter().print(resultJson);
		}
		else
		{
			System.out.println("로그인 실패");
			resultJson = null ;
			response.getWriter().print(resultJson);
		}
	}
	
	
	private void doUser_withdraw(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		String resultJson;
		
		System.out.println(((User)session.getAttribute("user")));
		System.out.println(request.getParameter("user_pw"));
		if(request.getParameter("user_pw")!=null&&((User)session.getAttribute("user")).getUser_id()!=null)
		{
			user.setUser_id(((User)session.getAttribute("user")).getUser_id());
			user.setUser_pw(request.getParameter("user_pw"));

			boolean flag = dao.doWithdraw(user);

			if(flag == true)
			{
				System.out.println("회원탈퇴 성공, 로그아웃 합니다.");
				session.invalidate();
				resultJson = "{ \"success\" : 1}";
				response.getWriter().print(resultJson);
			}
			else
			{
				resultJson = null;
				response.getWriter().print(resultJson);
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

	
	private void doUser_info(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		
		System.out.println("정보 세션");
		System.out.println(((User)session.getAttribute("user")).getUser_id());
		System.out.println(((User)session.getAttribute("user")).getUser_pw());
		
		if(((User)session.getAttribute("user")).getUser_id() == null || ((User)session.getAttribute("user")).getUser_pw() == null)
		{
			//@로그인 페이지로 돌아가기..
			System.out.println("세션없음");
			response.sendRedirect("login.jsp");
		}
		else{
			user.setUser_id(((User)session.getAttribute("user")).getUser_id());
			user.setUser_pw(((User)session.getAttribute("user")).getUser_pw());
			
			dao.doInfo(user);
			if(user.getUser_name()!=null){
				request.setAttribute("result", user);
				RequestDispatcher dispatcher = request.getRequestDispatcher("userInfo.jsp");
				dispatcher.forward(request, response);
			}
			else
			{
				System.out.println("회원 정보 조회에 실패했습니다.");
			}
		}
		
	}

	private void doUser_info2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		
//		System.out.println(((User)session.getAttribute("user")).getUser_id());
//		System.out.println(((User)session.getAttribute("user")).getUser_pw());

		if(((User)session.getAttribute("user")).getUser_id() == null || ((User)session.getAttribute("user")).getUser_pw() == null)
		{
			//@로그인 페이지로 돌아가기..
			System.out.println("세션없음");
			response.sendRedirect("login.jsp");
		}
		else{
			user.setUser_id(((User)session.getAttribute("user")).getUser_id());
			user.setUser_pw(((User)session.getAttribute("user")).getUser_pw());
			
			dao.doInfo(user);
			if(user.getUser_name()!=null){
				request.setAttribute("result", user);
				RequestDispatcher dispatcher = request.getRequestDispatcher("userInfoModify.jsp");
				dispatcher.forward(request, response);
			}
			else
			{
				System.out.println("회원 정보 조회에 실패했습니다.");
			}
		}
		
	}
	
	private void doUser_info_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		String resultJson;

		System.out.println(((User)session.getAttribute("user")).getUser_id());
		System.out.println(request.getParameter("user_phone"));
		
		if(((User)session.getAttribute("user")).getUser_id()!=null&&request.getParameter("user_pw")!=null&&request.getParameter("user_name")!=null&&request.getParameter("user_phone")!=null&&request.getParameter("user_email")!=null&&request.getParameter("team_name")!=null)
		{
			user.setUser_id(((User)session.getAttribute("user")).getUser_id());
			user.setUser_pw(request.getParameter("user_pw"));
			user.setTeam_name(request.getParameter("team_name"));
			user.setUser_name(request.getParameter("user_name"));
			user.setUser_phone(request.getParameter("user_phone"));
			user.setUser_email(request.getParameter("user_email"));
			
			boolean flag = dao.doUpdate(user);
			if(flag){
				session.setAttribute("user",user);
				resultJson = "{ \"success\" : 1}";
				response.getWriter().print(resultJson);
			}
		}
		else
		{
			System.out.println("형식을 모두 채워주세요");
			resultJson = null;
			response.getWriter().print(resultJson);
		}
		
	}

	
	private void doUser_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		
//		if(Integer.toString(((User)session.getAttribute("user")).getUser_accept()).equals("3"))
		if(true)
		{
			 ArrayList<User> list= dao.doList();
			if(list.size()!=0){
				System.out.println(list);
				request.setAttribute("result", list);
				RequestDispatcher dispatcher = request.getRequestDispatcher("userList.jsp");
				dispatcher.forward(request, response);
			}
			else
			{
				System.out.println("조회되는 회원이 없습니다.");
			}
		}
		else
		{
			System.out.println("권한이 없습니다.");
		}
	}


	private void doUser_accept(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		
		if(((User)session.getAttribute("user")).getUser_id().equals("admin"))
		{
			boolean flag = dao.doAccept(request.getParameter("accept_id"),1);

			if(flag == true)
			{
				System.out.println("승인 완료");
			}
			else
			{
				System.out.println("승인 실패(아이디가 없거나 이미 승인된 회원입니다.)");
			}
		}
		else
		{
			System.out.println("권한이 없습니다.");	
		}
	}

	
	private void doTeam_accept(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		
		if(((User)session.getAttribute("user")).getUser_id().equals("admin"))
		{
			boolean flag = dao.doAccept(request.getParameter("team_id"),2);

			if(flag == true)
			{
				System.out.println("승인 완료");
			}
			else
			{
				System.out.println("승인 실패(아이디가 없거나 이미 승인된 회원입니다.)");
			}
		}
		else
		{
			System.out.println("권한이 없습니다.");	
		}
	}

	private void doUser_check(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		User user = new User();
		String resultJson;
		
		user.setUser_id(request.getParameter("user_id"));
		
		System.out.println(user.getUser_id());
		boolean flag = dao.doCheck(user);
		
		if(!flag){
			resultJson = "{ \"success\" : 1}";
			response.getWriter().print(resultJson);
		}
		else
		{
			resultJson = null ;
			response.getWriter().print(resultJson);
		}
	}
	
}
