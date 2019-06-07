package com.ChaMg.MyProJect.Members;

public class MemberDTO {

	private int idx;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String phone;
	private String birthday;
	private String joindate;
	private String request_list;
	private String studyGroup_list;
	
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getRequest_list() {
		return request_list;
	}
	public void setRequest_list(String request_list) {
		this.request_list = request_list;
	}
	public String getStudyGroup_list() {
		return studyGroup_list;
	}
	public void setStudyGroup_list(String studyGroup_list) {
		this.studyGroup_list = studyGroup_list;
	}
	@Override
	public String toString() {
		return "MemberDTO [idx=" + idx + ", id=" + id + ", pw=" + pw + ", name=" + name + ", email=" + email
				+ ", phone=" + phone + ", birthday=" + birthday + ", joindate=" + joindate + ", request_list="
				+ request_list + ", studyGroup_list=" + studyGroup_list + "]";
	}
	
}
