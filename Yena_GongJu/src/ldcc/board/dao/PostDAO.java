package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ldcc.board.vo.Post;

public class PostDAO {
	private final String getSQL = "select * from POST where POST_CODE = ?";
	private final String insertSQL = "insert into POST values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String updateSQL = "update POST set POST_TITLE=?, POST_CONTENT=?, POST_FILEPATH=?, POST_TYPE=? where POST_CODE=?";
	private final String deleteSQL = "delete from POST where POST_CODE=?";

	/**
	 * select문을 통해 Post VO 1개를 반환
	 * 
	 * @param post_code
	 *            기본키
	 * @return 성공 시 Post 객체, 실패 시 null
	 */
	public Post doGet(int post_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		Post post = null;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getSQL);
			stmt.setInt(1, post_code);
			rst = stmt.executeQuery();

			if (rst.next()) {
				post = new Post();
				post.setPost_code(post_code);
				post.setBoard_code(rst.getInt(2));
				post.setUser_id(rst.getString(3));
				post.setPost_date(rst.getTimestamp(4));
				post.setPost_title(rst.getString(5));
				post.setPost_content(rst.getString(6));
				post.setPost_filepath(rst.getString(7));
				post.setPost_type(rst.getInt(8));
				post.setPost_num(rst.getInt(9));
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return post;
	}

	/**
	 * insert문을 통해 POST VO 1개를 DB에 삽입
	 * 
	 * @param post
	 *            VO 객체
	 * @return 성공 실패 여부
	 */
	public boolean doInsert(Post post) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.insertSQL);
			stmt.setInt(1, post.getPost_code());
			stmt.setInt(2, post.getBoard_code());
			stmt.setString(3, post.getUser_id());
			stmt.setTimestamp(4, post.getPost_date());
			stmt.setString(5, post.getPost_title());
			stmt.setString(6, post.getPost_content());
			stmt.setString(7, post.getPost_filepath());
			stmt.setInt(8, post.getPost_type());
			stmt.setInt(9, post.getPost_num());
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doInsert() error : " + e);
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}

	/**
	 * update문을 통해 POST 1개 수정
	 * 
	 * @param post
	 *            VO 객체
	 * @return 성공 실패 여부
	 */
	public boolean doUpdate(Post post) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.updateSQL);
			stmt.setString(1, post.getPost_title());
			stmt.setString(2, post.getPost_content());
			stmt.setString(3, post.getPost_filepath());
			stmt.setInt(4, post.getPost_type());
			stmt.setInt(5, post.getPost_code());
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doUpdate() error : " + e);
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}

	/**
	 * delete문을 통해 POST 1개 삭제
	 * 
	 * @param post
	 *            VO 객체
	 * @return 성공 실패 여부
	 */
	public boolean doDelete(int post_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.deleteSQL);
			stmt.setInt(1, post_code);
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doUpdate() error : " + e);
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}
}
