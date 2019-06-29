package com.ChaMg.MyProJect.StudyBoard_Recruit;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ChaMg.MyProJect.Members.MemberDTO;


/**
 * Handles requests for the application home page.
 * 
 */

@Controller

public class StudyBoard_RecruitController {
	@Autowired
	SqlSession sqlsession;
	private static final Logger logger = LoggerFactory.getLogger(StudyBoard_RecruitController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * 모집중인 게시판을 보여주는 페이지로 이동.
	 */
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_list")
	public String studyrecruit_index(Locale locale, Model model) {
		List<StudyBoard_RecruitDTO> SBRC_list = sqlsession.selectList("Study_recruit.Stu_recruit_select_list");
		model.addAttribute("SBRCboardListView", SBRC_list);
		return "/studyboard_recruit/studyboard_recruit_list";
	}

//	모집중인 게시판 리스트의 더 보기 기능.(10개씩 로드)
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_pluslist")
	@ResponseBody
	public List<StudyBoard_RecruitDTO> studyrecruit_plusindex(Locale locale, Model model, 
			@RequestParam("start_view") int start_view,
			@RequestParam("view_point") int view_point,
			HttpServletResponse response) {
		StudyBoard_Recruit_plusDTO plus_number = new StudyBoard_Recruit_plusDTO();
		plus_number.start_view = start_view;
		plus_number.view_point = view_point;
		List<StudyBoard_RecruitDTO> SBRC_pluslist = sqlsession.selectList("Study_recruit.Stu_recruit_select_pluslist", plus_number);
		return SBRC_pluslist;
	}
	
//	마음에 드는 스터디 게시판의 스터디에 신청하기 기능.(이미 신청한 게시판인지 체크)
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_join")
	@ResponseBody
	public String studyrecruit_join(Locale locale, Model model, 
			@RequestParam("id") String id,
			@RequestParam("idx") int idx,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO check_list = sqlsession.selectOne("Study_recruit.Stu_recruit_STRQ_list", idx);
		MemberDTO member_list_check = sqlsession.selectOne("members.selectMember", id);
		System.out.println(id);
		System.out.println(idx);
		if(check_list.request_list == null) {
			check_list.request_list = check_list.request_list+"," + id;
			member_list_check.setRequest_list(member_list_check.getRequest_list()+","+idx);
			sqlsession.update("Study_recruit.Stu_recruit_update_joinlist", check_list);
			sqlsession.update("members.update_Request_list", member_list_check);
			return "true";
		}
		else {
			String [] check_id = null;
//			String [] member_check_id = null;
			check_id = check_list.request_list.split(",");
//			member_check_id = member_list_check.getRequest_list().split(",");
			for(String array : check_id) {
				if(array.equals(id)) {
					return "false";
				}
			}
			check_list.request_list = check_list.request_list+"," + id;
			member_list_check.setRequest_list(member_list_check.getRequest_list()+","+idx);
			sqlsession.update("Study_recruit.Stu_recruit_update_joinlist", check_list);
			sqlsession.update("members.update_Request_list", member_list_check);
			return "true";
		}
	}
	
//	스터디 게시판을 작성하는 페이지로 이동.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_form", method = RequestMethod.GET)
	public String make_form(Locale locale, Model model) {
		return "/studyboard_recruit/recruit_make_form";
	}
	
//	스터디 게시판의 내용을 보여주는 기능.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_readcont/{idx}", method = RequestMethod.GET)
	public String read_cont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		StudyBoard_RecruitDTO read_content = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
		List<StudyBoard_RecruitDTO> STRC_reply_list = sqlsession.selectList("Study_recruit.studyboard_reply_ListAll", idx);
		model.addAttribute("read_rc_cont", read_content);
		model.addAttribute("STRC_Reply_Cont", STRC_reply_list);
		return "/studyboard_recruit/recruit_read_content";
	}
	
//	스터디 게시판의 내용을 수정하는 페이지로 이동하는 기능.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_change_cont/{idx}", method = RequestMethod.GET)
	public String change_cont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		StudyBoard_RecruitDTO change_content = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
		model.addAttribute("change_rc_cont", change_content);
		return "/studyboard_recruit/recruit_change_cont";
	}
	
//	스터디 게시판의 내용을 삭제하는 기능.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_delete")
	@ResponseBody
	public String studyboard_RCdelete(Locale locale, Model model, @RequestParam("idx") int idx) {
		int STRC_delete = sqlsession.delete("Study_recruit.Stu_recruit_delete_form", idx);
		return "true";
	}
	
//	스터디 게시판 작성을 위한 데이터 제출 기능.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_submit")
	@ResponseBody
	public String studyboard_recruit_submit(Model model,
			@RequestParam("id") String id,
			@RequestParam("recruit_title") String recruit_title,
			@RequestParam("location") String location,
			@RequestParam("age_limit") int age_limit,
			@RequestParam("member_num_limit") int member_num_limit,
			@RequestParam("study_location") String study_location,
			@RequestParam("study_field") String study_field,
			@RequestParam("study_content") String study_content,
			@RequestParam("image_location") String image_location,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO study_recruit_dto = new StudyBoard_RecruitDTO();
		study_recruit_dto.age_limit = age_limit;
		study_recruit_dto.content = study_content;
		study_recruit_dto.id = id;
		study_recruit_dto.title = recruit_title;
		study_recruit_dto.image_location = image_location;
		study_recruit_dto.location = location;
		study_recruit_dto.member_num_limit = member_num_limit;
		study_recruit_dto.study_field = study_field;
		study_recruit_dto.study_location = study_location;
		int temp = sqlsession.insert("Study_recruit.Stu_recruit_insert_form", study_recruit_dto);
		if (temp==1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}
	
//	스터디 게시판의 내용을 수정하는 기능.
	@RequestMapping(value = "/studyboard_recruit/studyboard_recruit_update")
	@ResponseBody
	public String studyboard_recruit_update(Model model,
			@RequestParam("idx") int idx,
			@RequestParam("id") String id,
			@RequestParam("recruit_title") String recruit_title,
			@RequestParam("location") String location,
			@RequestParam("age_limit") int age_limit,
			@RequestParam("member_num_limit") int member_num_limit,
			@RequestParam("study_location") String study_location,
			@RequestParam("study_field") String study_field,
			@RequestParam("study_content") String study_content,
			@RequestParam("image_location") String image_location,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO study_recruit_dto = new StudyBoard_RecruitDTO();
		study_recruit_dto.idx = idx;
		study_recruit_dto.age_limit = age_limit;
		study_recruit_dto.content = study_content;
		study_recruit_dto.id = id;
		study_recruit_dto.title = recruit_title;
		study_recruit_dto.image_location = image_location;
		study_recruit_dto.location = location;
		study_recruit_dto.member_num_limit = member_num_limit;
		study_recruit_dto.study_field = study_field;
		study_recruit_dto.study_location = study_location;
		int temp = sqlsession.insert("Study_recruit.Stu_recruit_update_form", study_recruit_dto);
		if (temp==1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}
	
//	스터디 게시판의 댓글 작성 기능.
	@RequestMapping(value = "/studyboard_recruit/reply_SBRCboardwrite")
	@ResponseBody
	public String reply_SBRCboardwrite(Model model,
			@RequestParam("primary_board_idx") int primary_board_idx,
			@RequestParam("id") String id,
			@RequestParam("content") String content,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO Re_SBRC_dto = new StudyBoard_RecruitDTO();
		Re_SBRC_dto.id = id;
		Re_SBRC_dto.primary_board_idx = primary_board_idx;
		Re_SBRC_dto.content = content;
		int temp = sqlsession.insert("Study_recruit.Stu_recruit_InsertCont_reply", Re_SBRC_dto);
		if (temp == 1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}
	
//	스터디 게시판의 대댓글 작성 기능.
	@RequestMapping(value = "/studyboard_recruit/re_reply_SBRCboardwrite")
	@ResponseBody
	public String re_reply_SBRCboardwrite(Model model,
			@RequestParam("primary_board_idx") int primary_board_idx,
			@RequestParam("reply_board_idx") int reply_board_idx,
			@RequestParam("id") String id,
			@RequestParam("content") String content,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO Re_Re_SBRC_dto = new StudyBoard_RecruitDTO();
		Re_Re_SBRC_dto.id = id;
		Re_Re_SBRC_dto.primary_board_idx = primary_board_idx;
		Re_Re_SBRC_dto.reply_board_idx = reply_board_idx;
		Re_Re_SBRC_dto.content = content;
		int temp = sqlsession.insert("Study_recruit.Stu_recruit_InsertCont_re_reply", Re_Re_SBRC_dto);
		if (temp == 1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}
	
//	스터디 게시판의 댓글을 삭제하는 기능.
	@RequestMapping(value = "/studyboard_recruit/reply_delete_SBRCboardwrite")
	@ResponseBody 
	public String SBRCboard_delete_reply(@RequestParam("idx") int idx, HttpServletResponse response) throws IOException{ 
		StudyBoard_RecruitDTO temp_data = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx ); 
			int SBRCboard_reply_delete = sqlsession.delete("Study_recruit.studyboard_re_delete", idx);
		return "SBRCboard_reply_delete";
	}
	
//	스터디 게시판의 좋아요 기능.
	@RequestMapping(value = "/studyboard_recruit/SBRCboard_good_cnt_update")
	@ResponseBody
	public String studyboard_update_good_cnt(Model model, @RequestParam("idx") int idx, @RequestParam("id") String id,
			HttpServletResponse response) throws IOException {
		StudyBoard_RecruitDTO STRC_reply_id_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
		if (STRC_reply_id_check.good_cnt_list == null || STRC_reply_id_check.good_cnt_list.contains("," + id + ",") == false) {
			STRC_reply_id_check.good_cnt_list += "," + id + ",";
			sqlsession.update("Study_recruit.studyboard_good_cnt_list_update", STRC_reply_id_check);
			StudyBoard_RecruitDTO STRC_reply_id_plus_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
			return Integer.toString(STRC_reply_id_plus_check.good_cnt);
		} else if (STRC_reply_id_check.good_cnt_list.contains("," + id + ",")) {
			STRC_reply_id_check.good_cnt_list = STRC_reply_id_check.good_cnt_list.replace("," + id + ",", "");
			sqlsession.update("Study_recruit.studyboard_good_cnt_list_re_update", STRC_reply_id_check);
			StudyBoard_RecruitDTO STRC_reply_id_minus_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
			return Integer.toString(STRC_reply_id_minus_check.good_cnt);
		} else {
			return "IdontKnow";
		}
	}

//	스터디 게시판의 싫어요 기능.
	@RequestMapping(value = "/studyboard_recruit/SBRCboard_bad_cnt_update")
	@ResponseBody
	public String studyboard_update_bad_cnt(Model model, @RequestParam("idx") int idx, @RequestParam("id") String id,
			HttpServletResponse response) throws IOException {
		StudyBoard_RecruitDTO STRC_reply_id_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
		if (STRC_reply_id_check.bad_cnt_list == null || STRC_reply_id_check.bad_cnt_list.contains("," + id + ",") == false) {
			STRC_reply_id_check.bad_cnt_list += "," + id + ",";
			sqlsession.update("Study_recruit.studyboard_bad_cnt_list_update", STRC_reply_id_check);
			StudyBoard_RecruitDTO STRC_reply_id_plus_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
			return Integer.toString(STRC_reply_id_plus_check.bad_cnt);
		} else if (STRC_reply_id_check.bad_cnt_list.contains("," + id + ",")) {
			STRC_reply_id_check.bad_cnt_list = STRC_reply_id_check.bad_cnt_list.replace("," + id + ",", "");
			sqlsession.update("Study_recruit.studyboard_bad_cnt_list_re_update", STRC_reply_id_check);
			StudyBoard_RecruitDTO STRC_reply_id_minus_check = sqlsession.selectOne("Study_recruit.Stu_recruit_select_readcont", idx);
			return Integer.toString(STRC_reply_id_minus_check.bad_cnt);
		} else {
			return "IdontKnow";
		}
	}
}
