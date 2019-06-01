package com.ChaMg.MyProJect.NoticeBoard;

public class NoticeBoardDTO {
	private int idx;
	private String id = "admin";
	private String title;
	private String content;
	private String write_date;
	private String rewrite_time;
	private int read_cnt;
	
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
	public String getRewrite_time() {
		return rewrite_time;
	}
	public void setRewrite_time(String rewrite_time) {
		this.rewrite_time = rewrite_time;
	}
	public int getRead_cnt() {
		return read_cnt;
	}
	public void setRead_cnt(int read_cnt) {
		this.read_cnt = read_cnt;
	}
	@Override
	public String toString() {
		return "NoticeBoardDTO [idx=" + idx + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", write_date=" + write_date + ", rewrite_time=" + rewrite_time + ", read_cnt=" + read_cnt + "]";
	}
	
	

}
