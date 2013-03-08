package utils;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.User;

public class AdminDB {
	DB db = new DB();
	
	public int add(String username, String password, String email){
		db.connect_db();
		try{
			String sql = "insert into admins(username, password, email) values (?, ?, ?)";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, username);
			db.ps.setString(2, password);
			db.ps.setString(3, email);
			int count = db.ps.executeUpdate();
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}	
	
	public User get(String email, String password){
		db.connect_db();
		ResultSet rs=null;
		User user = null;
		
		try{
			String sql = "SELECT * FROM admins where password=? and email=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, password);
			db.ps.setString(2, email);
			rs = (ResultSet) db.ps.executeQuery();
			if (rs.next()){
				user = new User(); 
				user.setEmail(rs.getString("email"));
				user.setUsername(rs.getString("username"));
				user.setId(rs.getInt("id"));
				user.setPassword(rs.getString("password"));
			}
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
		return user;
	}
	

	public User get_by_id(int id){
		db.connect_db();
		ResultSet rs=null;
		User user = null;
		
		try{
			String sql = "SELECT * FROM admins where id=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			rs = (ResultSet) db.ps.executeQuery();
			if (rs.next()){
				user = new User(); 
				user.setEmail(rs.getString("email"));
				user.setUsername(rs.getString("username"));
				user.setId(rs.getInt("id"));
				user.setPassword(rs.getString("password"));
			}
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
		return user;
	}
	
	public ArrayList<User> get_all_admins() {
        ResultSet rs=null;
        ArrayList<User> admins = new ArrayList<User>();
        db.connect_db();
        try {
        	String sql = "SELECT * from admins";
	    	db.ps = db.conn.prepareStatement(sql);
	    	rs = db.ps.executeQuery();
	    	while(rs.next()){
	    		User admin = new User();
	    		admin.setEmail(rs.getString("email"));
	    		admin.setPassword(rs.getString("password"));
	    		admin.setUsername(rs.getString("username"));
	    		admin.setId(rs.getInt("id"));
	    		admins.add(admin);	    		
	    	} 

        } catch (Exception e) {
           	e.printStackTrace();
        } finally{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			db.close_db();
		}		
        return admins;
    }

	public int delete(int id){
		db.connect_db();
		try{
			String sql = "DELETE FROM admins WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			int count = db.ps.executeUpdate();
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}

	public void modify(int id, String email, String password, String username) {
		delete(id);
		add(username, password, email);
	}

}