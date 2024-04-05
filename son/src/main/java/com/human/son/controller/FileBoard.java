package com.human.son.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.son.dao.FileBoardDao;
import com.human.son.util.*;
import com.human.son.vo.BoardVO;

@Controller
@RequestMapping("/fboard")
public class FileBoard {
	@Autowired
	FileBoardDao fDao;
	@RequestMapping("/fileboard.son")
	public ModelAndView boardList(ModelAndView mv, HttpSession session, RedirectView rv, PageUtil page) {
		// 할일
		int nowPage = page.getNowPage();
		if(nowPage == 0 ) {
			nowPage = 1;
		}
		int totalCnt = fDao.getTotal();
		
		page.setPage(nowPage, totalCnt);
		
		// 데이터베이스에서 조회
		List<BoardVO> list = fDao.getList(page);
		// 데이터 전달하고
		mv.addObject("LIST", list);
		mv.addObject("PAGE", page);
		// 뷰 세팅하고
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
	@RequestMapping("/writeProc.son")
	public ModelAndView writeProc(ModelAndView mv, HttpSession session, RedirectView rv, BoardVO bVO){
		/*
			할일
				파라미터를 받아야 한다.
				지금까지는 매개변수에 VO를 선언해주면 키값과 동일한 변수를 찾아서
				데이터를 채워줬는데
				지금은 바이트 단위로 데이터를 전송하기 때문에 데이터를 꺼내는 방식
		 */
		MultipartFile[] file = bVO.getFile();
		for(MultipartFile f : file) {
			
		}
		rv.setUrl("/fboard/fileboard.son");
		mv.setView(rv);
		return mv;
	}
}
