package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ldcc.board.vo.User;

public class UserDAO {
	private String loginSQL = "select * from User where user_id = ? and user_pw = ?";
	private String checkSQL = "select * from User where user_id = ?";
	private String insertSQL = "insert into User(user_id,user_pw,user_accept,team_code,user_name,user_phone,user_email) values(?,?,?,?,?,?,?)";
	private String dropSQL = "delete from User where user_id = ? and user_pw = ?";
	
	public void doLogin(User user)
	{
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

	public boolean doInsert(User user)
	{
		Connection con = null;
		PreparedStatement stmt = null;
		
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(insertSQL);
			stmt.setString(1, user.getUser_name());
			stmt.setString(2, user.getUser_id());
			stmt.setString(3, Integer.toString(user.getUser_accept()));
			stmt.setString(4, Integer.toString(user.getTeam_code()));
			stmt.setString(5, user.getUser_name());
			stmt.setString(6, user.getUser_phone());
			stmt.setString(7, user.getUser_email());

			int cnt = stmt.executeUpdate();
			
			System.out.println(cnt ==1 ? "insert success" : "fail");
			if(cnt ==1)
			{
				JDBCUtil.close(stmt,con);
				return true;
			}
			else
			{
				JDBCUtil.close(stmt, con);
				return false;
			}
			
		}catch(SQLException e){
			System.out.println("user insert error : " + e);
			JDBCUtil.close(stmt, con);
			return false;
		}
	}

	public boolean doWithdraw(User user)
	{
		Connection con =null;
		PreparedStatement stmt = null;
		
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(dropSQL);
			stmt.setString(1,user.getUser_id());
			stmt.setString(2,user.getUser_pw());
			int cnt = stmt.executeUpdate();
			
			System.out.println(cnt ==1 ? "insert success" : "fail");
			if(cnt == 1){
				JDBCUtil.close(stmt,con);
				return true;
			}
			else
			{
				JDBCUtil.close(stmt,con);
				System.out.println("비밀번호를 확인해주세요");
				return false;
			}
		}catch(SQLException e){
			System.out.println("user drop error : " + e);
			JDBCUtil.close(stmt, con);
			return false;
		}
	}

	public void doCheck(User user)
	{
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rst =null;
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(checkSQL);
			stmt.setString(1,user.getUser_id());
			rst = stmt.executeQuery();

			if(rst.next()){
				user.setTeam_code(Integer.parseInt(rst.getString(4)));
				user.setUser_name(rst.getString(5));
				user.setUser_phone(rst.getString(6));
				user.setUser_email(rst.getString(7));
			}
		}catch(SQLException e){
			System.out.println("check error : "+e);
		}finally{
			JDBCUtil.close(rst, stmt,con);
		}
	}



}
