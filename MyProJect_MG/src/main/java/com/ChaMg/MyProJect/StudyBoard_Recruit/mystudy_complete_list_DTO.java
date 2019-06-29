package com.ChaMg.MyProJect.StudyBoard_Recruit;

//	완료된 내 스터디 게시판의 멤버를 저장
public class mystudy_complete_list_DTO {
	String id;
	String member_id;
	@Override
	public String toString() {
		return "mystudy_complete_list_DTO [id=" + id + ", member_id=" + member_id + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
}
