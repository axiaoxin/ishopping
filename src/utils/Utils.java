package utils;

import org.apache.commons.codec.digest.DigestUtils;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Utils {
	public boolean exist_email(String email){
		DB db = new DB();
		db.connect_db();
		ResultSet rs = null;
		
		try{
			String sql = "SELECT * FROM users where email=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, email);
			rs = db.ps.executeQuery();
			return rs.next();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.close_db();
		}
		return false;
	}

	public boolean check_password(String p1, String p2)	{
		if (p1.equals(p2)){
			return true;
		}
		return false;
	}
	
	public boolean exist_username(String username){
		DB db = new DB();
		db.connect_db();
		ResultSet rs = null;
		
		try{
			String sql = "SELECT * FROM users where username=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, username);
			rs = db.ps.executeQuery();
			return rs.next();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.close_db();
		}
		return false;
	}
	
	public String crypt_password(String password){ 
		return DigestUtils.sha256Hex(password);
	}
	
	public boolean exist_admin_email(String email){
		DB db = new DB();
		db.connect_db();
		ResultSet rs = null;
		
		try{
			String sql = "SELECT * FROM admins where email=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, email);
			rs = db.ps.executeQuery();
			return rs.next();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.close_db();
		}
		return false;
	}
	
	public boolean exist_adminname(String username){
		DB db = new DB();
		db.connect_db();
		ResultSet rs = null;
		
		try{
			String sql = "SELECT * FROM admins where username=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, username);
			rs = db.ps.executeQuery();
			return rs.next();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.close_db();
		}
		return false;
	}
}