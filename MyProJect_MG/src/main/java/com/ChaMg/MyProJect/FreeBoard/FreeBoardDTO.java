package com.ChaMg.MyProJect.FreeBoard;

public class FreeBoardDTO {
	int idx;
	int primary_board_idx;
	int reply_board_idx;
	int good_cnt;
	int bad_cnt;
	int cnt;
	int reply_cnt;
	String id;
	String password;
	String title;
	String content;
	String write_date;
	String rewrite_date;
	String mb_check;
	String good_cnt_list;
	String bad_cnt_list;
	
	
	@Override
	public String toString() {
		return "FreeBoardDTO [idx=" + idx + ", primary_board_idx=" + primary_board_idx + ", reply_board_idx="
				+ reply_board_idx + ", good_cnt=" + good_cnt + ", bad_cnt=" + bad_cnt + ", cnt=" + cnt + ", reply_cnt="
				+ reply_cnt + ", id=" + id + ", password=" + password + ", title=" + title + ", content=" + content
				+ ", write_date=" + write_date + ", rewrite_date=" + rewrite_date + ", mb_check=" + mb_check
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
	public String getMb_check() {
		return mb_check;
	}
	public void setMb_check(String mb_check) {
		this.mb_check = mb_check;
	}
	public int getReply_cnt() {
		return reply_cnt;
	}
	public void setReply_cnt(int reply_cnt) {
		this.reply_cnt = reply_cnt;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getRewrite_date() {
		return rewrite_date;
	}
	public void setRewrite_date(String rewrite_date) {
		this.rewrite_date = rewrite_date;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
}
