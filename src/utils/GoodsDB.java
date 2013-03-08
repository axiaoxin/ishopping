package utils;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Goods;

public class GoodsDB {
	DB db = new DB();
	
	public int add(String item_name, String item_brand, int item_price, int item_count, String item_type, String item_sex, String item_color, String item_size, String[] pic_urls, String[] pic_desc){
		db.connect_db();
		ResultSet rs=null;
		int goods_id;
		try{
			String sql = "insert into goods(name, brand, price, count, sex, color, size, type) values (?, ?, ?, ?, ?, ?, ?, ?)";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, item_name);
			db.ps.setString(2, item_brand);
			db.ps.setInt(3, item_price);
			db.ps.setInt(4, item_count);
			db.ps.setString(5, item_sex);
			db.ps.setString(6, item_color);
			db.ps.setString(7, item_size);
			db.ps.setString(8, item_type);
			int count = db.ps.executeUpdate();
			sql = "select max(id) from goods;";
			db.ps = db.conn.prepareStatement(sql);
			rs=db.ps.executeQuery();
			if(rs.next()){
				goods_id = rs.getInt(1);
				for(int i=0; i<pic_urls.length; i++){
				sql = "insert into pics(goods_id, pic_url, pic_desc) values (?,?,?)";
				db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, goods_id);
				db.ps.setString(2, pic_urls[i]);
				db.ps.setString(3, pic_desc[i]);
				db.ps.executeUpdate();
				}
			}
			return count;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			db.close_db();
		}
	}	
	
	public Goods get(int id){
		db.connect_db();
		ResultSet rs=null;
		Goods goods = null;
        ResultSet pic_rs=null;
		
		try{
			String sql = "SELECT * FROM goods where id=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			rs = (ResultSet) db.ps.executeQuery();
			if (rs.next()){
				goods = new Goods(); 
				goods.setId(rs.getInt("id"));
				goods.setItem_brand(rs.getString("brand"));
				goods.setItem_color(rs.getString("color"));
				goods.setItem_count(rs.getInt("count"));
				goods.setItem_name(rs.getString("name"));
				goods.setItem_price(rs.getInt("price"));
				goods.setItem_sex(rs.getString("sex"));
				goods.setItem_size(rs.getString("size"));
				goods.setItem_type(rs.getString("type"));
				goods.setPub_time(rs.getDate("pub_time"));
				goods.setSales(rs.getInt("sales"));
				sql = "SELECT * from pics where goods_id=?";
		    	db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, rs.getInt("id"));
		    	pic_rs = db.ps.executeQuery();

	            ArrayList<String> pics = new ArrayList<String>();
	            ArrayList<String> pics_desc= new ArrayList<String>();
		    	while(pic_rs.next()){
		    		pics.add(pic_rs.getString("pic_url"));
		    		pics_desc.add(pic_rs.getString("pic_desc"));
		    	}
		    	goods.setPics(pics);
		    	goods.setPics_desc(pics_desc);
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
		return goods;
	}
	

	public ArrayList<Goods> get_all_goods() {
        ResultSet rs=null;
        ArrayList<Goods> all_goods = new ArrayList<Goods>();
        ResultSet pic_rs=null;
        db.connect_db();
        try {
        	String sql = "SELECT * from goods order by(-id)";
	    	db.ps = db.conn.prepareStatement(sql);
	    	rs = db.ps.executeQuery();
	    	if(rs != null){
		    	while(rs.next()){
		    		Goods goods = new Goods();
		    		goods.setId(rs.getInt("id"));
					goods.setItem_brand(rs.getString("brand"));
					goods.setItem_color(rs.getString("color"));
					goods.setItem_count(rs.getInt("count"));
					goods.setItem_name(rs.getString("name"));
					goods.setItem_price(rs.getInt("price"));
					goods.setItem_sex(rs.getString("sex"));
					goods.setItem_size(rs.getString("size"));
					goods.setItem_type(rs.getString("type"));
					goods.setSales(rs.getInt("sales"));
					sql = "SELECT * from pics where goods_id=?";
			    	db.ps = db.conn.prepareStatement(sql);
					db.ps.setInt(1, rs.getInt("id"));
			    	pic_rs = db.ps.executeQuery();
	
		            ArrayList<String> pics = new ArrayList<String>();
		            ArrayList<String> pics_desc= new ArrayList<String>();
			    	while(pic_rs.next()){
			    		pics.add(pic_rs.getString("pic_url"));
			    		pics_desc.add(pic_rs.getString("pic_desc"));
			    	}
			    	goods.setPics(pics);
			    	goods.setPics_desc(pics_desc);
		    		all_goods.add(goods);	  		
		    	} 

		    	pic_rs.close();
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
        return all_goods;
    }
	
	public ArrayList<Goods> get_search_goods(String searchName) {
		ResultSet rs=null;
		ArrayList<Goods> all_goods = new ArrayList<Goods>();
	    ResultSet pic_rs=null;
	    db.connect_db();
        try {
        	String sql = "SELECT * FROM goods WHERE name LIKE ? order by(-id)";
	    	db.ps = db.conn.prepareStatement(sql);
	    	db.ps.setString(1, "%"+searchName+"%");
	    	rs = db.ps.executeQuery();
	    	while(rs.next()){
	    		Goods goods = new Goods();
	    		goods.setId(rs.getInt("id"));
				goods.setItem_brand(rs.getString("brand"));
				goods.setItem_color(rs.getString("color"));
				goods.setItem_count(rs.getInt("count"));
				goods.setItem_name(rs.getString("name"));
				goods.setItem_price(rs.getInt("price"));
				goods.setItem_sex(rs.getString("sex"));
				goods.setItem_size(rs.getString("size"));
				goods.setItem_type(rs.getString("type"));
				goods.setSales(rs.getInt("sales"));
				
				sql = "SELECT * from pics where goods_id=?";
		    	db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, rs.getInt("id"));
		    	pic_rs = db.ps.executeQuery();

	            ArrayList<String> pics = new ArrayList<String>();
	            ArrayList<String> pics_desc= new ArrayList<String>();
		    	while(pic_rs.next()){
		    		pics.add(pic_rs.getString("pic_url"));
		    		pics_desc.add(pic_rs.getString("pic_desc"));
		    	}
		    	goods.setPics(pics);
		    	goods.setPics_desc(pics_desc);
	    		all_goods.add(goods);	  		
	    	} 

        } catch (Exception e) {
           	e.printStackTrace();
        } finally{
			try {
				if (null!=pic_rs)
				{
					pic_rs.close();
				}
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			db.close_db();
		}		
        return all_goods;
    }
	
	public ArrayList<Goods> get_type_goods(String typeName) {
		ResultSet rs=null;
		ArrayList<Goods> all_goods = new ArrayList<Goods>();
	    ResultSet pic_rs=null;
	    db.connect_db();
        try {
        	String sql = "SELECT * FROM goods WHERE type=? order by(-id)";
	    	db.ps = db.conn.prepareStatement(sql);
	    	db.ps.setString(1, typeName);
	    	rs = db.ps.executeQuery();
	    	while(rs.next()){
	    		Goods goods = new Goods();
	    		goods.setId(rs.getInt("id"));
				goods.setItem_brand(rs.getString("brand"));
				goods.setItem_color(rs.getString("color"));
				goods.setItem_count(rs.getInt("count"));
				goods.setItem_name(rs.getString("name"));
				goods.setItem_price(rs.getInt("price"));
				goods.setItem_sex(rs.getString("sex"));
				goods.setItem_size(rs.getString("size"));
				goods.setItem_type(rs.getString("type"));
				goods.setSales(rs.getInt("sales"));
				
				sql = "SELECT * from pics where goods_id=?";
		    	db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, rs.getInt("id"));
		    	pic_rs = db.ps.executeQuery();

	            ArrayList<String> pics = new ArrayList<String>();
	            ArrayList<String> pics_desc= new ArrayList<String>();
		    	while(pic_rs.next()){
		    		pics.add(pic_rs.getString("pic_url"));
		    		pics_desc.add(pic_rs.getString("pic_desc"));
		    	}
		    	goods.setPics(pics);
		    	goods.setPics_desc(pics_desc);
	    		all_goods.add(goods);	  		
	    	} 

        } catch (Exception e) {
           	e.printStackTrace();
        } finally{
			try {
				if (null!=pic_rs)
				{
					pic_rs.close();
				}
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			db.close_db();
		}		
        return all_goods;
    }

	public int delete(int id){
		db.connect_db();
		try{
			String sql = "DELETE FROM goods WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			db.ps.executeUpdate();
			sql = "DELETE FROM pics WHERE goods_id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			db.ps.executeUpdate();
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}


	public int modify(int id, String item_name, String item_brand, int item_price, int item_count, String item_type, String item_sex, String item_color, String item_size, String[] pics, String[] pics_desc){
		db.connect_db();
		try{
			String sql = "UPDATE goods SET name = ?, brand = ? ,price = ? ,count = ? ,type = ? ,sex = ? ,color = ? ,size = ?  WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, item_name);
			db.ps.setString(2, item_brand);
			db.ps.setInt(3, item_price);
			db.ps.setInt(4, item_count);
			db.ps.setString(5, item_type);
			db.ps.setString(6, item_sex);
			db.ps.setString(7, item_color);
			db.ps.setString(8, item_size);
			db.ps.setInt(9, id);
			db.ps.executeUpdate();
			sql = "DELETE FROM pics WHERE goods_id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			db.ps.executeUpdate();
			sql = "insert into pics(goods_id, pic_url, pic_desc) values (?,?,?)";
			db.ps = db.conn.prepareStatement(sql);
			for (int i=0; i<pics.length; ++i){
				db.ps.setInt(1, id);
				db.ps.setString(2, pics[i]);
				db.ps.setString(3, pics_desc[i]);
				db.ps.executeUpdate();
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}
	
}