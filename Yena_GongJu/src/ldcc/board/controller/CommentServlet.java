package ldcc.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ldcc.board.dao.CommentDAO;
import ldcc.board.dao.UserDAO;
import ldcc.board.vo.Comment;
import ldcc.board.vo.Post;
import ldcc.board.vo.User;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CommentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if("comment_list".equals(action)){
			doComment_list(request,response);
		}
		else if("comment_modify".equals(action)){
			doComment_modify(request,response);
		}
		else if("comment_delete".equals(action)){
			doComment_delete(request,response);
		}
		else if("comment_write".equals(action)){
			doComment_write(request,response);
		}
	}


	private void doComment_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();

		ArrayList<Comment> list = dao.doList(Integer.parseInt(request.getParameter("post_code")));

		if(list.size()!=0){
			System.out.println(list);
			request.setAttribute("result", list);
			RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
			dispatcher.forward(request, response);
		}
		else
		{
			System.out.println("아직 댓글이 없습니다.");
		}

	}


	private void doComment_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		Comment comment = new Comment();
		String result = "fail";

		if(request.getParameter("comment_content")!=null&&request.getParameter("comment_code")!=null)
		{
			comment.setComment_code(Integer.parseInt(request.getParameter("comment_code")));
			comment.setComment_content(request.getParameter("comment_content"));

			boolean flag = dao.doUpdate(comment);
			if(flag){
				result = "수정 완료";
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


	private void doComment_delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		String result = "fail";

		boolean flag = dao.doDelete(Integer.parseInt(request.getParameter("comment_code")));
		if(flag){
			result = "삭제 완료";
		}

		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);

	}


	private void doComment_write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {
		HttpSession session = request.getSession();
		String result = "fail";
		CommentDAO dao = new CommentDAO();
		Comment comment = new Comment();

		if(request.getParameter("comment_content")!=null)
		{
			comment.setUser_id(((User)session.getAttribute("user")).getUser_id());
			comment.setPost_code(Integer.parseInt(request.getParameter("post_code")));
			comment.setComment_content(request.getParameter("comment_content"));

			boolean flag = dao.doInsert(comment);
			if(flag){
				result = comment.getUser_id();
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




}
