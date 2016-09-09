package ldcc.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ldcc.board.dao.BoardDAO;
import ldcc.board.dao.PostDAO;
import ldcc.board.dao.UserDAO;
import ldcc.board.vo.Post;
import ldcc.board.vo.User;

/**
 * Servlet implementation class PostServlet
 */
@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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

		switch (multi != null ? multi.getParameter("action") : request.getParameter("action")) {
		case "list":
			this.doShowList(request, response);
			break;
		case "read":
			this.doReadPost(request, response);
			break;
		case "show_write":
			this.doShowWrite(request, response);
			break;
		case "write":
			this.doWritePost(request, response, multi);
			break;
		case "show_modify":
			this.doShowModify(request, response);
			break;
		case "modify":
			this.doModifyPost(request, response, multi);
			break;
		case "delete":
			this.doDeletePost(request, response);
			break;
		}
	}

	/**
	 * 게시물 목록보기 <br>
	 * ex1) URI : {@code "./post?action=list"} <br>
	 * ex2) URI : {@code "./post?action=list&page=5"}<br>
	 * ex3) URI : {@code "./post?action=list&tab_code=1"}<br>
	 * ex4) URI : {@code "./post?action=list&tab_code=1&page=5"}
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doShowList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 게시판의 현재 페이지
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		// 게시판 파트 텝 번호 (0은 모든 파트게시판)
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
			request.setAttribute("tab_code", tabCode);
		}

		// 공지 게시물 리스트 객체 반환
		PostDAO postDAO = new PostDAO();
		List<String> noticeUserList = new ArrayList<String>();
		List<Post> noticeList = tabCode == 0 ? postDAO.doGetNoticeList(noticeUserList)
				: postDAO.doGetNoticeList(tabCode, noticeUserList);
		request.setAttribute("notice_list", noticeList);
		request.setAttribute("notice_user_list", noticeUserList);

		// 일반 게시물 리스트 객체 반환
		List<String> postUserList = new ArrayList<String>();
		List<Post> postList = tabCode == 0 ? postDAO.doGetList(page, postUserList)
				: postDAO.doGetList(tabCode, page, postUserList);
		request.setAttribute("post_list", postList);
		request.setAttribute("post_user_list", postUserList);

		// 페이지 관련 변수
		int listAllCount = tabCode == 0 ? postDAO.doGetListAllCount() : postDAO.doGetListAllCount(tabCode);
		int maxPage = (int) ((double) listAllCount / 10 + 0.95);
		int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		request.setAttribute("page", page);
		request.setAttribute("max_page", maxPage);
		request.setAttribute("start_page", startPage);
		request.setAttribute("end_page", endPage);
		request.setAttribute("list_all_count", listAllCount);

		request.getRequestDispatcher("list_main.jsp").forward(request, response);
	}

	/**
	 * 게시물 상세보기 <br>
	 * ex1) URI : {@code "./post?action=read&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=read&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doReadPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 조회수 1증가
		PostDAO postDAO = new PostDAO();
		postDAO.doIncreaseView(Integer.parseInt(request.getParameter("post_code")));

		// 대상 게시물 객체 반환
		Post post = postDAO.doGet(Integer.parseInt(request.getParameter("post_code")));
		request.setAttribute("post", post);
		request.setAttribute("board_name", new BoardDAO().doGet(post.getBoard_code()).getBoard_name());
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		request.getRequestDispatcher("view.jsp").forward(request, response);
	}

	/**
	 * 게시물 쓰기 전 화면 보여주기 <br>
	 * ex1) URI : {@code "./post?action=show_write"} <br>
	 * ex2) URI : {@code "./post?action=show_write&tab_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doShowWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 게시판 파트 텝 번호
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		// 게시판 파트 리스트 반환. 게시물 쓸 때 파트 선택 콤보박스 완성을 위함
		request.setAttribute("board_list", new BoardDAO().doGetList());

		request.getRequestDispatcher("write.jsp").forward(request, response);
	}

	/**
	 * 게시물 쓰기 실행용 <br>
	 * ex1) URI : {@code "./post?action=write&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=write&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @param multi
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doWritePost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 새 게시글 올리기
		Post post = new Post();
		post.setBoard_code(Integer.parseInt(multi.getParameter("board_code")));
		post.setUser_id(((User) request.getSession().getAttribute("user")).getUser_id());
		post.setPost_title(multi.getParameter("post_title"));
		post.setPost_content(multi.getParameter("post_content"));
		post.setPost_type(Integer.parseInt(multi.getParameter("post_type")));
		post.setPost_filepath(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
		new PostDAO().doInsert(post);

		// 게시판 파트 텝 번호 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('등록되었습니다.');");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	/**
	 * 게시물 수정 전 화면 보여주기 <br>
	 * ex1) URI : {@code "./post?action=show_modify&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=show_modify&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doShowModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 게시판 파트 텝 번호 반환
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		// 수정 전 게시물 정보 반환. 만일 현재 유저와 게시물 유저가 일치하지 않으면 수정을 못하도록 함
		int postCode = Integer.parseInt(request.getParameter("post_code"));
		Post post = new PostDAO().doGet(postCode);
		if (!((User) request.getSession().getAttribute("user")).getUser_id().equals(post.getUser_id())) {
			// 주인이 아닌 경우 alert 출력
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('자신의 글만 수정할 수 있습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}
		request.setAttribute("post", post);

		request.getRequestDispatcher("modify.jsp").forward(request, response);
	}

	/**
	 * 게시물 수정 실행용 <br>
	 * ex1) URI : {@code "./post?action=modify&&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=modify&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @param multi
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doModifyPost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 게시글 수정하기
		boolean fileEdited = Boolean.parseBoolean(multi.getParameter("file_edited"));
		Post post = new Post();
		post.setBoard_code(Integer.parseInt(multi.getParameter("board_code")));
		post.setPost_title(multi.getParameter("post_title"));
		post.setPost_content(multi.getParameter("post_content"));
		post.setPost_type(Integer.parseInt(multi.getParameter("post_type")));
		if (fileEdited) {
			post.setPost_filepath(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
			// 기존 파일 지우기 (incomplete)
		}
		post.setPost_code(Integer.parseInt(multi.getParameter("post_code")));
		new PostDAO().doUpdate(post, fileEdited);

		// 게시판 파트 텝 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('수정되었습니다.');");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	private void doDeletePost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		int postCode = Integer.parseInt(request.getParameter("post_code"));
		Post post = new PostDAO().doGet(postCode);
		if (!((User) request.getSession().getAttribute("user")).getUser_id().equals(post.getUser_id())) {
			// 주인이 아닌 경우 alert 출력
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('자신의 글만 삭제할 수 있습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// 게시글 삭제
		new PostDAO().doDelete(Integer.parseInt(request.getParameter("post_code")));

		// 게시판 텝 번호 반환
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.');");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	/**
	 * 유저 로그인 세션 여부 확인
	 * 
	 * @param request
	 * @param response
	 * @return true or false
	 */
	private boolean doCheckSession(HttpServletRequest request, HttpServletResponse response) {
		Object user = request.getSession().getAttribute("user");
		return user != null && user instanceof User && new UserDAO().doCheck((User) user);
	}
}
