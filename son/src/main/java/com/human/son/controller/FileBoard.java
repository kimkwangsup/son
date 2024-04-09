package com.human.son.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.human.son.dao.*;
import com.human.son.service.*;
import com.human.son.util.*;
import com.human.son.vo.*;

@Controller
@RequestMapping("/fboard")
public class FileBoard {
	@Autowired
	FileBoardDao fDao;
	@Autowired
	FileBoardService fService;
	
	
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
	public ModelAndView boardDetail(ModelAndView mv, HttpSession session, RedirectView rv, BoardVO bVO, PageUtil page) {
		bVO = fDao.getBnoDetail(bVO.getBno());
		mv.addObject("DATA", bVO);
		mv.addObject("PAGE", page);
		mv.setViewName("fboard/fileboardDetail");
		return mv;
	}
	@RequestMapping("/fileboardWrite.son")
	public ModelAndView boardWrite(ModelAndView mv, HttpSession session, RedirectView rv) {
		mv.setViewName("fboard/fileboardWrite");
		return mv;
	}
	@RequestMapping("/writeProc.son")
	public ModelAndView writeProc(HttpSession session, ModelAndView mv, 
											RedirectView rv, BoardVO bVO) {
		/*
			할일
				파라미터를 받아야 한다.
				지금까지는 매개변수에 VO 를 선언해주면 키값과 동일한 변수를 찾아서
				데이터를 채워줬는데 
				지금은 바이트 단위로 데이터를 전송하기 때문에 데이터를 꺼내는 방식도 달라져야 한다.
				
				
		 */
//		MultipartFile[] file = bVO.getFile();
		// fileboard 테이블에 데이터 입력하고
		boolean bool = fService.insertProc(bVO);
		if(bool == true) {
			rv.setUrl("/fboard/fileboard.son");
		}else {
			rv.setUrl("/fboard/fileboardWrite.son");
		}
		
		mv.setView(rv);
		return mv;
	}
}
