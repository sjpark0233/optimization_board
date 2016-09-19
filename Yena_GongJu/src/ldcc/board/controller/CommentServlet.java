package ldcc.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		case "modify":
			this.doModifyComment(request, response, multi);
			break;
		case "delete":
			this.doDeleteComment(request, response);
			break;
		}
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
		out.println("location.href=\"post?action=read" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&post_code="
				+ postCode + "\";");
		out.println("</script>");
		out.close();
	}

	private void doModifyComment(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 만일 현재 유저와 댓글 유저가 일치하지 않으면 수정을 못하도록 함
		int commentCode = Integer.parseInt(multi.getParameter("comment_code"));
		Comment comment = new CommentDAO().doGet(commentCode);
		User user = (User) request.getSession().getAttribute("user");
		if (!(user.getUser_accept() == 3 || user.getUser_id().equals(comment.getUser_id()))) {
			// 관리자 또는 주인이 아닌 경우 alert 출력
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('자신의 댓글만 수정할 수 있습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// 댓글 수정
		comment.setComment_content(multi.getParameter("comment_input_" + commentCode));
		new CommentDAO().doUpdate(comment);

		// 게시판 파트 텝 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		// 게시물 코드 반환
		int postCode = Integer.parseInt(request.getParameter("post_code"));

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href=\"post?action=read" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&post_code="
				+ postCode + "\";");
		out.println("</script>");
		out.close();
	}

	private void doDeleteComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		int commentCode = Integer.parseInt(request.getParameter("comment_code"));
		Comment comment = new CommentDAO().doGet(commentCode);
		User user = (User) request.getSession().getAttribute("user");
		if (!(user.getUser_accept() == 3 || user.getUser_id().equals(comment.getUser_id()))) {
			// 관리자 또는 주인이 아닌 경우 alert 출력
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('자신의 댓글만 삭제할 수 있습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// 댓글 삭제
		new CommentDAO().doDelete(Integer.parseInt(request.getParameter("comment_code")));

		// 게시판 텝 번호, 게시글 번호 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href=\"post?action=read" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "&post_code="
				+ comment.getPost_code() + "\";");
		out.println("</script>");
		out.close();
	}

	private boolean doCheckSession(HttpServletRequest request, HttpServletResponse response) {
		Object user = request.getSession().getAttribute("user");
		return user != null && user instanceof User && new UserDAO().doCheck((User) user);
	}

}
