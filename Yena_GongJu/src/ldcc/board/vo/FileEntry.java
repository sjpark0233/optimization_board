package ldcc.board.vo;

import java.sql.Timestamp;

public class FileEntry {
	private int file_entry_code;
	private int file_entry_type; // smallint - 0:dir, 1:file
	private String file_entry_name;
	private int file_entry_parent;
	private long file_entry_size;
	private String user_id;
	private Timestamp file_entry_upload_date;
	private String user_name;

	public int getFile_entry_code() {
		return file_entry_code;
	}

	public void setFile_entry_code(int file_entry_code) {
		this.file_entry_code = file_entry_code;
	}

	public int getFile_entry_type() {
		return file_entry_type;
	}

	public void setFile_entry_type(int file_entry_type) {
		this.file_entry_type = file_entry_type;
	}

	public String getFile_entry_name() {
		return file_entry_name;
	}

	public void setFile_entry_name(String file_entry_name) {
		this.file_entry_name = file_entry_name;
	}

	public int getFile_entry_parent() {
		return file_entry_parent;
	}

	public void setFile_entry_parent(int file_entry_parent) {
		this.file_entry_parent = file_entry_parent;
	}

	public long getFile_entry_size() {
		return file_entry_size;
	}

	public void setFile_entry_size(long file_entry_size) {
		this.file_entry_size = file_entry_size;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Timestamp getFile_entry_upload_date() {
		return file_entry_upload_date;
	}

	public void setFile_entry_upload_date(Timestamp file_entry_upload_date) {
		this.file_entry_upload_date = file_entry_upload_date;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public boolean isFile() {
		return this.file_entry_type == 1;
	}
}
