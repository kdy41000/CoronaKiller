package com.corona.store.dto;

public class StoreDto {

private int count;
	
	private String addrRes;
	private String codeRes;
	private String created_atRes;
	private double latRes;
	private double lngRes;
	private String nameRes;
	private String remain_statRes;
	private String stock_atRes;
	private String typeRes;
	
	public StoreDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StoreDto(int count, String addrRes, String codeRes, String created_atRes, double latRes, double lngRes,
			String nameRes, String remain_statRes, String stock_atRes, String typeRes) {
		super();
		this.count = count;
		this.addrRes = addrRes;
		this.codeRes = codeRes;
		this.created_atRes = created_atRes;
		this.latRes = latRes;
		this.lngRes = lngRes;
		this.nameRes = nameRes;
		this.remain_statRes = remain_statRes;
		this.stock_atRes = stock_atRes;
		this.typeRes = typeRes;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getAddrRes() {
		return addrRes;
	}
	public void setAddrRes(String addrRes) {
		this.addrRes = addrRes;
	}
	public String getCodeRes() {
		return codeRes;
	}
	public void setCodeRes(String codeRes) {
		this.codeRes = codeRes;
	}
	public String getCreated_atRes() {
		return created_atRes;
	}
	public void setCreated_atRes(String created_atRes) {
		this.created_atRes = created_atRes;
	}
	public double getLatRes() {
		return latRes;
	}
	public void setLatRes(double latRes) {
		this.latRes = latRes;
	}
	public double getLngRes() {
		return lngRes;
	}
	public void setLngRes(double lngRes) {
		this.lngRes = lngRes;
	}
	public String getNameRes() {
		return nameRes;
	}
	public void setNameRes(String nameRes) {
		this.nameRes = nameRes;
	}
	public String getRemain_statRes() {
		return remain_statRes;
	}
	public void setRemain_statRes(String remain_statRes) {
		this.remain_statRes = remain_statRes;
	}
	public String getStock_atRes() {
		return stock_atRes;
	}
	public void setStock_atRes(String stock_atRes) {
		this.stock_atRes = stock_atRes;
	}
	public String getTypeRes() {
		return typeRes;
	}
	public void setTypeRes(String typeRes) {
		this.typeRes = typeRes;
	}
	
}
