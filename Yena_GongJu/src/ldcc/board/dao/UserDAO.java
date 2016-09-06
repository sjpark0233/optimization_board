package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ldcc.board.vo.User;

public class UserDAO {
	private String selectSQL = "select * from User where user_id = ? and user_pw = ?";
	private String insertSQL = "insert into User(user_id,user_pw,user_accept,team_name,user_name,user_phone,user_email) values(?,?,?,?,?,?,?)";
	private String dropSQL = "delete from User where user_id = ? and user_pw = ?";
	private String updateSQL = "update User set team_name = ? ,user_name = ?,user_phone = ?,user_email = ? where user_id = ? and user_pw = ?";
	private String select_allSQL = "select user_id, team_name, user_name, user_phone, user_email, user_accept from User";
	private String find_updateSQL = "update User set user_accept = ? where user_id = ?";
	
 	public void doLogin(User user)
	{
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rst =null;
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(selectSQL);
			stmt.setString(1,user.getUser_id());
			stmt.setString(2, user.getUser_pw());
			rst = stmt.executeQuery();

			if(rst.next()){
				user.setUser_name(rst.getString(5));
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
			stmt.setString(1, user.getUser_id());
			stmt.setString(2, user.getUser_pw());
			stmt.setString(3, Integer.toString(user.getUser_accept()));
			stmt.setString(4, user.getTeam_name());
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
			stmt = con.prepareStatement(selectSQL);
			stmt.setString(1,user.getUser_id());
			stmt.setString(2, user.getUser_pw());
			rst = stmt.executeQuery();

			if(rst.next()){
				user.setUser_id(rst.getString(1));
				user.setTeam_name(rst.getString(4));
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

	public boolean doUpdate(User user)
	{
		Connection con = null;
		PreparedStatement stmt = null;
		
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(updateSQL);
			stmt.setString(1, user.getTeam_name());
			stmt.setString(2, user.getUser_name());
			stmt.setString(3, user.getUser_phone());
			stmt.setString(4, user.getUser_email());
			stmt.setString(5, user.getUser_id());
			stmt.setString(6, user.getUser_pw());

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

	public ArrayList<User> doList()
	{
		ArrayList<User> list = new ArrayList<User>();
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rst =null;
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(select_allSQL);
			rst = stmt.executeQuery();
			
			while(rst.next()==true){
				User user = new User();
				user.setUser_id(rst.getString(1));
				user.setTeam_name(rst.getString(2));
				user.setUser_name(rst.getString(3));
				user.setUser_phone(rst.getString(4));
				user.setUser_email(rst.getString(5));
				user.setUser_accept(Integer.parseInt(rst.getString(6)));
				
				list.add(user);
			}
			return list;
			
		}catch(SQLException e){
			System.out.println("check error : "+e);
			return null;
		}finally{
			JDBCUtil.close(rst, stmt,con);
		}
	}

	public boolean doAccept(String user_id, int accept_num)
	{
		Connection con = null;
		PreparedStatement stmt = null;
		
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(find_updateSQL);
			stmt.setString(1, Integer.toString(accept_num));
			stmt.setString(2, user_id);
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
}
