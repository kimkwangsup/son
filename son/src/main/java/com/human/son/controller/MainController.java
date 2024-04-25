package com.human.son.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.human.son.dao.SurveyDao;
import com.human.son.vo.SurveyVO;

@Controller
public class MainController {
	@Autowired
	SurveyDao sDao;
	@RequestMapping("/main.son")
	public ModelAndView goMain(ModelAndView mv, SurveyVO sVO) {
//	public String goMain() {
		// 데이터 전달
		int cnt = sDao.getIngCnt();
		mv.addObject("SCNT", sVO.getCnt());
		mv.addObject("INGCNT", cnt);
		// 뷰 세팅
		mv.setViewName("main");
		return mv;
	}
	
}
