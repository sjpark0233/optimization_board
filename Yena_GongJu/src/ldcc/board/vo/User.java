package ldcc.board.vo;

public class User {
	private String user_id;
	private String user_pw;
	private int user_accept;
	private int team_code;
	private String user_name;
	private String user_phone;
	private String user_email;

	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public int getUser_accept() {
		return user_accept;
	}
	public void setUser_accept(int user_accept) {
		this.user_accept = user_accept;
	}
	public int getTeam_code() {
		return team_code;
	}
	public void setTeam_code(int team_code) {
		this.team_code = team_code;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
}
