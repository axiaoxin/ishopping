package beans;

import java.util.ArrayList;
import java.util.Date;

public class Order {
	int id;
	ArrayList<Integer> goods_id;
	ArrayList<Integer> how_many;
	String who;
	String addr;
	String code;
	String call;
	Date add_time = null;
	boolean is_ok;
	boolean receive;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getWho() {
		return who;
	}
	public void setWho(String who) {
		this.who = who;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCall() {
		return call;
	}
	public void setCall(String call) {
		this.call = call;
	}
	public Date getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}
	public boolean isIs_ok() {
		return is_ok;
	}
	public void setIs_ok(boolean is_ok) {
		this.is_ok = is_ok;
	}
	public ArrayList<Integer> getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(ArrayList<Integer> goods_id) {
		this.goods_id = goods_id;
	}
	public ArrayList<Integer> getHow_many() {
		return how_many;
	}
	public void setHow_many(ArrayList<Integer> how_many) {
		this.how_many = how_many;
	}
	public boolean isReceive() {
		return receive;
	}
	public void setReceive(boolean receive) {
		this.receive = receive;
	}
	
	
}
