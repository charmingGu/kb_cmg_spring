package com.ChaMg.MyProJect.StudyBoard_Recruit;

public class StudyBoard_RecruitDTO {
	int idx;
	int age_limit;
	int member_num_limit;
	int primary_board_idx;
	int reply_board_idx;
	int good_cnt;
	int bad_cnt;
	String id;
	String location;
	String study_field;
	String study_location;
	String request_list;
	String member_list;
	String write_date;
	String recruit_complete;
	String content;
	String image_location;
	String title;
	String good_cnt_list;
	String bad_cnt_list;
	
	
	@Override
	public String toString() {
		return "StudyBoard_RecruitDTO [idx=" + idx + ", age_limit=" + age_limit + ", member_num_limit="
				+ member_num_limit + ", primary_board_idx=" + primary_board_idx + ", reply_board_idx=" + reply_board_idx
				+ ", good_cnt=" + good_cnt + ", bad_cnt=" + bad_cnt + ", id=" + id + ", location=" + location
				+ ", study_field=" + study_field + ", study_location=" + study_location + ", request_list="
				+ request_list + ", member_list=" + member_list + ", write_date=" + write_date + ", recruit_complete="
				+ recruit_complete + ", content=" + content + ", image_location=" + image_location + ", title=" + title
				+ ", good_cnt_list=" + good_cnt_list + ", bad_cnt_list=" + bad_cnt_list + "]";
	}
	public String getGood_cnt_list() {
		return good_cnt_list;
	}
	public void setGood_cnt_list(String good_cnt_list) {
		this.good_cnt_list = good_cnt_list;
	}
	public String getBad_cnt_list() {
		return bad_cnt_list;
	}
	public void setBad_cnt_list(String bad_cnt_list) {
		this.bad_cnt_list = bad_cnt_list;
	}
	public int getPrimary_board_idx() {
		return primary_board_idx;
	}
	public void setPrimary_board_idx(int primary_board_idx) {
		this.primary_board_idx = primary_board_idx;
	}
	public int getReply_board_idx() {
		return reply_board_idx;
	}
	public void setReply_board_idx(int reply_board_idx) {
		this.reply_board_idx = reply_board_idx;
	}
	public int getGood_cnt() {
		return good_cnt;
	}
	public void setGood_cnt(int good_cnt) {
		this.good_cnt = good_cnt;
	}
	public int getBad_cnt() {
		return bad_cnt;
	}
	public void setBad_cnt(int bad_cnt) {
		this.bad_cnt = bad_cnt;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStudy_location() {
		return study_location;
	}
	public void setStudy_location(String study_location) {
		this.study_location = study_location;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getAge_limit() {
		return age_limit;
	}
	public void setAge_limit(int age_limit) {
		this.age_limit = age_limit;
	}
	public int getMember_num_limit() {
		return member_num_limit;
	}
	public void setMember_num_limit(int member_num_limit) {
		this.member_num_limit = member_num_limit;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getStudy_field() {
		return study_field;
	}
	public void setStudy_field(String study_field) {
		this.study_field = study_field;
	}
	public String getRequest_list() {
		return request_list;
	}
	public void setRequest_list(String request_list) {
		this.request_list = request_list;
	}
	public String getMember_list() {
		return member_list;
	}
	public void setMember_list(String member_list) {
		this.member_list = member_list;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getRecruit_complete() {
		return recruit_complete;
	}
	public void setRecruit_complete(String recruit_complete) {
		this.recruit_complete = recruit_complete;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage_location() {
		return image_location;
	}
	public void setImage_location(String image_location) {
		this.image_location = image_location;
	}
}
