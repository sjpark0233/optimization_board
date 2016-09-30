package ldcc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ldcc.board.dao.FileEntryDAO;
import ldcc.board.vo.FileEntry;

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
		
		FileEntryDAO fileEntryDAO = new FileEntryDAO();
		
		// ���� ���� �ڵ� ���ϱ�
		int dirCode = 0;
		if (request.getAttribute("dir_code") != null) {
			dirCode = Integer.parseInt(request.getParameter("dir_code"));
			request.setAttribute("dir_code", dirCode);
			
			// ���� ������ �θ� �ڵ� ���ϱ�. 0�� ��Ʈ�� �ǹ�
			int parentCode = fileEntryDAO.doGetParentCode(dirCode);
			request.setAttribute("parent_code", parentCode);
		}
		
		// ���� ��� ���ϱ�
		List<FileEntry> fileEntryList = fileEntryDAO.getFileListByParent(dirCode);
		request.setAttribute("file_entry_list", fileEntryList);
		
		// �ش� ������ �� ���� ���� �뷮 ���ϱ�
		int totalCount = 0;
		long totalSize = 0L;
		for (FileEntry fileEntry : fileEntryList) {
			totalCount++;
			totalSize += fileEntry.getFile_entry_size();
		}
		request.setAttribute("total_count", totalCount);
		request.setAttribute("total_size", totalSize);

		request.getRequestDispatcher("filesystem.jsp").forward(request, response);
		
		
		
		/* ���� ����̺� ����. ��������.
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
			totalSize += file.getFileSize();
		}
		request.setAttribute("total_count", totalCount);
		request.setAttribute("total_size", totalSize);

		request.getRequestDispatcher("filesystem.jsp").forward(request, response);
		*/
	}
}
