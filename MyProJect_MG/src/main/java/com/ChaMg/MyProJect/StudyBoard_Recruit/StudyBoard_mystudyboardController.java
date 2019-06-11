package com.ChaMg.MyProJect.StudyBoard_Recruit;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
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
	
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_myrequest_list", method = RequestMethod.GET)
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
	
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_mycompleted_list", method = RequestMethod.GET)
	public String myCompleted(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/studyboard_MyBoard/studyboard_mycompleted_list";
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
	
}
