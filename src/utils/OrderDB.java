package utils;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import beans.Order;

public class OrderDB {
	DB db = new DB();
	
	public int add(Map<Integer, Integer> user_goods_ids, String who, String addr, String code, String call, String email){
		db.connect_db();
		ResultSet rs=null;
		ResultSet sales_rs=null;
		ResultSet count_rs=null;
		int order_id;
		try{
			String sql = "insert into orders(who, addr, code, callnum, email) values (?,?,?,?,?)";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setString(1, who);
			db.ps.setString(2, addr);
			db.ps.setString(3, code);
			db.ps.setString(4, call);
			db.ps.setString(5, email);
			db.ps.executeUpdate();
			sql = "select max(id) from orders;";
			db.ps = db.conn.prepareStatement(sql);
			rs=db.ps.executeQuery();
			if(rs.next()){
				order_id = rs.getInt(1);
				Set<Integer> keys = user_goods_ids.keySet();
				if(keys != null){
                    Iterator<Integer> iter = keys.iterator();
                    while(iter.hasNext()) {
						Object goods_id = iter.next();
						Object how_many = user_goods_ids.get(goods_id);
						sql = "insert into ordered_goods(goods_id, how_many, order_id) values (?,?,?)";
						db.ps = db.conn.prepareStatement(sql);
						db.ps.setInt(1, (Integer)goods_id);
						db.ps.setInt(2, (Integer)how_many);
						db.ps.setInt(3, order_id);
						db.ps.executeUpdate();
	          			sql = "select sales from goods where id=?";
						db.ps = db.conn.prepareStatement(sql);
	        			db.ps.setInt(1, (Integer)goods_id);
	        	    	sales_rs = db.ps.executeQuery();
	        	    	sales_rs.next();
	        	    	int sales = sales_rs.getInt("sales")+(Integer)how_many;
	        			sql = "UPDATE goods SET sales = ? WHERE id = ?";
						db.ps = db.conn.prepareStatement(sql);
	        			db.ps.setInt(1, sales);
	        			db.ps.setInt(2, (Integer)goods_id);
	        			db.ps.executeUpdate();
	          			sql = "select count from goods where id=?";
						db.ps = db.conn.prepareStatement(sql);
	        			db.ps.setInt(1, (Integer)goods_id);
	        	    	count_rs = db.ps.executeQuery();
	        	    	count_rs.next();
	        	    	int count = count_rs.getInt("count")-(Integer)how_many;
	        			sql = "UPDATE goods SET count = ? WHERE id = ?";
						db.ps = db.conn.prepareStatement(sql);
	        			db.ps.setInt(1, count);
	        			db.ps.setInt(2, (Integer)goods_id);
	        			db.ps.executeUpdate();
                    }
				}
				rs.close();
				if(count_rs !=null)count_rs.close();
				if(sales_rs !=null)sales_rs.close();
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}	
	

	public ArrayList<Order> get_all_orders() {
        ResultSet rs=null;
        ArrayList<Order> all_orders = new ArrayList<Order>();
        ResultSet ordered_rs=null;
        db.connect_db();
        try {
        	String sql = "SELECT * from orders";
	    	db.ps = db.conn.prepareStatement(sql);
	    	rs = db.ps.executeQuery();
	    	if(rs != null){
		    	while(rs.next()){
		    		Order order = new Order();
		    		order.setId(rs.getInt("id"));
		    		order.setWho(rs.getString("who"));
		    		order.setAddr(rs.getString("addr"));
		    		order.setCode(rs.getString("code"));
		    		order.setCall(rs.getString("callnum"));
		    		order.setIs_ok(rs.getBoolean("is_ok"));
		    		order.setReceive(rs.getBoolean("receive"));
					
					sql = "SELECT * from ordered_goods where order_id=?";
			    	db.ps = db.conn.prepareStatement(sql);
					db.ps.setInt(1, rs.getInt("id"));
					ordered_rs = db.ps.executeQuery();
	
		            ArrayList<Integer> goods_ids = new ArrayList<Integer>();
		            ArrayList<Integer> how_many= new ArrayList<Integer>();
			    	while(ordered_rs.next()){
			    		goods_ids.add(ordered_rs.getInt("goods_id"));
			    		how_many.add(ordered_rs.getInt("how_many"));
			    	}
			    	order.setGoods_id(goods_ids);
			    	order.setHow_many(how_many);
			    	all_orders.add(order);	  		
		    	} 
	
				if(ordered_rs!=null)ordered_rs.close();
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
        return all_orders;
    }
	
	public int deal(int id){
		db.connect_db();
		try{
			String sql = "UPDATE orders SET is_ok = ? WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setBoolean(1, true);
			db.ps.setInt(2, id);
			db.ps.executeUpdate();
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}

	
	public int receive(int id){
		db.connect_db();
		try{
			String sql = "UPDATE orders SET receive = ? WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setBoolean(1, true);
			db.ps.setInt(2, id);
			db.ps.executeUpdate();
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}

	
	

	public int delete(int id){
		db.connect_db();
		ResultSet goods_ids_rs = null;
		ResultSet sales_rs = null;
		ResultSet count_rs = null;
		try{
			String sql = "select goods_id, how_many from ordered_goods where order_id=?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
	    	goods_ids_rs = db.ps.executeQuery();
	    	while(goods_ids_rs.next()){
				sql = "select sales from goods where id=?";
				db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, goods_ids_rs.getInt("goods_id"));
		    	sales_rs = db.ps.executeQuery();
		    	sales_rs.next();
		    	int sales = sales_rs.getInt("sales")-goods_ids_rs.getInt("how_many");
				sql = "UPDATE goods SET sales = ? WHERE id = ?";
				db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, sales);
				db.ps.setInt(2, goods_ids_rs.getInt("goods_id"));
				db.ps.executeUpdate();
	  			sql = "select count from goods where id=?";
				db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, goods_ids_rs.getInt("goods_id"));
		    	count_rs = db.ps.executeQuery();
		    	count_rs.next();
		    	int count = count_rs.getInt("count")+goods_ids_rs.getInt("how_many");
				sql = "UPDATE goods SET count = ? WHERE id = ?";
				db.ps = db.conn.prepareStatement(sql);
				db.ps.setInt(1, count);
				db.ps.setInt(2, goods_ids_rs.getInt("goods_id"));
				db.ps.executeUpdate();
	    	}
			sql = "DELETE FROM orders WHERE id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			db.ps.executeUpdate();
			sql = "DELETE FROM ordered_goods WHERE order_id = ?";
			db.ps = db.conn.prepareStatement(sql);
			db.ps.setInt(1, id);
			db.ps.executeUpdate();
	    	if(goods_ids_rs != null)goods_ids_rs.close();
	    	if(sales_rs != null)sales_rs.close();
	    	if(count_rs != null)count_rs.close();
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally{
			db.close_db();
		}
	}

	public ArrayList<Order> get_user_orders(String email) {
        ResultSet rs=null;
        ArrayList<Order> all_orders = new ArrayList<Order>();
        ResultSet ordered_rs=null;
        db.connect_db();
        try {
        	String sql = "SELECT * from orders where email =?";
	    	db.ps = db.conn.prepareStatement(sql);
	    	db.ps.setString(1, email);
	    	rs = db.ps.executeQuery();
	    	if(rs != null){
		    	while(rs.next()){
		    		Order order = new Order();
		    		order.setId(rs.getInt("id"));
		    		order.setWho(rs.getString("who"));
		    		order.setAddr(rs.getString("addr"));
		    		order.setCode(rs.getString("code"));
		    		order.setCall(rs.getString("callnum"));
		    		order.setIs_ok(rs.getBoolean("is_ok"));
		    		order.setReceive(rs.getBoolean("receive"));
					
					sql = "SELECT * from ordered_goods where order_id=?";
			    	db.ps = db.conn.prepareStatement(sql);
					db.ps.setInt(1, rs.getInt("id"));
					ordered_rs = db.ps.executeQuery();
					if(ordered_rs != null){
			            ArrayList<Integer> goods_ids = new ArrayList<Integer>();
			            ArrayList<Integer> how_many= new ArrayList<Integer>();
				    	while(ordered_rs.next()){
				    		goods_ids.add(ordered_rs.getInt("goods_id"));
				    		how_many.add(ordered_rs.getInt("how_many"));
				    	}
				    	order.setGoods_id(goods_ids);
				    	order.setHow_many(how_many);
				    	all_orders.add(order);
				    	ordered_rs.close();
					}
		    	} 
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
        return all_orders;
    }
	
	/*
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
	}*/
	
}