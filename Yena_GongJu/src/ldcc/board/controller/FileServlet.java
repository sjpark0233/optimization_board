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
		
		// 현재 폴더 코드 구하기
		int dirCode = 0;
		if (request.getAttribute("dir_code") != null) {
			dirCode = Integer.parseInt(request.getParameter("dir_code"));
			request.setAttribute("dir_code", dirCode);
			
			// 현재 폴더의 부모 코드 구하기. 0은 루트를 의미
			int parentCode = fileEntryDAO.doGetParentCode(dirCode);
			request.setAttribute("parent_code", parentCode);
		}
		
		// 파일 목록 구하기
		List<FileEntry> fileEntryList = fileEntryDAO.getFileListByParent(dirCode);
		request.setAttribute("file_entry_list", fileEntryList);
		
		// 해당 폴더의 총 파일 수와 용량 구하기
		int totalCount = 0;
		long totalSize = 0L;
		for (FileEntry fileEntry : fileEntryList) {
			totalCount++;
			totalSize += fileEntry.getFile_entry_size();
		}
		request.setAttribute("total_count", totalCount);
		request.setAttribute("total_size", totalSize);

		request.getRequestDispatcher("filesystem.jsp").forward(request, response);
		
		
		
		/* 구글 드라이브 전용. 삭제예정.
		String dirId = "";
		if (request.getParameter("dir_id") != null) {
			dirId = request.getParameter("dir_id");
			request.setAttribute("dir_id", dirId);

			// 해당 디렉토리의 부모 id 구하기
			GoogleFile parentFile = GoogleDrive.getFile(dirId);
			if (parentFile != null && parentFile.getParentId() != null) {
				request.setAttribute("parent_id", parentFile.getParentId());
			}
		}

		// 파일 목록 구하기
		List<GoogleFile> googleFileList = new ArrayList<GoogleFile>();
		if (dirId != null && !dirId.equals("")) {
			googleFileList = GoogleDrive.getFileList(dirId);
		} else {
			googleFileList = GoogleDrive.getFileListOfRoot();
		}
		request.setAttribute("file_list", googleFileList);

		// 해당 디렉토리의 총 파일 수와 용량 구하기
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
