package com.human.son.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.son.dao.GboardDao;
import com.human.son.util.PageUtil;
import com.human.son.vo.BoardVO;

@Controller
@RequestMapping("/gboard")
public class Gboard {
	@Autowired
	GboardDao gDao; // GboardDao gDao = new G
	
	
	@RequestMapping("/gboard.son")
	public ModelAndView GboardList(ModelAndView mv, RedirectView rv, HttpSession session, PageUtil page) {
		// 페이지 세팅
		// 현재 페이지 세팅
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		// 총 게시글 갯수 세팅
		int totalCnt = gDao.getTotal();
		page.setPage(nowPage, totalCnt);
		mv.addObject("PAGE", page);
		// 로그인 여부 판별
		String sid = (String) session.getAttribute("SID");
		if(sid != null) {
			// 로그인 한 경우
			// 카운트 조회하고
			int cnt = gDao.getCnt(sid);
			// 데이터 전달하고
			mv.addObject("CNT", cnt);
		}
		// 리스트 조회
		List<BoardVO> list = gDao.getGboardList(page);
		
		// 리스트를 뷰에 전달
		mv.addObject("LIST", list);
		mv.setViewName("/gboard/gboard");
		return mv;
	}
	/**
	 *  방명록 글등록 처리요청(modal)
	 */
	
	@RequestMapping("/gWriteProc.son")
	public ModelAndView gWriteProc(HttpSession session, ModelAndView mv, RedirectView rv, BoardVO bVO) {
		if(session.getAttribute("SID") == null) {
			rv.setUrl("/member/login.son");
		}
		int cnt = gDao.writeProc(bVO);
		if(cnt == 1) {
			rv.setUrl("/gboard/gboard.son");
		} 
		mv.setView(rv);
		return mv;
	}
	/**
	 * 방명록 글등록 처리요청(redirect)
	 */
	@RequestMapping(path="/gWriteProc2.son", params= {"id","body","nowPage"}, method=RequestMethod.POST)
	public ModelAndView writeProc(HttpSession session, ModelAndView mv, RedirectView rv, BoardVO bVO, int nowPage) {
		int cnt = gDao.writeProc(bVO);
		if(cnt != 1) {
			rv.setUrl("/gboard/gWrite.son?nowPage=" + nowPage);
		} else {
			rv.setUrl("/gboard/gboard.son");
		}
		mv.setView(rv);
		return mv;
	}
	/**
	 * 방명록 작성 폼 보기 요청 전담 처리함수
	 */
	@RequestMapping(path={"/gWrite.son", "/gboardWrite.son"}, params="nowPage")
	public ModelAndView gWrite(HttpSession session, ModelAndView mv, 
											RedirectView rv, int nowPage) {
		// 세션검사는 Interceptor에서 처리할 것이므로 여기서는 생략...
		// 데이터 심고
		mv.addObject("nowPage", nowPage);
		// 뷰 정하고
		mv.setViewName("gboard/gboardWrite");
		// 반환하고
		return mv;
	}
	
}
