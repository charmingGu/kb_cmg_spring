package com.ChaMg.MyProJect.NoticeBoard;

import java.util.List;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ChaMg.MyProJect.FreeBoard.FreeBoardController;

@Controller
public class NoticeBoardController {
private static final Logger logger = LoggerFactory.getLogger(FreeBoardController.class);
	@Autowired
	SqlSession sqlsession;
	/**
	 * Simply selects the home view to render by returning its name.
	 * 공지사항으로 이동하는 기능.
	 */
	@RequestMapping(value = "/notice/noticeboard")
	public String notice(Locale locale, Model model) {
		List<NoticeBoardDTO> NB_list = sqlsession.selectList("notice.NoticeBoard_ListAll");
		model.addAttribute("NBboardListView", NB_list);
		return "/notice/noticeboard";
	}
	
//	공지게시판의 내용을 보여주는 기능.
	@RequestMapping(value = "/notice/noticeboardreadcont/{idx}")
	public String noticeboardreadcont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		int NB_cnt_update = sqlsession.update("notice.NoticeBoard_cnt_update", idx);
		NoticeBoardDTO NB_cont = sqlsession.selectOne("notice.NoticeBoard_readCont", idx );
		model.addAttribute("NBboardReadCont", NB_cont);
		return "/notice/noticeboardreadcont";
	}
	
//	공지사항의 내용을 수정가능한 페이지로 이동.
	@RequestMapping(value = "/notice/noticeboardchangecont/{idx}")
	public String noticeboardchangecont(Locale locale, Model model, @PathVariable(value = "idx") int idx) {
		NoticeBoardDTO NB_change = sqlsession.selectOne("notice.NoticeBoard_readCont", idx );
		model.addAttribute("NBboardChangeCont", NB_change);
		return "/notice/noticeboardchangecont";
	}
	
//	공지사항의 내용을 작성하는 페이지로 이동하는 기능.
	@RequestMapping(value = "/notice/noticeboardwritecont")
	public String noticewriteCont(Locale locale, Model model) {
		return "/notice/noticeboardwritecont";
	}
	
//	공지사항의 내용을 작성하는 기능.
	@RequestMapping(value = "/notice/noticeboardwrite")
	public String noticeboardwrite(Locale locale, Model model, NoticeBoardDTO ntb_dto) {
		int temp = sqlsession.insert("notice.NoticeBoard_InsertCont", ntb_dto);
		
		if( temp ==1 ) {
			return "redirect:/notice/noticeboard";
		}else {
			model.addAttribute("글쓰기 정보 : ","피치못할사정에 insert실패했어요..");
	}
		return "/notice/noticeboardwritecont";
	}
	
//	공지사항의 내용을 수정하는 기능.
	@RequestMapping(value = "/notice/noticeboard_update")
	public String noticeboard_uqdate(Locale locale, Model model, NoticeBoardDTO chg_dto) {
		int NB_update = sqlsession.update("notice.NoticeBoard_update", chg_dto);
		model.addAttribute("NBboardReadCont", NB_update);
		return "redirect:/notice/noticeboard";
		}
	
//	공지사항의 내용을 삭제하는 기능.
	@RequestMapping(value = "/notice/noticeboard_delete/{idx}")
	public String noticeboard_delete(Locale locale, Model model, @PathVariable int idx) {
		int NB_delete = sqlsession.delete("notice.NoticeBoard_delete", idx);
		model.addAttribute("NBboard_delete", NB_delete);
		return "redirect:/notice/noticeboard";
		}
}
