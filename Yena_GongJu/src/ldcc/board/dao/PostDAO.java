package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import ldcc.board.vo.Post;

public class PostDAO {
	private final int pageLimit = 10;
	private final String getSQL = "select * from POST where POST_CODE = ?";
	private final String getListSQL = "select * from (select rownum rnum, POST_CODE, BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM, POST_VIEW  from (select * from POST order by POST_NUM desc)) where rnum>=? and rnum<=?";
	private final String getListSQL2 = "select * from (select rownum rnum, POST_CODE, BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM, POST_VIEW  from (select * from POST where BOARD_CODE=? order by POST_NUM desc)) where rnum>=? and rnum<=?";
	private final String getMaxPostNumSQL = "select max(POST_NUM) as POST_NUM from POST where BOARD_CODE=?";
	private final String insertSQL = "insert into POST(BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM, POST_VIEW) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String updateSQL = "update POST set BOARD_CODE=?, POST_TITLE=?, POST_CONTENT=?, POST_FILEPATH=?, POST_TYPE=? where POST_CODE=?";
	private final String deleteSQL = "delete from POST where POST_CODE=?";

	/**
	 * select���� ���� Post VO 1���� ��ȯ
	 * 
	 * @param post_code
	 *            �⺻Ű
	 * @return ���� �� Post ��ü, ���� �� null
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
				post.setPost_view(rst.getInt(10));
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return post;
	}

	public List<Post> doGetList(int page) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Post> postList = new ArrayList<Post>();
		int startRow = (page - 1) * this.pageLimit + 1;
		int endRow = startRow + this.pageLimit - 1;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListSQL);
			stmt.setInt(1, startRow);
			stmt.setInt(2, endRow);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Post post = new Post();
				post.setPost_code(rst.getInt(2)); // index 1�� rownum��
				post.setBoard_code(rst.getInt(3));
				post.setUser_id(rst.getString(4));
				post.setPost_date(rst.getTimestamp(5));
				post.setPost_title(rst.getString(6));
				post.setPost_content(rst.getString(7));
				post.setPost_filepath(rst.getString(8));
				post.setPost_type(rst.getInt(9));
				post.setPost_num(rst.getInt(10));
				post.setPost_view(rst.getInt(11));
				postList.add(post);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return postList;

	}

	/**
	 * select���� ���� List<Post> ��ü�� ��ȯ. �Խ��� ȭ�鿡�� �������� ���� �Խù����� �ҷ���.
	 * 
	 * @param page
	 *            ȭ�� ������
	 * @return this.pageLimit �� ��ŭ Page��ü ����Ʈ�� ��ȯ
	 */
	public List<Post> doGetList(int board_code, int page) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Post> postList = new ArrayList<Post>();
		int startRow = (page - 1) * this.pageLimit + 1;
		int endRow = startRow + this.pageLimit - 1;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListSQL2);
			stmt.setInt(1, board_code);
			stmt.setInt(2, startRow);
			stmt.setInt(3, endRow);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Post post = new Post();
				post.setPost_code(rst.getInt(2)); // index 1 �� rownum��
				post.setBoard_code(board_code);
				post.setUser_id(rst.getString(4));
				post.setPost_date(rst.getTimestamp(5));
				post.setPost_title(rst.getString(6));
				post.setPost_content(rst.getString(7));
				post.setPost_filepath(rst.getString(8));
				post.setPost_type(rst.getInt(9));
				post.setPost_num(rst.getInt(10));
				post.setPost_view(rst.getInt(11));
				postList.add(post);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return postList;
	}

	/**
	 * insert���� ���� POST VO 1���� DB�� ����
	 * 
	 * @param post
	 *            VO ��ü
	 * @return ���� ���� ����
	 */
	public boolean doInsert(Post post) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.insertSQL);
			stmt.setInt(1, post.getBoard_code());
			stmt.setString(2, post.getUser_id());
			stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			stmt.setString(4, post.getPost_title());
			stmt.setString(5, post.getPost_content());
			stmt.setString(6, post.getPost_filepath());
			stmt.setInt(7, post.getPost_type()); // 0 - ����, 1 - �Ϲ�
			int newPostNum = this.doGetMaxPostNumByBoardNum(post.getBoard_code()) + 1;
			stmt.setInt(8, newPostNum); // �˰��� �ʿ�
			stmt.setInt(9, 0);
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doInsert() error : " + e);
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}

	/**
	 * update���� ���� POST 1�� ����
	 * 
	 * @param post
	 *            VO ��ü
	 * @return ���� ���� ����
	 */
	public boolean doUpdate(Post post) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.updateSQL);
			stmt.setInt(1, post.getBoard_code());
			stmt.setString(2, post.getPost_title());
			stmt.setString(3, post.getPost_content());
			stmt.setString(4, post.getPost_filepath());
			stmt.setInt(5, post.getPost_type());
			stmt.setInt(6, post.getPost_code()); // where ����
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doUpdate() error : " + e);
		} finally {
			JDBCUtil.close(stmt, con);
		}

		return retval == 1;
	}

	/**
	 * delete���� ���� POST 1�� ����
	 * 
	 * @param post
	 *            VO ��ü
	 * @return ���� ���� ����
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

	/**
	 * select���� ���� �ش� BOARD_CODE���� POST_NUM�� �ְ��� ��ȯ
	 * 
	 * @param board_code
	 *            �Խ��� �ڵ�
	 * @return �ش� �Խ��ǿ� �Խù��� ������ 0 ��ȯ
	 */
	private int doGetMaxPostNumByBoardNum(int board_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getMaxPostNumSQL);
			stmt.setInt(1, board_code);
			rst = stmt.executeQuery();

			if (rst.next()) {
				retval = rst.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetMaxPostNumByBoardNum() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return retval;
	}
}
