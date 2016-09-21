package ldcc.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ldcc.board.dao.BoardDAO;
import ldcc.board.dao.CommentDAO;
import ldcc.board.dao.PostDAO;
import ldcc.board.dao.UserDAO;
import ldcc.board.vo.Comment;
import ldcc.board.vo.Post;
import ldcc.board.vo.User;

/**
 * Servlet implementation class PostServlet
 */
@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1861716954412570456L;

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
			this.doShowList(request, response, multi);
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
	 * �Խù� ��Ϻ��� <br>
	 * ex1) URI : {@code "./post?action=list"}<br>
	 * ex2) URI : {@code "./post?action=list&page=5"}<br>
	 * ex3) URI : {@code "./post?action=list&tab_code=1"}<br>
	 * ex4) URI : {@code "./post?action=list&tab_code=1&page=5"}<br>
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doShowList(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// �Խ����� ���� ������
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		// �Խ��� ��Ʈ �� ��ȣ (0�� ��� ��Ʈ�Խ���)
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
			request.setAttribute("tab_code", tabCode);
		}

		// ���� �Խù� ����Ʈ ��ü ��ȯ
		PostDAO postDAO = new PostDAO();
		List<Post> noticeList = tabCode == 0 ? postDAO.doGetNoticeList() : postDAO.doGetNoticeList(tabCode);
		request.setAttribute("notice_list", noticeList);

		// �Ϲ� �Խù� ����Ʈ ��ü ��ȯ
		int searchType = 0;
		int listCount = 0;
		if (request.getParameter("search") != null) {
			searchType = Integer.parseInt(request.getParameter("search"));
			request.setAttribute("search", searchType);
			request.setAttribute("keyword", request.getParameter("keyword"));
		}
		switch (searchType) {
		case 1:
			int postCode = 0;
			try {
				postCode = Integer.parseInt(request.getParameter("keyword"));
			} catch (NumberFormatException e) {
			}
			request.setAttribute("post_list",
					tabCode == 0 ? postDAO.doSearchByCode(postCode) : postDAO.doSearchByCode(tabCode, postCode));
			listCount = tabCode == 0 ? postDAO.doSearchByCodeCount(postCode)
					: postDAO.doSearchByCodeCount(tabCode, postCode);
			break;
		case 2:
			String user = request.getParameter("keyword");
			request.setAttribute("post_list",
					tabCode == 0 ? postDAO.doSearchByUser(page, user) : postDAO.doSearchByUser(tabCode, page, user));
			listCount = tabCode == 0 ? postDAO.doSearchByUserCount(user) : postDAO.doSearchByUserCount(tabCode, user);
			break;
		case 3:
			String title = request.getParameter("keyword");
			request.setAttribute("post_list", tabCode == 0 ? postDAO.doSearchByTitle(page, title)
					: postDAO.doSearchByTitle(tabCode, page, title));
			listCount = tabCode == 0 ? postDAO.doSearchByTitleCount(title)
					: postDAO.doSearchByUserCount(tabCode, title);
			break;
		case 4:
			String content = request.getParameter("keyword");
			request.setAttribute("post_list", tabCode == 0 ? postDAO.doSearchByContent(page, content)
					: postDAO.doSearchByContent(tabCode, page, content));
			listCount = tabCode == 0 ? postDAO.doSearchByContentCount(content)
					: postDAO.doSearchByContentCount(tabCode, content);
			break;
		default:
			request.setAttribute("post_list",
					tabCode == 0 ? postDAO.doGetList(page) : postDAO.doGetList(tabCode, page));
			listCount = tabCode == 0 ? postDAO.doGetListCount() : postDAO.doGetListCount(tabCode);
		}

		// ������ ���� ����
		int maxPage = (int) ((double) listCount / 10 + 0.95);
		int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		request.setAttribute("page", page);
		request.setAttribute("max_page", maxPage);
		request.setAttribute("start_page", startPage);
		request.setAttribute("end_page", endPage);
		request.setAttribute("list_count", listCount);

		request.getRequestDispatcher("list_main.jsp").forward(request, response);
	}

	/**
	 * �Խù� �󼼺��� <br>
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
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// ��ȸ�� 1����
		PostDAO postDAO = new PostDAO();
		postDAO.doIncreaseView(Integer.parseInt(request.getParameter("post_code")));

		// ��� �Խù� ��ü ��ȯ
		Post post = postDAO.doGet(Integer.parseInt(request.getParameter("post_code")));
		request.setAttribute("post", post);
		request.setAttribute("board_name", new BoardDAO().doGet(post.getBoard_code()).getBoard_name());
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		// ��� �Խù��� ��� ����Ʈ ��ȯ
		List<Comment> commentList = new CommentDAO().doGetList(Integer.parseInt(request.getParameter("post_code")));
		request.setAttribute("comment_list", commentList);

		request.getRequestDispatcher("view.jsp").forward(request, response);
	}

	/**
	 * �Խù� ���� �� ȭ�� �����ֱ� <br>
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
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// ����� �۾��� ���� �˻� (user_accept == 2 or 3)
		int userAccept = ((User) request.getSession().getAttribute("user")).getUser_accept();
		if (!(userAccept == 2 || userAccept == 3)) {
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�۾��� ������ �����ϴ�.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// �Խ��� ��Ʈ �� ��ȣ
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		// �Խ��� ��Ʈ ����Ʈ ��ȯ. �Խù� �� �� ��Ʈ ���� �޺��ڽ� �ϼ��� ����
		request.setAttribute("board_list", new BoardDAO().doGetList());

		request.getRequestDispatcher("write.jsp").forward(request, response);
	}

	/**
	 * �Խù� ���� ����� <br>
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
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// �� �Խñ� �ø���
		Post post = new Post();
		post.setBoard_code(Integer.parseInt(multi.getParameter("board_code")));
		post.setUser_id(((User) request.getSession().getAttribute("user")).getUser_id());
		post.setPost_title(multi.getParameter("post_title"));
		post.setPost_content(multi.getParameter("post_content"));
		post.setPost_type(Integer.parseInt(multi.getParameter("post_type")));
		post.setPost_filepath(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
		new PostDAO().doInsert(post);

		// �Խ��� ��Ʈ �� ��ȣ ��ȯ
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('��ϵǾ����ϴ�.');");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	/**
	 * �Խù� ���� �� ȭ�� �����ֱ� <br>
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
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// �Խ��� ��Ʈ �� ��ȣ ��ȯ
		if (request.getParameter("tab_code") != null) {
			request.setAttribute("tab_code", Integer.parseInt(request.getParameter("tab_code")));
		}

		// ���� �� �Խù� ���� ��ȯ. ���� ���� ������ �Խù� ������ ��ġ���� ������ ������ ���ϵ��� ��
		int postCode = Integer.parseInt(request.getParameter("post_code"));
		Post post = new PostDAO().doGet(postCode);
		User user = (User) request.getSession().getAttribute("user");
		if (!(user.getUser_accept() == 3 || user.getUser_id().equals(post.getUser_id()))) {
			// ������ �Ǵ� ������ �ƴ� ��� alert ���
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�ڽ��� �۸� ������ �� �ֽ��ϴ�.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}
		request.setAttribute("post", post);

		request.getRequestDispatcher("modify.jsp").forward(request, response);
	}

	/**
	 * �Խù� ���� ����� <br>
	 * ex1) URI : {@code "./post?action=modify&&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=modify&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @param multi
	 * @throws ServletException
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	private void doModifyPost(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi)
			throws ServletException, IOException {
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// �Խñ� �����ϱ�
		boolean fileEdited = Boolean.parseBoolean(multi.getParameter("file_edited"));
		Post post = new Post();
		PostDAO postDAO = new PostDAO();
		int postCode = Integer.parseInt(multi.getParameter("post_code"));
		post.setBoard_code(Integer.parseInt(multi.getParameter("board_code")));
		post.setPost_title(multi.getParameter("post_title"));
		post.setPost_content(multi.getParameter("post_content"));
		post.setPost_type(Integer.parseInt(multi.getParameter("post_type")));
		if (fileEdited) {
			String filePath = postDAO.doGet(postCode).getPost_filepath();
			if (filePath != null && !filePath.equals("")) {
				new File(request.getRealPath("upload") + File.separator + filePath).delete();
			}
			post.setPost_filepath(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
		}
		post.setPost_code(postCode);
		postDAO.doUpdate(post, fileEdited);

		// �Խ��� ��Ʈ �� ��ȯ
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('�����Ǿ����ϴ�.');");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	/**
	 * �Խù� ���� ����� <br>
	 * ex1) URI : {@code "./post?action=delete&&post_code=1"} <br>
	 * ex2) URI : {@code "./post?action=delete&tab_code=1&post_code=1"}
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	private void doDeletePost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// �α��� ���� Ȯ��
		if (!this.doCheckSession(request, response)) {
			response.sendRedirect("login.jsp");
			return;
		}

		int postCode = Integer.parseInt(request.getParameter("post_code"));
		Post post = new PostDAO().doGet(postCode);
		User user = (User) request.getSession().getAttribute("user");
		if (!(user.getUser_accept() == 3 || user.getUser_id().equals(post.getUser_id()))) {
			// ������ �Ǵ� ������ �ƴ� ��� alert ���
			response.setContentType("text/html;charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�ڽ��� �۸� ������ �� �ֽ��ϴ�.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return;
		}

		// �Խñ� ����
		PostDAO postDAO = new PostDAO();
		String filePath = postDAO.doGet(postCode).getPost_filepath();
		if (filePath != null && !filePath.equals("")) {
			new File(request.getRealPath("upload") + File.separator + filePath).delete();
		}
		postDAO.doDelete(Integer.parseInt(request.getParameter("post_code")));

		// �Խ��� �� ��ȣ ��ȯ
		int tabCode = 0;
		if (request.getParameter("tab_code") != null) {
			tabCode = Integer.parseInt(request.getParameter("tab_code"));
		}

		response.setContentType("text/html;charset=euc-kr");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href=\"post?action=list" + (tabCode != 0 ? "&tab_code=" + tabCode : "") + "\";");
		out.println("</script>");
		out.close();
	}

	/**
	 * ���� �α��� ���� ���� Ȯ��
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
