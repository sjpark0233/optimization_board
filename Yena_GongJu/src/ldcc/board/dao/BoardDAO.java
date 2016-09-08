package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ldcc.board.vo.Board;

public class BoardDAO {
	private final String getSQL = "select * from BOARD where BOARD_CODE=?";
	private final String getListSQL = "select * from BOARD order by BOARD_CODE asc";

	/**
	 * select문을 통해 Board VO 1개를 반환
	 * 
	 * @param board_code
	 *            기본키
	 * @return 성공시 Board 객체, 실패 시 null
	 */
	public Board doGet(int board_code) {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		Board board = null;

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getSQL);
			stmt.setInt(1, board_code);
			rst = stmt.executeQuery();

			if (rst.next()) {
				board = new Board();
				board.setBoard_code(rst.getInt(1));
				board.setBoard_name(rst.getString(2));
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO.doGet() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return board;
	}

	/**
	 * select 문을 통해 Board VO의 리스트를 반환
	 * 
	 * @return 모든 Board 레코드를 VO화 한 것
	 */
	public List<Board> doGetList() {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		List<Board> boardList = new ArrayList<Board>();

		try {
			con = JDBCUtil.getConnection();
			stmt = con.prepareStatement(this.getListSQL);
			rst = stmt.executeQuery();

			while (rst.next()) {
				Board board = new Board();
				board.setBoard_code(rst.getInt(1));
				board.setBoard_name(rst.getString(2));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO.doGetList() error : " + e.getMessage());
		} finally {
			JDBCUtil.close(rst, stmt, con);
		}

		return boardList;
	}
}
