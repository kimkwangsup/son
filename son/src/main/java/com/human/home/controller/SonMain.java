package com.human.home.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class SonMain {
	@RequestMapping({"/"})
	public ModelAndView getMain(ModelAndView mv, RedirectView rv) {
		// 데이터 전달
		// 뷰 세팅
		rv.setUrl("/main.son");
		mv.setView(rv);
		return mv;
	}
}
