package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import ldcc.board.vo.Comment;

public class CommentDAO {
	private final String getSQL = "select * from COMMENT where COMMENT_CODE=?";
	private final String getListSQL = "select C.*, U.USER_NAME from COMMENT C, User U where C.USER_ID=U.USER_ID and POST_CODE=? order by COMMENT_CODE asc";
	private final String insertSQL = "insert into COMMENT(POST_CODE, USER_ID, COMMENT_DATE, COMMENT_CONTENT) values(?,?,?,?)";
	private final String updateSQL = "update COMMENT set COMMENT_CONTENT = ? where COMMENT_CODE = ?";
	private final String deleteSQL = "delete from COMMENT where COMMENT_CODE = ?";
	
	public Comment doGet(int comment_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		Comment comment = null;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getSQL);
			stmt.setInt(1, comment_code);
			rst = stmt.executeQuery();

			if (rst.next()) {
				comment = new Comment();
				comment.setComment_code(comment_code);
				comment.setPost_code(rst.getInt(2));
				comment.setUser_id(rst.getString(3));
				comment.setComment_date(rst.getTimestamp(4));
				comment.setComment_content(rst.getString(5));
			}
		} catch (SQLException e) {
			System.out.println("CommentDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return comment;
	}

	/**
	 * 
	 * @param post_code
	 * @param commentUserList
	 * @return
	 */
	public List<Comment> doGetList(int post_code, List<String> commentUserList) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Comment> commentList = new ArrayList<Comment>();

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListSQL);
			stmt.setInt(1, post_code);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Comment comment = new Comment();
				comment.setComment_code(rst.getInt(1));
				comment.setPost_code(rst.getInt(2));
				comment.setUser_id(rst.getString(3));
				comment.setComment_date(rst.getTimestamp(4));
				comment.setComment_content(rst.getString(5));
				commentUserList.add(rst.getString(6));
				commentList.add(comment);
			}
		} catch (SQLException e) {
			System.out.println("CommentDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return commentList;
	}

	/**
	 * insert문을 통해 COMMENT VO 1개를 DB에 삽입
	 * 
	 * @param comment
	 *            VO 객체
	 * @return 성공 실패 여부
	 */
	public boolean doInsert(Comment comment) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.insertSQL);
			stmt.setInt(1, comment.getPost_code());
			stmt.setString(2, comment.getUser_id());
			stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			stmt.setString(4, comment.getComment_content());
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("CommentDAO.doInsert() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}

	public boolean doUpdate(Comment comment) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.updateSQL);
			stmt.setString(1, comment.getComment_content());
			stmt.setInt(2, comment.getComment_code());
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("CommentDAO.doUpdate() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(stmt, con);
		}
		
		return retval == 1;
	}

	public boolean doDelete(int comment_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.deleteSQL);
			stmt.setInt(1, comment_code);
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("CommentDAO.doDelete() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(stmt, con);
		}
		
		return retval == 1;
	}
}
