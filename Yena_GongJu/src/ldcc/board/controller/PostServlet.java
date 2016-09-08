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

	private void doShowList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
			request.setAttribute("tab_code", tabCode);
		}

		PostDAO postDAO = new PostDAO();
		List<Post> postList = tabCode == 0 ? postDAO.doGetList(page) : postDAO.doGetList(tabCode, page);
		request.setAttribute("post_list", postList);

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

	private void doReadPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		// if (request.getSession().getAttribute("user") == null) {
		// request.getRequestDispatcher("login.jsp").forward(request, response);
		// } else {

		PostDAO postDAO = new PostDAO();
		postDAO.doIncreaseView(Integer.parseInt(request.getParameter("post_code")));
		Post post = postDAO.doGet(Integer.parseInt(request.getParameter("post_code")));
		request.setAttribute("post", post);
		request.setAttribute("board_name", new BoardDAO().doGet(post.getBoard_code()).getBoard_name());
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}
		request.getRequestDispatcher("view.jsp").forward(request, response);
		// }
	}

	private void doShowWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}
		request.setAttribute("board_list", new BoardDAO().doGetList());
		request.getRequestDispatcher("write.jsp").forward(request, response);
	}

	private void doWritePost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// 로그인 세션 확인
		// if (request.getSession().getAttribute("user") == null) {
		// request.getRequestDispatcher("login.jsp").forward(request, response);
		// } else {
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
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}
		request.getRequestDispatcher("post?action=list" + (tabCode != 0 ? "&tabCode=" + tabCode : "")).forward(request,
				response);
	}

	private void doShowModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 세션 확인
		// if (request.getSession().getAttribute("user") == null) {
		// request.getRequestDispatcher("login.jsp").forward(request, response);
		// } else {
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}
		int postCode = Integer.parseInt(request.getParameter("post_code"));
		Post post = new PostDAO().doGet(postCode);
		// if (!((User)
		// request.getSession().getAttribute("user")).getUser_id().equals(post.getUser_id()))
		// {
		// request.getRequestDispatcher("login.jsp").forward(request, response);
		// }
		request.setAttribute("post", post);
		request.getRequestDispatcher("modify.jsp").forward(request, response);
		// }
	}

	// incomplete !!!
	private void doModifyPost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// 새 게시글 수정하기
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

		// 수정 된 글 보기
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}
		request.getRequestDispatcher(
				"post?action=read" + (tabCode != 0 ? "&tabCode=" + tabCode : "") + "&post_code=" + post.getPost_code())
				.forward(request, response);
	}

	private void doDeletePost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		new PostDAO().doDelete(Integer.parseInt(request.getParameter("post_code")));

		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}
		request.getRequestDispatcher("post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "")).forward(request,
				response);
		;
	}
}
