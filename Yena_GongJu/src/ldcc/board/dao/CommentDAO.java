package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ldcc.board.vo.Comment;
import ldcc.board.vo.User;

public class CommentDAO {
	private String select_allSQL = "select comment_code, comment_user_name, comment_user_id, comment_content, comment_date from Comment where post_code = ? ";
	private String updateSQL = "update Comment set comment_content = ? where comment_code = ? ";
	private String deleteSQL = "delete from Comment where comment_code = ?";
	private String insertSQL = "insert into Comment(post_code, user_id, comment_date, comment_content) values(?,?,now(),?)";

	public ArrayList<Comment> doList(int post_code)
	{
		ArrayList<Comment> list = new ArrayList<Comment>();
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rst =null;
		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(select_allSQL);
			stmt.setString(1, Integer.toString(post_code));
			rst = stmt.executeQuery();

			while(rst.next()==true){
				Comment comment = new Comment();
				comment.setComment_code(Integer.parseInt(rst.getString(1)));
				comment.setComment_user_name(rst.getString(2));
				comment.setUser_id(rst.getString(3));
				comment.setComment_content(rst.getString(4));
				comment.setComment_date(rst.getString(5));

				list.add(comment);
			}
			return list;

		}catch(SQLException e){
			System.out.println("check error : "+e);
			return null;
		}finally{
			JDBCUtil.close(rst, stmt,con);
		}
	}

	public boolean doUpdate(Comment comment)
	{
		Connection con = null;
		PreparedStatement stmt = null;

		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(updateSQL);
			stmt.setString(1, comment.getComment_content());
			stmt.setString(2, Integer.toString(comment.getComment_code()));

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

	public boolean doDelete(int comment_code)
	{
		Connection con = null;
		PreparedStatement stmt = null;

		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(deleteSQL);
			stmt.setString(1, Integer.toString(comment_code));
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

	public boolean doInsert(Comment comment)
	{
		Connection con = null;
		PreparedStatement stmt = null;

		try{
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(insertSQL);
			stmt.setString(1, Integer.toString(comment.getPost_code()));
			stmt.setString(2, comment.getUser_id());
			stmt.setString(3, comment.getComment_content());
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
