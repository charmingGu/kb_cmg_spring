package com.ChaMg.MyProJect.Members;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	@Autowired
	SqlSession sqlsession;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/member/login")
	public String login(Locale locale, Model model) {
		return "/member/login";
	}
	
	@RequestMapping(value = "/member/loginProc")
	public String loginProc(Model model, HttpSession session, MemberDTO mdto) {
		MemberDTO mb_db = (MemberDTO) sqlsession.selectOne("members.selectlogin", mdto);
		
		if( mdto != null && mb_db !=null) {
			if( mdto.getEmail().equals( mb_db.getEmail() ) ) {
				session.setAttribute("mb_db", mb_db);
				session.setAttribute("mb_id", mb_db.getId());
			}
		}else {
			model.addAttribute("logininfo","아이디나 비밀번호를 확인해주세요.");
			return "/member/login";
		}
		return "redirect:/";
	}
	
	@RequestMapping(value = "/member/logoutProc")
	public String logoutProc(Model model, HttpSession session) {
		session.setAttribute("mb_db", null);
		session.setAttribute("mb_id", null);
		return "redirect:/";
	}
	
	@RequestMapping(value = "/member/forgotpassword")
	public String forgotpassword(Locale locale, Model model) {
		return "/member/forgotpassword";
	}
	
	@RequestMapping(value = "/member/join")
	public String joinview(Locale locale, Model model) {
		return "/member/join";
	}
	
	@RequestMapping(value = "/member/joinProc")
	public String joinProc(Model model, HttpSession session, MemberDTO mdto	) {
	int temp = sqlsession.insert("members.insertmember",mdto);
	if( temp ==1 ) {
//		System.out.println("insert 성공");
		session.setAttribute("db_md", mdto);
		List<MemberDTO> al = sqlsession.selectList("members.selectAll");
		model.addAttribute("memberList", al);
		return "home";
	}else {
//		System.out.println("insert 실패");
		model.addAttribute("joininfo","피치못할사정에 insert실패했어요..");
		return "/member/join";
	}
	}
}
