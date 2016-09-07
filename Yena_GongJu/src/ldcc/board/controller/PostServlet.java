package ldcc.board.controller;

import java.io.IOException;
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
import ldcc.board.vo.Board;
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
		case "list_all":
			doShowListAll(request, response);
			break;
		case "list_part":
			doShowListPart(request, response);
			break;
		case "read":
			doReadPost(request, response);
			break;
		case "write":
			doWritePost(request, response, multi);
			break;
		case "modify":
			doModifyPost(request, response);
			break;
		case "delete":
			doDeletePost(request, response);
			break;
		}
	}

	private void doShowListAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		PostDAO postDAO = new PostDAO();
		List<Post> postList = postDAO.doGetList(page);
		request.setAttribute("post_list", postList);

		int listAllCount = postDAO.doGetListAllCount();
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

	private void doShowListPart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		PostDAO postDAO = new PostDAO();
		List<Post> postList = postDAO.doGetList(Integer.parseInt(request.getParameter("board_code")), page);
		request.setAttribute("post_list", postList);

		int listAllCount = postDAO.doGetListAllCount();
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

	private void doReadPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (request.getSession().getAttribute("user") == null) {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		} else {
			Post post = new PostDAO().doGet(Integer.parseInt(request.getParameter("post_code")));
			request.setAttribute("post", post);
			request.setAttribute("board_name", new BoardDAO().doGet(post.getBoard_code()).getBoard_name());
			request.getRequestDispatcher("test_view.jsp").forward(request, response);
		}
	}

	private void doWritePost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// 로그인 세션 확인
		if (request.getSession().getAttribute("user") == null) {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		} else {
			// 새 게시글 올리기
			Post post = new Post();
			post.setBoard_code(Integer.parseInt(multi.getParameter("board_code")));
			post.setUser_id(((User) request.getSession().getAttribute("user")).getUser_id());
			post.setPost_title(multi.getParameter("post_title"));
			post.setPost_content(multi.getParameter("post_content"));
			post.setPost_type(Integer.parseInt(multi.getParameter("post_type")));
			post.setPost_filepath(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
			new PostDAO().doInsert(post);

			// 게시글 목록으로
			request.getRequestDispatcher("list_main.jsp").forward(request, response);
		}
	}

	// incomplete !!!
	private void doModifyPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 새 게시글 수정하기
		// incomplete. 파일첨부처리 필요
		Post post = new Post();
		post.setBoard_code(Integer.parseInt(request.getParameter("board_code")));
		post.setPost_title(request.getParameter("post_title"));
		post.setPost_content(request.getParameter("post_content"));
		post.setPost_filepath(null); // incomplete
		post.setPost_type(Integer.parseInt(request.getParameter("post_type")));
		post.setPost_code(Integer.parseInt(request.getParameter("post_code")));
		new PostDAO().doUpdate(post);
		request.getRequestDispatcher("view.jsp").forward(request, response);

		// 게시글 올린 것 보기
		this.doReadPost(request, response);
	}

	private void doDeletePost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		new PostDAO().doDelete(Integer.parseInt(request.getParameter("post_code")));
		if (request.getParameter("board_code") == null || request.getParameter("board_code").equals("0")) {
			this.doShowListAll(request, response);
		} else {
			this.doShowListPart(request, response);
		}
	}
}
