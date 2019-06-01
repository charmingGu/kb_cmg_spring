package com.ChaMg.MyProJect.StudyBoard_Recruit;

public class StudyBoard_Recruit_plusDTO {
	int start_view;
	int view_point;
	
	public int getStart_view() {
		return start_view;
	}
	public void setStart_view(int start_view) {
		this.start_view = start_view;
	}
	public int getView_point() {
		return view_point;
	}
	public void setView_point(int view_point) {
		this.view_point = view_point;
	}
	@Override
	public String toString() {
		return "StudyBoard_Recruit_plusDTO [start_view=" + start_view + ", view_point=" + view_point + "]";
	}
}
