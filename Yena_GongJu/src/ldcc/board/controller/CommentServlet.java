package ldcc.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ldcc.board.dao.CommentDAO;
import ldcc.board.dao.UserDAO;
import ldcc.board.vo.Comment;
import ldcc.board.vo.User;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = -184918101435996301L;

	public CommentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, request.getRealPath("upload"), 5 * 1024 * 1024, "euc-kr",
					new DefaultFileRenamePolicy());
		} catch (IOException e) {
		}

		switch (request.getParameter("action")) {
		case "write":
			this.doWriteComment(request, response, multi);
			break;
		}

		/*
		 * if("comment_list".equals(action)){ doComment_list(request,response);
		 * } else if("comment_modify".equals(action)){
		 * doComment_modify(request,response); } else
		 * if("comment_delete".equals(action)){
		 * doComment_delete(request,response); } else
		 * if("comment_write".equals(action)){
		 * doComment_write(request,response); }
		 */
	}

	/**
	 * 댓글 달기 실행용 <br>
	 * ex1) URI : {@code "./comment?action=write&post_code=1"} <br>
	 * ex2) URI : {@code "./comment?action=write&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @param multi
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doWriteComment(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 사용자 댓글달기 권한 검사 (user_accept == 2 or 3)
		int userAccept = ((User) request.getSession().getAttribute("user")).getUser_accept();
		if (!(userAccept == 2 || userAccept == 3)) {
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('댓글달기 권한이 없습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// 새 댓글 올리기
		Comment comment = new Comment();
		int postCode = Integer.parseInt(request.getParameter("post_code"));
		comment.setPost_code(postCode);
		comment.setUser_id(((User) request.getSession().getAttribute("user")).getUser_id());
		comment.setComment_content(multi.getParameter("comment_content"));
		new CommentDAO().doInsert(comment);

		// 게시판 파트 텝 번호 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('등록되었습니다.');");
		out.println("location.href=\"post?action=read" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&post_code="
				+ postCode + "\";");
		out.println("</script>");
		out.close();
	}

	private void doComment_list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();

		ArrayList<Comment> list = dao.doList(Integer.parseInt(request.getParameter("post_code")));

		if (list.size() != 0) {
			System.out.println(list);
			request.setAttribute("result", list);
			RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
			dispatcher.forward(request, response);
		} else {
			System.out.println("아직 댓글이 없습니다.");
		}

	}

	private void doComment_modify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		Comment comment = new Comment();
		String result = "fail";

		if (request.getParameter("comment_content") != null && request.getParameter("comment_code") != null) {
			comment.setComment_code(Integer.parseInt(request.getParameter("comment_code")));
			comment.setComment_content(request.getParameter("comment_content"));

			boolean flag = dao.doUpdate(comment);
			if (flag) {
				result = "수정 완료";
			}
		} else {
			System.out.println("형식을 모두 채워주세요");
		}

		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
	}

	private void doComment_delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		String result = "fail";

		boolean flag = dao.doDelete(Integer.parseInt(request.getParameter("comment_code")));
		if (flag) {
			result = "삭제 완료";
		}

		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);

	}

	private void doComment_write(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, NumberFormatException {
		HttpSession session = request.getSession();
		String result = "fail";
		CommentDAO dao = new CommentDAO();
		Comment comment = new Comment();

		if (request.getParameter("comment_content") != null) {
			comment.setUser_id(((User) session.getAttribute("user")).getUser_id());
			comment.setPost_code(Integer.parseInt(request.getParameter("post_code")));
			comment.setComment_content(request.getParameter("comment_content"));

			boolean flag = dao.doInsert(comment);
			if (flag) {
				result = comment.getUser_id();
			}
		} else {
			System.out.println("형식을 모두 채워주세요");
		}

		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
		dispatcher.forward(request, response);
	}

	private boolean doCheckSession(HttpServletRequest request, HttpServletResponse response) {
		Object user = request.getSession().getAttribute("user");
		return user != null && user instanceof User && new UserDAO().doCheck((User) user);
	}

}
