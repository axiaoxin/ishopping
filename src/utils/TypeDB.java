package utils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Type;

public class TypeDB {
	DB db = new DB();
	
	public int add(String type_name){
		db.connect_db();
		try{
			String sql = "insert into goodstypes(type) values (?)";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, type_name);
			int count = db.ps.executeUpdate();
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}

	public ArrayList<Type> get_all_types() {
        ResultSet rs=null;
        ArrayList<Type> types = new ArrayList<Type>();
        db.connect_db();
        try {
        	String sql = "SELECT * from goodstypes";
	    	db.ps = db.conn.prepareStatement(sql);
	    	rs = db.ps.executeQuery();
	    	while(rs.next()){
	    		Type type = new Type();
	    		type.setType_name(rs.getString("type"));
	    		type.setId(rs.getInt("id"));
	    		types.add(type);	    		
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
        return types;
    }
	

	public int delete(int id){
		db.connect_db();
		try{
			String sql = "DELETE FROM goodstypes WHERE id = ?";
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

	public Type get(int id){
		db.connect_db();
        ResultSet rs=null;
        Type type = new Type();
		try{
			String sql = "select * FROM goodstypes WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
	    	rs = db.ps.executeQuery();
	    	if (rs.next()){
	    		type.setType_name(rs.getString("type"));
	    		type.setId(rs.getInt("id"));	
	    	} 
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.close_db();
		}
		return type;
	}
	
	public int modify(int id, String type_name){
		db.connect_db();
		try{
			String sql = "UPDATE goodstypes SET type = ? WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, type_name);
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