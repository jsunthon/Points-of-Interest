package cs320.controller;

public class POI {
	private String name;
	private String lat;
	private String lng;
	private String address;
	private String phone;
	private String types;
	
	public POI(String name, String lat, String lng, String address, String phone, String types) {
		super();
		this.name = name;
		this.lat = lat;
		this.lng = lng;
		this.address = address;
		this.phone = phone;
		this.types = types;
	}

	public POI(String name, String lat, String lng) {
		super();
		this.name = name;
		this.lat = lat;
		this.lng = lng;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	@Override
	public String toString() {
		return name + ":(" + lat + ", " + lng + ") " + address + "  " + phone + "  " + types; 
	}
	
	
	
}
