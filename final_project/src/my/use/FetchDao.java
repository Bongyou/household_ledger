package my.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import my.util.ConnUtil;

public class FetchDao {
	public void Search_year(String loginId,int date1) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try{
			conn=ConnUtil.getConnection();
			String sql="select * from `user_`"+loginId;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				String id=rs.getString("id");
				if(loginId.equals(id.trim())){
					int year=rs.getInt("date1");
					if(date1==year) {
						
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnUtil.close(ps, conn);
		}
	}
	
	public void Search_month(String loginId,int date2) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try{
			conn=ConnUtil.getConnection();
			String sql="select * from `user_`"+loginId;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				String id=rs.getString("id");
				if(loginId.equals(id.trim())){
					int month=rs.getInt("date2");
					if(date2==month) {
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnUtil.close(ps, conn);
		}
	}
	
	public void Search_sort(String loginId,String sort) {
		
	}
}
