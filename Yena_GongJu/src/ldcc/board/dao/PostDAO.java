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
	private final String getNoticeListSQL = "select P.*, U.USER_NAME from POST P, User U where POST_TYPE=0 and P.USER_ID=U.USER_ID order by POST_CODE desc";
	private final String getNoticeListSQL2 = "select P.*, U.USER_NAME from POST P, User U where POST_TYPE=0 and P.USER_ID=U.USER_ID and BOARD_CODE=? order by POST_CODE desc";
	private final String getListSQL = "select * from (select @rownum := @rownum + 1 as rnum, P.*  from (select P.*, U.USER_NAME from POST P, USER U where P.USER_ID=U.USER_ID order by POST_CODE desc) P, (select @rownum := 0) R) PR where rnum>=? and rnum<=?";
	private final String getListSQL2 = "select * from (select @rownum := @rownum + 1 as rnum, P.*  from (select P.*, U.USER_NAME from POST P, USER U where BOARD_CODE=? and P.USER_ID=U.USER_ID order by POST_CODE desc) P, (select @rownum := 0) R) PR where rnum>=? and rnum<=?";
	private final String getListAllCountSQL = "select count(*) from POST";
	private final String getListAllCountSQL2 = "select count(*) from POST where BOARD_CODE=?";
	private final String getMaxPostNumSQL = "select max(POST_NUM) as POST_NUM from POST where BOARD_CODE=?";
	private final String insertSQL = "insert into POST(BOARD_CODE, USER_ID, POST_DATE, POST_TITLE, POST_CONTENT, POST_FILEPATH, POST_TYPE, POST_NUM, POST_VIEW) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String updateSQL = "update POST set BOARD_CODE=?, POST_TITLE=?, POST_CONTENT=?, POST_TYPE=? where POST_CODE=?";
	private final String updateSQL2 = "update POST set BOARD_CODE=?, POST_TITLE=?, POST_CONTENT=?, POST_FILEPATH=?, POST_TYPE=? where POST_CODE=?";
	private final String deleteSQL = "delete from POST where POST_CODE=?";
	private final String increaseViewSQL = "update POST set POST_VIEW=POST_VIEW+1 where POST_CODE=?";

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
				post.setPost_view(rst.getInt(10));
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return post;
	}

	public List<Post> doGetNoticeList(List<String> noticeUserList) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Post> postList = new ArrayList<Post>();

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getNoticeListSQL);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Post post = new Post();
				post.setPost_code(rst.getInt(1));
				post.setBoard_code(rst.getInt(2));
				post.setUser_id(rst.getString(3));
				post.setPost_date(rst.getTimestamp(4));
				post.setPost_title(rst.getString(5));
				post.setPost_content(rst.getString(6));
				post.setPost_filepath(rst.getString(7));
				post.setPost_type(rst.getInt(8));
				post.setPost_num(rst.getInt(9));
				post.setPost_view(rst.getInt(10));
				noticeUserList.add(rst.getString(11));
				postList.add(post);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return postList;
	}

	public List<Post> doGetNoticeList(int board_code, List<String> noticeUserList) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Post> postList = new ArrayList<Post>();

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getNoticeListSQL2);
			stmt.setInt(1, board_code);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Post post = new Post();
				post.setPost_code(rst.getInt(1));
				post.setBoard_code(rst.getInt(2));
				post.setUser_id(rst.getString(3));
				post.setPost_date(rst.getTimestamp(4));
				post.setPost_title(rst.getString(5));
				post.setPost_content(rst.getString(6));
				post.setPost_filepath(rst.getString(7));
				post.setPost_type(rst.getInt(8));
				post.setPost_num(rst.getInt(9));
				post.setPost_view(rst.getInt(10));
				noticeUserList.add(rst.getString(11));
				postList.add(post);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return postList;
	}

	public List<Post> doGetList(int page, List<String> postUserList) {
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
				post.setPost_code(rst.getInt(2)); // index 1은 rownum임
				post.setBoard_code(rst.getInt(3));
				post.setUser_id(rst.getString(4));
				post.setPost_date(rst.getTimestamp(5));
				post.setPost_title(rst.getString(6));
				post.setPost_content(rst.getString(7));
				post.setPost_filepath(rst.getString(8));
				post.setPost_type(rst.getInt(9));
				post.setPost_num(rst.getInt(10));
				post.setPost_view(rst.getInt(11));
				postUserList.add(rst.getString(12));
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
	 * select문을 통해 List<Post> 객체를 반환. 게시판 화면에서 페이지에 따른 게시물만을 불러옴.
	 * 
	 * @param page
	 *            화면 페이지
	 * @return this.pageLimit 수 만큼 Page객체 리스트를 반환
	 */
	public List<Post> doGetList(int board_code, int page, List<String> postUserList) {
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
				post.setPost_code(rst.getInt(2)); // index 1 은 rownum임
				post.setBoard_code(board_code);
				post.setUser_id(rst.getString(4));
				post.setPost_date(rst.getTimestamp(5));
				post.setPost_title(rst.getString(6));
				post.setPost_content(rst.getString(7));
				post.setPost_filepath(rst.getString(8));
				post.setPost_type(rst.getInt(9));
				post.setPost_num(rst.getInt(10));
				post.setPost_view(rst.getInt(11));
				postUserList.add(rst.getString(12));
				postList.add(post);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return postList;
	}

	public int doGetListAllCount() {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		int count = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListAllCountSQL);
			rst = stmt.executeQuery();

			if (rst.next()) {
				count = rst.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return count;
	}

	public int doGetListAllCount(int board_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		int count = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListAllCountSQL2);
			stmt.setInt(1, board_code);
			rst = stmt.executeQuery();

			if (rst.next()) {
				count = rst.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("PostDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return count;
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
	 * update문을 통해 POST 1개 수정
	 * 
	 * @param post
	 *            VO 객체
	 * @return 성공 실패 여부
	 */
	public boolean doUpdate(Post post, boolean fileEdited) {
		Connection con = null;
		PreparedStatement stmt = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			if (!fileEdited) {
				stmt = con.prepareStatement(this.updateSQL);
				stmt.setInt(4, post.getPost_type());
				stmt.setInt(5, post.getPost_code()); // where 조건
			} else {
				stmt = con.prepareStatement(this.updateSQL2);
				stmt.setString(4, post.getPost_filepath());
				stmt.setInt(5, post.getPost_type());
				stmt.setInt(6, post.getPost_code()); // where 조건
			}
			stmt.setInt(1, post.getBoard_code());
			stmt.setString(2, post.getPost_title());
			stmt.setString(3, post.getPost_content());
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

	public boolean doIncreaseView(int post_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		int retval = 0;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.increaseViewSQL);
			stmt.setInt(1, post_code);
			retval = stmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("PostDAO.doIncreaseView() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return retval == 1;
	}
}
