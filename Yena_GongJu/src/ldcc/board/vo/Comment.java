package ldcc.board.vo;

import java.sql.Timestamp;

public class Comment {
	private int comment_code;
	private int post_code;
	private String user_id;
	private Timestamp comment_date;
	private String comment_content;
	private String user_name; // table¿¡ ¾ø´Â column

	public int getComment_code() {
		return comment_code;
	}

	public void setComment_code(int comment_code) {
		this.comment_code = comment_code;
	}

	public int getPost_code() {
		return post_code;
	}

	public void setPost_code(int post_code) {
		this.post_code = post_code;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Timestamp getComment_date() {
		return comment_date;
	}

	public void setComment_date(Timestamp comment_date) {
		this.comment_date = comment_date;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
}
