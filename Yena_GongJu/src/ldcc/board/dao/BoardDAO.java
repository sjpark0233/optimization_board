package ldcc.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ldcc.board.vo.Board;

public class BoardDAO {
	private final String getListSQL = "select * from BOARD order by BOARD_CODE desc";

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
