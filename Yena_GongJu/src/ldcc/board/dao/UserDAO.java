package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ldcc.board.vo.User;

public class UserDAO {
	private String loginSQL = "select * from User where user_id = ? and user_pw = ?";
	private String checkSQL = "select * from User where user_id = ?";
	private String insertSQL = "insert into User(user_id,user_pw,user_accept,team_code,user_name,user_phone,user_email)";
	
	public void doLogin(User user){
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rst =null;
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(loginSQL);
			stmt.setString(1,user.getUser_id());
			stmt.setString(2, user.getUser_pw());
			rst = stmt.executeQuery();
			
			if(rst.next()){
				user.setUser_name(rst.getString(5));
				System.out.println(user.getUser_name());
			}
		}catch(SQLException e){
			System.out.println("login error : "+e);
		}finally{
			JDBCUtil.close(rst, stmt,con);
		}
	}
}
