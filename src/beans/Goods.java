package beans;

import java.util.ArrayList;
import java.util.Date;

public class Goods {
	String item_name;
	String item_brand;
	int item_price;
	int item_count;
	String item_type;
	String item_sex;
	String item_color;
	String item_size;
	int id;
	int sales = 0;
	Date pub_time = null;
	ArrayList<String> pics = null;
	ArrayList<String> pics_desc = null;
	
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_brand() {
		return item_brand;
	}
	public void setItem_brand(String item_brand) {
		this.item_brand = item_brand;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getItem_count() {
		return item_count;
	}
	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getItem_sex() {
		return item_sex;
	}
	public void setItem_sex(String item_sex) {
		this.item_sex = item_sex;
	}
	public String getItem_color() {
		return item_color;
	}
	public void setItem_color(String item_color) {
		this.item_color = item_color;
	}
	public String getItem_size() {
		return item_size;
	}
	public void setItem_size(String item_size) {
		this.item_size = item_size;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getPub_time() {
		return pub_time;
	}
	public void setPub_time(Date pub_time) {
		this.pub_time = pub_time;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public ArrayList<String> getPics() {
		return pics;
	}
	public void setPics(ArrayList<String> pics) {
		this.pics = pics;
	}
	public ArrayList<String> getPics_desc() {
		return pics_desc;
	}
	public void setPics_desc(ArrayList<String> pics_desc) {
		this.pics_desc = pics_desc;
	}
	
	
	
}
