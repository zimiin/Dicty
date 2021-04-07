package wordList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class WordListDAO {

	public int insert(WordListDTO wordListDTO) {
		String SQL = "INSERT INTO WORDLIST VALUES(?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, wordListDTO.getWord());
			pstmt.setString(2, wordListDTO.getDef());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<WordListDTO> getList() {
		
		ArrayList<WordListDTO> wordList = null;
		String SQL = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			SQL = "SELECT * FROM WORDLIST";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			wordList = new ArrayList<WordListDTO>();
			
			while (rs.next()) {
				WordListDTO word = new WordListDTO(
					rs.getString(1),
					rs.getString(2)
				);
				
				wordList.add(word);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		
		return wordList;
	}
}