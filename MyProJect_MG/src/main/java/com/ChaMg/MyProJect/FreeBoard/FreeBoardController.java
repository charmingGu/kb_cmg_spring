package com.ChaMg.MyProJect.FreeBoard;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class FreeBoardController {
	@Autowired
	SqlSession sqlsession;
	private static final Logger logger = LoggerFactory.getLogger(FreeBoardController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/freeboard/freeboardindex")
	public String freeboard_index(Locale locale, Model model) {
		List<FreeBoardDTO> FB_list = sqlsession.selectList("freeboard.FreeBoard_ListAll");
		model.addAttribute("FBboardListView", FB_list);
		return "/freeboard/freeboardindex";
	}

	@RequestMapping(value = "/freeboard/freeboardreadcont/{idx}")
	public String freeboard_read_cont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		int FB_cnt_update = sqlsession.update("freeboard.FreeBoard_cnt_update", idx);
		FreeBoardDTO FB_cont = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
		List<FreeBoardDTO> FB_reply_list = sqlsession.selectList("freeboard.FreeBoard_reply_ListAll", idx);
		model.addAttribute("FBboardReadCont", FB_cont);
		model.addAttribute("FBboard_Reply_Cont", FB_reply_list);
		System.out.println(FB_cont);
		return "/freeboard/freeboardreadcont";
	}

	@RequestMapping(value = "/freeboard/freeboard_good_cnt_update")
	@ResponseBody
	public String freeboard_update_good_cnt(Model model, @RequestParam("idx") int idx, @RequestParam("id") String id,
			HttpServletResponse response) throws IOException {
		FreeBoardDTO FB_reply_id_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
		if (FB_reply_id_check.good_cnt_list == null || FB_reply_id_check.good_cnt_list.contains("," + id + ",") == false) {
			FB_reply_id_check.good_cnt_list += "," + id + ",";
			sqlsession.update("freeboard.FreeBoard_good_cnt_list_update", FB_reply_id_check);
			FreeBoardDTO FB_reply_id_plus_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
			return Integer.toString(FB_reply_id_plus_check.good_cnt);
		} else if (FB_reply_id_check.good_cnt_list.contains("," + id + ",")) {
			// System.out.println(FB_reply_id_check.good_cnt_list);
			FB_reply_id_check.good_cnt_list = FB_reply_id_check.good_cnt_list.replace("," + id + ",", "");
			sqlsession.update("freeboard.FreeBoard_good_cnt_list_re_update", FB_reply_id_check);
			FreeBoardDTO FB_reply_id_minus_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
			// System.out.println(FB_reply_id_minus_check.good_cnt_list);
			return Integer.toString(FB_reply_id_minus_check.good_cnt);
		} else {
			return "IdontKnow";
		}
	}

	@RequestMapping(value = "/freeboard/freeboard_bad_cnt_update")
	@ResponseBody
	public String freeboard_update_bad_cnt(Model model, @RequestParam("idx") int idx, @RequestParam("id") String id,
			HttpServletResponse response) throws IOException {
		FreeBoardDTO FB_reply_id_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
		if (FB_reply_id_check.bad_cnt_list == null || FB_reply_id_check.bad_cnt_list.contains("," + id + ",") == false) {
			FB_reply_id_check.bad_cnt_list += "," + id + ",";
			sqlsession.update("freeboard.FreeBoard_bad_cnt_list_update", FB_reply_id_check);
			FreeBoardDTO FB_reply_id_plus_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
			// System.out.println(FB_reply_id_plus_check.bad_cnt);
			return Integer.toString(FB_reply_id_plus_check.bad_cnt);
		} else if (FB_reply_id_check.bad_cnt_list.contains("," + id + ",")) {
			// System.out.println(FB_reply_id_check.bad_cnt_list);
			FB_reply_id_check.bad_cnt_list = FB_reply_id_check.bad_cnt_list.replace("," + id + ",", "");
			sqlsession.update("freeboard.FreeBoard_bad_cnt_list_re_update", FB_reply_id_check);
			FreeBoardDTO FB_reply_id_minus_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
			// System.out.println(FB_reply_id_minus_check.bad_cnt_list);
			// System.out.println(FB_reply_id_minus_check.bad_cnt);
			return Integer.toString(FB_reply_id_minus_check.bad_cnt);
		} else {
			return "IdontKnow";
		}
	}

	@RequestMapping(value = "/freeboard/freeboardchangecont/{idx}")
	public String freeboard_change_cont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		FreeBoardDTO FB_change = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
		model.addAttribute("FBboardChangeCont", FB_change);
		return "freeboard/freeboardchangecont";
	}

	@RequestMapping(value = "/freeboard/freeboardwritecont")
	public String freeboard_write_Cont(Locale locale, Model model) {
		return "/freeboard/freeboardwritecont";
	}

	@RequestMapping(value = "/freeboard/mb_freeboardwrite")
	public String mb_freeboard_write(Locale locale, Model model, FreeBoardDTO fb_dto) {
		fb_dto.password = "12345"; // 회원들의 디폴트 비밀번호는 웹브라우저의 개발도구(f12)상에서 노출되기 때문에 서버측에서 바꾸어 줘야함.
		int temp = sqlsession.insert("freeboard.FreeBoard_InsertCont_mb", fb_dto);
		if (temp == 1) {
			return "redirect:/freeboard/freeboardindex";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
		}
		return "/freeboard/freeboardwritecont";
	}

	@RequestMapping(value = "/freeboard/nmb_freeboardwrite")
	public String nmb_freeboard_write(Locale locale, Model model, FreeBoardDTO fb_dto) {
		int temp = sqlsession.insert("freeboard.FreeBoard_InsertCont_nmb", fb_dto);

		if (temp == 1) {
			return "redirect:/freeboard/freeboardindex";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
		}
		return "/freeboard/freeboardwritecont";
	}
	
	@RequestMapping(value = "/freeboard/reply_freeboardwrite")
	@ResponseBody
	public String mb_freeboard_reply_write_Test(Model model,
			@RequestParam("primary_board_idx") int primary_board_idx,
			@RequestParam("id") String id,
			@RequestParam("content") String content,
			HttpServletResponse response) {
		FreeBoardDTO Re_fb_dto = new FreeBoardDTO();
		Re_fb_dto.id = id;
		Re_fb_dto.primary_board_idx = primary_board_idx;
		Re_fb_dto.content = content;
		Re_fb_dto.password = "12345";
		int temp = sqlsession.insert("freeboard.FreeBoard_InsertCont_reply", Re_fb_dto);
		int reply_cnt_idx = Re_fb_dto.primary_board_idx;
		int temp2 = sqlsession.update("freeboard.FreeBoard_re_cnt_update", reply_cnt_idx);
		if (temp == 1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}

	@RequestMapping(value = "/freeboard/re_reply_freeboardwrite")
	@ResponseBody
	public String mb_freeboard_re_reply_write(Model model,
			@RequestParam("primary_board_idx") int primary_board_idx,
			@RequestParam("reply_board_idx") int reply_board_idx,
			@RequestParam("id") String id,
			@RequestParam("content") String content,
			HttpServletResponse response) {
		FreeBoardDTO Re_Re_fb_dto = new FreeBoardDTO();
		Re_Re_fb_dto.id = id;
		Re_Re_fb_dto.primary_board_idx = primary_board_idx;
		Re_Re_fb_dto.reply_board_idx = reply_board_idx;
		Re_Re_fb_dto.content = content;
		Re_Re_fb_dto.password = "12345";
		int temp = sqlsession.insert("freeboard.FreeBoard_InsertCont_re_reply", Re_Re_fb_dto);
		int reply_cnt_idx = Re_Re_fb_dto.reply_board_idx;
		int temp2 = sqlsession.update("freeboard.FreeBoard_re_cnt_update", reply_cnt_idx);
		if (temp == 1) {
			return "true";
		} else {
			model.addAttribute("글쓰기 정보 : ", "피치못할사정에 insert실패했어요..");
			return "false";
		}
	}

	@RequestMapping(value = "/freeboard/freeboard_update_mb")
	public String freeboard_uqdate_mb(Locale locale, Model model, FreeBoardDTO chg_dto) {
		int FB_update = sqlsession.update("freeboard.FreeBoard_update_mb", chg_dto);
		model.addAttribute("FBboardUpdate", FB_update);
		return "redirect:/freeboard/freeboardindex";
	}

	@RequestMapping(value = "/freeboard/freeboard_update_nmb")
	public String freeboard_uqdate_nmb(Locale locale, Model model, FreeBoardDTO chg_dto) {
		int FB_update = sqlsession.update("freeboard.FreeBoard_update_nmb", chg_dto);
		model.addAttribute("FBboardUpdate", FB_update);
		return "redirect:/freeboard/freeboardindex";
	}

	@RequestMapping(value = "/freeboard/freeboard_delete/{idx}")
	public String freeboard_delete(Locale locale, Model model, @PathVariable int idx) {
		int FB_delete = sqlsession.delete("freeboard.FreeBoard_delete", idx);
		model.addAttribute("FBboard_delete", FB_delete);
		return "redirect:/freeboard/freeboardindex";
	}

	
	@RequestMapping(value = "/freeboard/freeboard_delete_reply")
	@ResponseBody 
	public String freeboard_delete_reply(@RequestParam("idx") int idx, HttpServletResponse response) throws IOException{ 
		FreeBoardDTO temp_data = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx ); 
		if(temp_data.reply_board_idx==0) {
			int reply_cnt_idx = temp_data.primary_board_idx;
			int FB_pre_update = sqlsession.update("freeboard.FreeBoard_re_cnt_delete_update", reply_cnt_idx);
			int FB_delete = sqlsession.delete("freeboard.FreeBoard_re_delete", idx);
		  }
		else {
			int reply_cnt_idx = temp_data.reply_board_idx;
			int FB_pre_update = sqlsession.update("freeboard.FreeBoard_re_cnt_delete_update", reply_cnt_idx);
			int FB_delete = sqlsession.delete("freeboard.FreeBoard_re_delete", idx);
		}
		return "FB_delete";
	}
	 

	@RequestMapping(value = "/freeboard/freeboardpscheck")
	@ResponseBody
	public String freeboardpscheck(@RequestParam("idx") int idx, @RequestParam("password") String password,
			HttpServletResponse response) throws IOException {
		FreeBoardDTO FB_ps_check = sqlsession.selectOne("freeboard.FreeBoard_ReadCont", idx);
		String db_password = FB_ps_check.password;
		if (db_password.equals(password)) {
			return "true";
		} else {
			return "false";
		}
	}

	/*
	 * @RequestMapping(value = "/test")
	 * 
	 * @ResponseBody public String test(@RequestParam("idx") String
	 * idx,@RequestParam("password") String password, HttpServletResponse response)
	 * throws IOException { System.out.println(idx); System.out.println(password);
	 * return password; }
	 */

}
