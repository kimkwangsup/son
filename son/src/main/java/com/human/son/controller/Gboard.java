package com.human.son.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.son.dao.GboardDao;

@Controller
@RequestMapping("/gboard")
public class Gboard {
	@Autowired
	GboardDao gDao;
	@RequestMapping("/gboard.son")
	public ModelAndView GboardList(ModelAndView mv, RedirectView rv, HttpSession session) {
		mv.setViewName("/gboard/gboard");
		return mv;
	}
	
}
