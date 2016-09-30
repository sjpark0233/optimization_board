package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ldcc.board.vo.FileEntry;

public class FileEntryDAO {
	private final String getSQL = "select F.*, U.USER_NAME from FILE_ENTRY, USER where F.USER_ID=U.USER_ID and F.FILE_ENTRY_CODE=?";
	private final String getParentCodeSQL = "select FILE_ENTRY_PARENT from FILE_ENTRY where FILE_ENTRY_CODE=?";
	private final String getFileListByParentSQL = "select F.*, U.USER_NAME from FILE_ENTRY F, USER U where F.FILE_ENTRY_PARENT=? and F.USER_ID=U.USER_ID order by F.FILE_ENTRY_TYPE, F.FILE_ENTRY_NAME asc";

	public FileEntry doGet(int file_entry_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		FileEntry fileEntry = null;
		
		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getSQL);
			stmt.setInt(1, file_entry_code);
			rst = stmt.executeQuery();
			
			if (rst.next()) {
				fileEntry = new FileEntry();
				fileEntry.setFile_entry_code(file_entry_code);
				fileEntry.setFile_entry_type(rst.getInt(2));
				fileEntry.setFile_entry_name(rst.getString(3));
				fileEntry.setFile_entry_parent(rst.getInt(4));
				fileEntry.setFile_entry_size(rst.getLong(5));
				fileEntry.setUser_id(rst.getString(6));
				fileEntry.setFile_entry_upload_date(rst.getTimestamp(7));
				fileEntry.setUser_name(rst.getString(8));
			}
		} catch (SQLException e) {
			System.out.println("FileEntryDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return fileEntry;
	}
	
	public int doGetParentCode(int file_entry_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		int parentCode = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getParentCodeSQL);
			stmt.setInt(1, file_entry_code);
			rst = stmt.executeQuery();

			if (rst.next() && rst.getObject(1) != null) {
				parentCode = rst.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("FileEntryDAO.doGetParentCode() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return parentCode;
	}

	public List<FileEntry> getFileListByParent(int file_entry_parent) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<FileEntry> fileEntryList = new ArrayList<FileEntry>();

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getFileListByParentSQL);
			stmt.setInt(1, file_entry_parent);
			rst = stmt.executeQuery();

			while (rst.next()) {
				FileEntry fileEntry = new FileEntry();
				fileEntry.setFile_entry_code(rst.getInt(1));
				fileEntry.setFile_entry_type(rst.getInt(2));
				fileEntry.setFile_entry_name(rst.getString(3));
				fileEntry.setFile_entry_parent(file_entry_parent);
				fileEntry.setFile_entry_size(rst.getLong(5));
				fileEntry.setUser_id(rst.getString(6));
				fileEntry.setFile_entry_upload_date(rst.getTimestamp(7));
				fileEntry.setUser_name(rst.getString(8));
				fileEntryList.add(fileEntry);
			}
		} catch (SQLException e) {
			System.out.println("FileEntryDAO.getFileListByParent() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return fileEntryList;
	}
}
