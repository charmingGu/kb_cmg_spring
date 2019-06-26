package com.ChaMg.MyProJect.Members;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


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
	
	@RequestMapping(value = "/member/myProfile/{id}")
	public String myProfile(Locale locale, Model model, HttpSession session, @PathVariable(value = "id") String id) {
//		System.out.println(id);
		MemberDTO get_memberInfo = sqlsession.selectOne("members.selectMember", id);
		session.setAttribute("memberInfo", get_memberInfo);
		return "/member/member_update";
	}
	
	@RequestMapping(value = "/member/loginProc")
	public String loginProc(Model model, HttpSession session, MemberDTO mdto) {
		MemberDTO mb_db = (MemberDTO) sqlsession.selectOne("members.selectlogin", mdto);
		model.addAttribute("logininfo","");
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
	@ResponseBody
	public String joinProc(Model model, HttpSession session, 
			@RequestParam("id") String id,
			@RequestParam("pw") String pw,
			@RequestParam("phone") String phone,
			@RequestParam("email") String email,
			@RequestParam("birthday") String birthday,
			HttpServletResponse response) {
		
		try {
			MemberDTO mdto = new MemberDTO();
			mdto.setId(id);
			mdto.setPassword(pw);
			mdto.setPhone(phone);
			mdto.setEmail(email);
			mdto.setBirthday(birthday);
		
			int temp = sqlsession.insert("members.insertmember",mdto);
			if( temp ==1 ) {
				//		System.out.println("insert 성공");
				return "true";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "false";
		}
		return "false";
	}
	
	@RequestMapping(value = "/member/updateProc")
	@ResponseBody
	public String memberUpdateProc(Model model, HttpSession session, 
			@RequestParam("id") String id,
			@RequestParam("password") String password,
			@RequestParam("phone") String phone,
			@RequestParam("email") String email,
			@RequestParam("birthday") String birthday,
			HttpServletResponse response) {
		
		try {
			MemberDTO mdto = new MemberDTO();
			mdto.setId(id);
			mdto.setPassword(password);
			mdto.setPhone(phone);
			mdto.setEmail(email);
			mdto.setBirthday(birthday);
		
			int temp = sqlsession.insert("members.update_member_info",mdto);
			if( temp ==1 ) {
				//		System.out.println("insert 성공");
				return "true";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "false";
		}
		return "false";
	}
	
	@RequestMapping(value = "/member/id_check")
	@ResponseBody
	public String id_check(Model model, HttpSession session, 
			@RequestParam("id") String id,
			HttpServletResponse response) {
		try {
			MemberDTO check = sqlsession.selectOne("members.selectMember", id);
			if(check.getId() != null) {
				//		System.out.println("insert 성공");
				return "false";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "true";
		}
		return "IdontKnow";
	}
	
	@RequestMapping(value = "/member/email_check")
	@ResponseBody
	public String email_check(Model model, HttpSession session, 
			@RequestParam("email") String email,
			HttpServletResponse response) {
		try {
			MemberDTO check = sqlsession.selectOne("members.selectEmail", email);
			if(check.getEmail() != null) {
				//		System.out.println("insert 성공");
				return "false";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "true";
		}
		return "IdontKnow";
	}
	
	@RequestMapping(value = "/member/admin_manage")
	public String member_manage(Model model, HttpSession session, 
			HttpServletResponse response) {
		try {
			List<MemberDTO> member_table = sqlsession.selectList("members.selectAll");
			session.setAttribute("member_table", member_table);
			return "/admin/member_manage";
		} catch (Exception e) {
			// TODO: handle exception
			return "/";
		}
	}
	
	@RequestMapping(value = "/member/admin_delete")
	@ResponseBody
	public String member_delete(Model model, HttpSession session, 
			@RequestParam("id") String id,
			HttpServletResponse response) {
		try {
			int delete_member = sqlsession.delete("members.deleteMember", id);
			int delete_SCboard = sqlsession.delete("Study_recruit.Stu_recruit_deleteAll", id);
			return "true";
		} catch (Exception e) {
			// TODO: handle exception
			return "false";
		}
	}
}
