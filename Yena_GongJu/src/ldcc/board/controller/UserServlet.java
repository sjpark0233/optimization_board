package ldcc.board.controller;

import java.io.IOException;
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
		else if("user_accept".equals(action)){
			doUser_accept(request,response);
		}
		else if("team_accept".equals(action)){
			doTeam_accept(request,response);
		}
			
	}

	
	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String result = "fail";
		UserDAO dao = new UserDAO();
		User user = new User();
		
		
		if(request.getParameter("user_id")!=null&request.getParameter("user_pw")!=null&request.getParameter("user_name")!=null&request.getParameter("user_phone")!=null&request.getParameter("user_email")!=null&request.getParameter("team_name")!=null)
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
				result = user.getUser_name();
			}
		}
		else
		{
			System.out.println("������ ��� ä���ּ���");
		}
		
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
		
	}

	
	private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String result = "�α׾ƿ� �Ϸ�";
		HttpSession session = request.getSession();
		session.invalidate();
		
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
		
	}


	private void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		
		user.setUser_id(request.getParameter("user_id"));
		user.setUser_pw(request.getParameter("user_pw"));
		
		dao.doLogin(user);
		String result = "fail";
		if(user.getUser_name()!=null){
			session.setAttribute("user",user);
			result = user.getUser_name();
		}
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
	}
	
	
	private void doUser_withdraw(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		User user = new User();
		
		if(request.getParameter("user_pw")!=null)
		{
			user.setUser_id(((User)session.getAttribute("user")).getUser_id());
			user.setUser_pw(request.getParameter("user_pw"));

			boolean flag = dao.doWithdraw(user);

			if(flag == true)
			{
				System.out.println("ȸ��Ż�� ����, �α׾ƿ� �մϴ�.");
				doLogout(request,response);
			}
			else
			{
				System.out.println("ȸ��Ż�� ����");
			}
		}
		else
		{
			System.out.println("��й�ȣ�� �Է��� �ּ���.");
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
		String result = "fail";
		UserDAO dao = new UserDAO();
		User user = new User();

		user.setUser_id((String)session.getAttribute("user_id"));
		user.setUser_pw((String)session.getAttribute("user_pw"));
		
		if(user.getUser_id() == null || user.getUser_pw() == null)
		{
			//@�α��� �������� ���ư���..
//			response.sendRedirect("login.jsp");
		}
		
		dao.doCheck(user);
		if(user.getUser_name()!=null){
			request.setAttribute("result", user.getUser_name());
			RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
			dispatcher.forward(request, response);
		}
		else
		{
			System.out.println("ȸ�� ���� ��ȸ�� �����߽��ϴ�.");
		}
	}
	
	
	private void doUser_info_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String result = "fail";
		UserDAO dao = new UserDAO();
		User user = new User();
		
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
				result = "���� �Ϸ�";
			}
		}
		else
		{
			System.out.println("������ ��� ä���ּ���");
		}
		
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
		
	}

	
	private void doUser_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		
		if(((User)session.getAttribute("user")).getUser_id().equals("admin"))
		{
			ArrayList<User> list = dao.doList();
			if(list.size()!=0){
				System.out.println(list);
				request.setAttribute("result", list);
				RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
				dispatcher.forward(request, response);
			}
			else
			{
				System.out.println("��ȸ�Ǵ� ȸ���� �����ϴ�.");
			}
		}
		else
		{
			System.out.println("������ �����ϴ�.");
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
				System.out.println("���� �Ϸ�");
			}
			else
			{
				System.out.println("���� ����(���̵� ���ų� �̹� ���ε� ȸ���Դϴ�.)");
			}
		}
		else
		{
			System.out.println("������ �����ϴ�.");	
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
				System.out.println("���� �Ϸ�");
			}
			else
			{
				System.out.println("���� ����(���̵� ���ų� �̹� ���ε� ȸ���Դϴ�.)");
			}
		}
		else
		{
			System.out.println("������ �����ϴ�.");	
		}
	}
}
