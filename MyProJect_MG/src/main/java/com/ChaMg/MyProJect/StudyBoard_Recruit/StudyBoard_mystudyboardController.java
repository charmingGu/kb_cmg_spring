package com.ChaMg.MyProJect.StudyBoard_Recruit;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ChaMg.MyProJect.Members.MemberDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class StudyBoard_mystudyboardController {
	@Autowired
	SqlSession sqlsession;
	
	private static final Logger logger = LoggerFactory.getLogger(StudyBoard_mystudyboardController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_myrecruit_list", method = RequestMethod.GET)
	public String myRecruitList(Locale locale, HttpSession session, Model model) {
		try {
			String member_id = session.getAttribute("mb_id").toString();
			List<StudyBoard_RecruitDTO> SBRC_list = sqlsession.selectList("Study_recruit.Stu_myrecruit_list", member_id);
			model.addAttribute("SBRCboardListView", SBRC_list);
			return "/studyboard_MyBoard/studyboard_myrecruit_list";
		}catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("SBRCboardListView", "");
			return "/studyboard_MyBoard/studyboard_myrecruit_list";
		}
	}
	
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_mycompleted_list", method = RequestMethod.GET)
	public String mycomplete(Locale locale, HttpSession session, Model model) {
		try {
			String member_id = session.getAttribute("mb_id").toString();
			List<StudyBoard_RecruitDTO> SBRC_list = sqlsession.selectList("Study_recruit.Stu_mycomplete_list", member_id);
			model.addAttribute("SBRCboardListView", SBRC_list);
			return "/studyboard_MyBoard/studyboard_mycompleted_list";
		}catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("SBRCboardListView", "");
			return "/studyboard_MyBoard/studyboard_mycompleted_list";
		}
	}
	
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_myrequest_list")
	public String myRequestList(Locale locale, HttpSession session, Model model) {
		try {
			String member_id = session.getAttribute("mb_id").toString();
			System.out.println("요청한 목록의 아이디는"+member_id);
			MemberDTO SBRQ_list = sqlsession.selectOne("members.selectStRqBoard", member_id);
			System.out.println("멤버의 데이터는"+SBRQ_list);
			if(SBRQ_list.getRequest_list() != null) {
				System.out.println("SBRQ_list"+SBRQ_list.getRequest_list());
				List<StudyBoard_RecruitDTO> SBRC_list = new ArrayList<StudyBoard_RecruitDTO>();
				String [] check_idx = SBRQ_list.getRequest_list().split(",");
				for(String array : check_idx) {
					System.out.println(array);
					if(array.equals("null")) {
						System.out.println("널널합니다.");
					}
					else {
						System.out.println("array의 idx 값입니다."+array);
						SBRC_list.add((StudyBoard_RecruitDTO)(sqlsession.selectOne("Study_recruit.Stu_myrequest_list", array)));
					}
				}
				model.addAttribute("SBRCboardListView", SBRC_list);
			}
			return "/studyboard_MyBoard/studyboard_myrequest_list";
		}catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("SBRCboardListView", "");
			return "/studyboard_MyBoard/studyboard_myrequest_list";
		}
	}
	
	@RequestMapping(value = "/studyboard_recruit/studyboard_myrecruit_pluslist")
	@ResponseBody
	public List<StudyBoard_RecruitDTO> studyrecruit_myRecruitPlusIndex(Locale locale, Model model, 
			@RequestParam("start_view") int start_view,
			@RequestParam("view_point") int view_point,
			@RequestParam("member_id") String member_id,
			HttpServletResponse response) {
		StudyBoard_Recruit_plusDTO plus_number = new StudyBoard_Recruit_plusDTO();
		plus_number.start_view = start_view;
		plus_number.view_point = view_point;
		plus_number.member_id = member_id;
		List<StudyBoard_RecruitDTO> SBRC_pluslist = sqlsession.selectList("Study_recruit.Stu_recruit_mystuboard_pluslist", plus_number);
		return SBRC_pluslist;
	}
	
	@RequestMapping(value = "/studyboard_recruit/studyboard_myrequest_pluslist")
	@ResponseBody
	public List<StudyBoard_RecruitDTO> studyrecruit_myRequestPlusIndex(Locale locale, Model model, 
			@RequestParam("start_view") int start_view,
			@RequestParam("view_point") int view_point,
			@RequestParam("member_id") String member_id,
			HttpServletResponse response) {
		StudyBoard_Recruit_plusDTO plus_number = new StudyBoard_Recruit_plusDTO();
		plus_number.start_view = start_view;
		plus_number.view_point = view_point;
		plus_number.member_id = member_id;
		List<StudyBoard_RecruitDTO> SBRC_pluslist = sqlsession.selectList("Study_recruit.Stu_recruit_mystuboard_pluslist", plus_number);
		return SBRC_pluslist;
	}
	
	@RequestMapping(value = "/studyboard_recruit/studyboard_myrequest_cancel")
	@ResponseBody
	public String studyrecruit_myRequestCancel(Locale locale, Model model, 
			@RequestParam("idx") int idx,
			@RequestParam("member_id") String member_id,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO cancel_list = sqlsession.selectOne("Study_recruit.Stu_recruit_STRQ_list", idx);
		MemberDTO member_request_list = sqlsession.selectOne("members.selectMember", member_id);
		
		//게시판 테이블 업데이트
		String[] check_id = cancel_list.request_list.split(",");
		for(int i=0; i < check_id.length; i++) {
			if(check_id[i].equals(member_id)) {
				check_id[i] = null;
			}
		}
		String trans_list = Arrays.toString(check_id);
		trans_list = trans_list.trim();
		trans_list = trans_list.replace(" ", "");
		trans_list = trans_list.replace("[", "");
		trans_list = trans_list.replace("]", "");
		cancel_list.request_list = trans_list;
		sqlsession.update("Study_recruit.Stu_recruit_update_joinlist", cancel_list);
		
		//멤버 테이블 업데이트
		String[] check_idx = member_request_list.getRequest_list().split(",");
		String mb_check_idx = Integer.toString(idx);
		for(int i=0; i < check_idx.length; i++) {
			if(check_idx[i].equals(mb_check_idx)) {
				check_idx[i] = null;
			}
		}
		String trans_request_list = Arrays.toString(check_idx);
		trans_request_list = trans_request_list.trim();
		trans_request_list = trans_request_list.replace(" ", "");
		trans_request_list = trans_request_list.replace("[", "");
		trans_request_list = trans_request_list.replace("]", "");
		member_request_list.setRequest_list(trans_request_list);
		sqlsession.update("members.update_Request_list", member_request_list);
		
		return "true";
	}
	
	@RequestMapping(value = "/studyboard_recruit/studyboard_mycompleted_add")
	@ResponseBody
	public String studyrecruit_myCompleted_add(Locale locale, Model model, 
			@RequestParam("idx") int idx,
			@RequestParam("member_id") String member_id,
			HttpServletResponse response) {
		StudyBoard_RecruitDTO completed_list = sqlsession.selectOne("Study_recruit.Stu_recruit_STRQ_list", idx);
		
		if(completed_list.member_list == null) {
			completed_list.member_list = completed_list.member_list+"," + member_id;
			sqlsession.update("Study_recruit.Stu_recruit_update_completed_list", completed_list);
			return "true";
		}
		else {
			completed_list.member_list = completed_list.member_list+"," + member_id;
			sqlsession.update("Study_recruit.Stu_recruit_update_completed_list", completed_list);
			return "true";
		}
	}
	
	@RequestMapping(value = "/studyboard_recruit/studyboard_mycompleted_added")
	@ResponseBody
	public String studyrecruit_myCompleted_added(Locale locale, Model model, 
			@RequestParam("idx") int idx,
			HttpServletResponse response) {
			int complete_result = sqlsession.update("Study_recruit.studyboard_complete_update", idx);
			if(complete_result != 0) {
				return "true";
			}
			else {
				return "false";
			}
		
	}
}
