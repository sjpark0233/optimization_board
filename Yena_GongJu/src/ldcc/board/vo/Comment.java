package ldcc.board.vo;

public class Comment {
	private int comment_code;
	private int post_code;
	private String user_id;
	private String comment_date;
	private String comment_content;
	private String comment_user_name;
//	private int comment_auth; //0:권한 없음 1:권한 있음

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

	public String getComment_date() {
		return comment_date;
	}

	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_user_name() {
		return comment_user_name;
	}

	public void setComment_user_name(String comment_user_name) {
		this.comment_user_name = comment_user_name;
	}
//	
//	public int getComment_auth() {
//		return comment_auth;
//	}
//
//	public void setComment_auth(int comment_auth) {
//		this.comment_auth = comment_auth;
//	}
//	
}
