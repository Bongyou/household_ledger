package my.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import my.util.ConnUtil;

public class MemberDao {
	public int insertMember(MemberVo vo) {
		int rst=0;
		java.sql.Statement st=null;
		Connection conn=null;
		PreparedStatement ps=null;
		try {
			conn=ConnUtil.getConnection();
			String sql="insert into member values(null,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPasswd());
			ps.setString(3, vo.getName());
			ps.setString(4, vo.getGender());
			rst=ps.executeUpdate();
			//������ ����� ���̺� ����
			st = conn.createStatement();
			//id = ���̵�, date1 = ����, date2 = ��, date4 = ��, sort=�з�, 
			//gname = ��ǰ����, price = ����, price2 = ����
			st.executeUpdate("CREATE TABLE `user_"+vo.getId()+"`(\r\n" + 
					 "`id` VARCHAR(15) NOT NULL, \r\n"+
					  "`date1` INT(6),\r\n"+
					  "`date2` INT(6),\r\n"+
					  "`date4` INT(6),\r\n"+
					  "`sort` VARCHAR(20),\r\n"+
					  "`gname` VARCHAR(20),\r\n"+
					  "`price` VARCHAR(20),\r\n"+
					  "`price2` VARCHAR(20)\r\n"+
					")ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public int idCheck(String id) {
		int rst=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			conn=ConnUtil.getConnection();
			String sql="select*from member where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				rst=1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnUtil.close(rs, ps,conn);
		}
		return rst;
	}
	
	public int loginCheck(String id,String passwd) {
		int rst=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			conn=ConnUtil.getConnection();
			String sql="select*from member where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				String DBpasswd=rs.getString("passwd");
				if((DBpasswd.trim()).equals((passwd.trim()))) {
					rst=2; //�α��� ����
				}
				else {
					rst=1; //��й�ȣ ����
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnUtil.close(rs,ps,conn);
		}
		return rst;
	}
}
