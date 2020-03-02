package my.entry;

import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import my.util.ConnUtil;

public class EntryDao {
	public int EntryConsume(EntryVo vo,String id) {
		int rst=0;
		Connection conn=null;
		PreparedStatement ps=null;
		try {
			conn=ConnUtil.getConnection();
			
			String sql="insert into insert values(?,?,?,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(0, id);
			ps.setInt(1, vo.getDate1());
			ps.setInt(2, vo.getDate2());
			ps.setInt(3, vo.getDate3());
			ps.setString(4, vo.getType());
			ps.setString(5, vo.getG_name());
			ps.setString(6, vo.getPrice());
			ps.setInt(7, vo.getCount());
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnUtil.close(ps,conn);
		}
		return rst;
	}
	
	
}
