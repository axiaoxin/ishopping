package utils;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.User;

public class UserDB {
	DB db = new DB();
	
	public int add(User user){
		db.connect_db();
		try{
			String sql = "insert into users(username, password, email) values (?, ?, ?)";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, user.getUsername());
			db.ps.setString(2, user.getPassword());
			db.ps.setString(3, user.getEmail());
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
			String sql = "SELECT * FROM users where password=? and email=?";
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
				user.setReg_time(rs.getDate("register_time"));
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

	public ArrayList<User> get_all_users() {
        ResultSet rs=null;
        ArrayList<User> users = new ArrayList<User>();
        db.connect_db();
        try {
        	String sql = "SELECT * from users";
	    	db.ps = db.conn.prepareStatement(sql);
	    	rs = db.ps.executeQuery();
	    	while(rs.next()){
	    		User user = new User();
	    		user.setEmail(rs.getString("email"));
	    		user.setPassword(rs.getString("password"));
	    		user.setUsername(rs.getString("username"));
	    		user.setId(rs.getInt("id"));
				user.setReg_time(rs.getDate("register_time"));
	    		users.add(user);	    		
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
        return users;
    }
	

	public User get_by_id(int id){
		db.connect_db();
		ResultSet rs=null;
		User user = null;
		
		try{
			String sql = "SELECT * FROM users where id=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			rs = (ResultSet) db.ps.executeQuery();
			if (rs.next()){
				user = new User(); 
				user.setEmail(rs.getString("email"));
				user.setUsername(rs.getString("username"));
				user.setId(rs.getInt("id"));
				user.setPassword(rs.getString("password"));
				user.setReg_time(rs.getDate("register_time"));
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
	
	public int delete(int id){
		db.connect_db();
		try{
			String sql = "DELETE FROM users WHERE id = ?";
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

	public int modify_username(int id, String username){
		db.connect_db();
		try{
			String sql = "UPDATE users SET username = ? WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, username);
			db.ps.setInt(2, id);
			int count = db.ps.executeUpdate();
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}
	
	public int modify_passwd(int id, String passwd){
		db.connect_db();
		try{
			String sql = "UPDATE users SET password = ? WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, passwd);
			db.ps.setInt(2, id);
			int count = db.ps.executeUpdate();
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}
}