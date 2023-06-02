package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Barber {
    /*理发师id*/
    private Integer barberId;
    public Integer getBarberId(){
        return barberId;
    }
    public void setBarberId(Integer barberId){
        this.barberId = barberId;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*理发师年龄*/
    @NotNull(message="必须输入理发师年龄")
    private Integer barberAge;
    public Integer getBarberAge() {
        return barberAge;
    }
    public void setBarberAge(Integer barberAge) {
        this.barberAge = barberAge;
    }

    /*理发师照片*/
    private String barberPhoto;
    public String getBarberPhoto() {
        return barberPhoto;
    }
    public void setBarberPhoto(String barberPhoto) {
        this.barberPhoto = barberPhoto;
    }

    /*工作经验*/
    @NotEmpty(message="工作经验不能为空")
    private String workYears;
    public String getWorkYears() {
        return workYears;
    }
    public void setWorkYears(String workYears) {
        this.workYears = workYears;
    }

    /*理发师介绍*/
    @NotEmpty(message="理发师介绍不能为空")
    private String barberDesc;
    public String getBarberDesc() {
        return barberDesc;
    }
    public void setBarberDesc(String barberDesc) {
        this.barberDesc = barberDesc;
    }

    /*理发师备注*/
    private String barberMemo;
    public String getBarberMemo() {
        return barberMemo;
    }
    public void setBarberMemo(String barberMemo) {
        this.barberMemo = barberMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBarber=new JSONObject(); 
		jsonBarber.accumulate("barberId", this.getBarberId());
		jsonBarber.accumulate("name", this.getName());
		jsonBarber.accumulate("gender", this.getGender());
		jsonBarber.accumulate("barberAge", this.getBarberAge());
		jsonBarber.accumulate("barberPhoto", this.getBarberPhoto());
		jsonBarber.accumulate("workYears", this.getWorkYears());
		jsonBarber.accumulate("barberDesc", this.getBarberDesc());
		jsonBarber.accumulate("barberMemo", this.getBarberMemo());
		return jsonBarber;
    }}