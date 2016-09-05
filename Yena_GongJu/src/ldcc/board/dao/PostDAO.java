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
	private final String getListSQL = "select * from (select rownum as rnum, POST_CODE, BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM  from (select * from POST where BOARD_CODE=? order by POST_NUM desc)) where rnum>=? and rnum<=?";
	private final String getMaxPostNumSQL = "select max(POST_NUM) as POST_NUM from POST where BOARD_CODE=?";
	private final String insertSQL = "insert into POST(BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM) values(?, ?, ?, ?, ?, ?, ?, ?)";
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
	 * 
	 * @param page
	 * @return
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
			stmt = con.prepareStatement(this.getListSQL);
			stmt.setInt(1, board_code);
			stmt.setInt(2, startRow);
			stmt.setInt(3, endRow);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Post post = new Post();
				post.setPost_code(rst.getInt(2));
				post.setBoard_code(board_code);
				post.setUser_id(rst.getString(4));
				post.setPost_date(rst.getTimestamp(5));
				post.setPost_title(rst.getString(6));
				post.setPost_content(rst.getString(7));
				post.setPost_filepath(rst.getString(8));
				post.setPost_type(rst.getInt(9));
				post.setPost_num(rst.getInt(10));
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
			stmt.setInt(1, post.getBoard_code());
			stmt.setString(2, post.getUser_id());
			stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			stmt.setString(4, post.getPost_title());
			stmt.setString(5, post.getPost_content());
			stmt.setString(6, post.getPost_filepath());
			stmt.setInt(7, post.getPost_type()); // 0 - 공지, 1 - 일반
			int newPostNum = this.doGetMaxPostNumByBoardNum(post.getBoard_code()) + 1;
			stmt.setInt(8, newPostNum); // 알고리즘 필요
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
			stmt.setInt(5, post.getPost_code()); // where 조건
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

	/**
	 * select문을 통해 해당 BOARD_CODE에서 POST_NUM의 최고값을 반환
	 * 
	 * @param board_code
	 *            게시판 코드
	 * @return 해당 게시판에 게시물이 없으면 0 반환
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
