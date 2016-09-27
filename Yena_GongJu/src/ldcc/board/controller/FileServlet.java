package ldcc.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ldcc.board.api.GoogleDrive;
import ldcc.board.api.GoogleFile;

@WebServlet("/FileServlet")
public class FileServlet extends HttpServlet {

	private static final long serialVersionUID = 793401455187984603L;

	public FileServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		if (request.getParameter("action") == null) {
			request.getRequestDispatcher("file?action=list").forward(request, response);
			return;
		}

		switch (request.getParameter("action")) {
		case "list":
			this.doList(request, response);
			break;
		case "download":
			this.doDownLoad(request, response);
			break;
		case "upload":
			break;
		case "mkdir":
			break;
		case "rmdir":
			break;
		case "rename":
			break;
		}
	}

	private void doList(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String dirId = "";
		if (request.getParameter("dir_id") != null) {
			dirId = request.getParameter("dir_id");
			request.setAttribute("dir_id", dirId);

			// �ش� ���丮�� �θ� id ���ϱ�
			GoogleFile parentFile = GoogleDrive.getFile(dirId);
			if (parentFile != null && parentFile.getParentId() != null) {
				request.setAttribute("parent_id", parentFile.getParentId());
			}
		}

		// ���� ��� ���ϱ�
		List<GoogleFile> googleFileList = new ArrayList<GoogleFile>();
		if (dirId != null && !dirId.equals("")) {
			googleFileList = GoogleDrive.getFileList(dirId);
		} else {
			googleFileList = GoogleDrive.getFileListOfRoot();
		}
		request.setAttribute("file_list", googleFileList);

		// �ش� ���丮�� �� ���� ���� �뷮 ���ϱ�
		int totalCount = 0;
		long totalSize = 0L;
		for (GoogleFile file : googleFileList) {
			totalCount++;
			totalSize += file.getSize();
		}
		request.setAttribute("total_count", totalCount);
		request.setAttribute("total_size", totalSize);

		request.getRequestDispatcher("filesystem.jsp").forward(request, response);
	}

	private void doDownLoad(HttpServletRequest request, HttpServletResponse response) {

	}
}
