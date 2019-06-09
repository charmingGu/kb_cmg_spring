package com.ChaMg.MyProJect.StudyBoard_Recruit;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class StudyBoard_mystudyboard_list {
	
	private static final Logger logger = LoggerFactory.getLogger(StudyBoard_mystudyboard_list.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_myrecruit_list", method = RequestMethod.GET)
	public String myRecruitList(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/studyboard_MyBoard/studyboard_myrecruit_list";
	}
	
	@RequestMapping(value = "/studyboard_MyBoard/studyboard_myrequest_list", method = RequestMethod.GET)
	public String myRequestList(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/studyboard_MyBoard/studyboard_myrequest_list";
	}
	
}
