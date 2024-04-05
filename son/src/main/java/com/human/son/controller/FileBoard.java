package com.human.son.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/fboard")
public class FileBoard {
	
	@RequestMapping("/fileboard.son")
	public ModelAndView boardList(ModelAndView mv, HttpSession session, RedirectView rv) {
		mv.setViewName("fboard/fileboard");
		return mv;
	}
	
	@RequestMapping("/fileboardDetail.son")
	public ModelAndView boardDetail(ModelAndView mv, HttpSession session, RedirectView rv, int bno) {
		mv.setViewName("fboard/fileboardDetail");
		String[] list = {"0001.jpg", "0002.jpg", "0003.jpg"};
		mv.addObject("LIST", list);
		return mv;
	}
	@RequestMapping("/fileboardWrite.son")
	public ModelAndView boardWrite(ModelAndView mv, HttpSession session, RedirectView rv) {
		mv.setViewName("fboard/fileboardWrite");
		return mv;
	}
}
