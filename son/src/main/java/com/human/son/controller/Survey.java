package com.human.son.controller;

import javax.servlet.http.*;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.human.son.dao.SurveyDao;
import com.human.son.service.SurveyService;
import com.human.son.vo.SurveyVO;

@Controller
@RequestMapping("/survey")
public class Survey {
	@Autowired
	SurveyDao sDao;
	@Autowired
	SurveyService sSrvc;
	/**
	 * 설문문항
	 */
	@RequestMapping("/dataInit.son")
	public ModelAndView dataInit(HttpSession session, ModelAndView mv, RedirectView rv) {
		// 데이터베이스 작업
		String result = sSrvc.setQData();
		
		// 데이터 결과
		mv.addObject("RESULT", result);
		mv.addObject("PATH", "/main.son");
		/*
		// 뷰 세팅하고
		rv.setUrl("/main.son");
		mv.setView(rv);
		*/
		mv.setViewName("redirect");
		return mv;
	}
	/**
	 * 설문조사 리스트 페이지 요청 전달 처리함수
	 */
	@RequestMapping("/surveyList.son")
	public ModelAndView surveyList(ModelAndView mv) {
		// 데이터베이스 조회해서 결과받고
		List<SurveyVO> list = sDao.getTopicList();
		mv.addObject("LIST", list);
		mv.setViewName("/survey/surveyList");
		return mv;
	}
	/**
	 * 설문조사 문항 등록 요청 전담 처리함수
	 */
	@RequestMapping("/addSurvey.son")
	public ModelAndView addSurvey(HttpSession session, ModelAndView mv, RedirectView rv, SurveyVO sVO) {
		// 할일
		// 세션검사 ==> 인터셉터에서 처리
		// 데이터베이스 입력
		String result = sSrvc.setSurvey(sVO);
		rv.setUrl("/survey/surveyList.son");
		mv.setView(rv);
		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
