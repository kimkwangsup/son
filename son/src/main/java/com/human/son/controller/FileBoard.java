package com.human.son.controller;

import java.util.*;

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
		List list = fDao.getImgList(bVO.getBno());
		mv.addObject("DATA", bVO);
		mv.addObject("LIST", list);
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
	/**
	 * 게시글 삭제 요청 전담 처리함수
	 */
	@RequestMapping("/fboardDelProc.son")
	public ModelAndView delProc(HttpSession session, ModelAndView mv, RedirectView rv, int bno, int nowPage, BoardVO bVO) {
		// 할일
		// 세션 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			// 로그인 안한 경우
			// ==> 삭제 처리 하면 안된다.
			rv.setUrl("/member/login.son");
			mv.setView(rv);
			return mv;
		}
		bVO.setId(sid);
		// 로그인한 사람과 작성자 일치 여부 확인
		// 로그인한 사람의 회원 번호 조회
		// ==> update 질의명령의 조건절에서 처리하므로 필요 없다.
		
		// 데이터베이스 작업하고 결과받고
		int cnt = fDao.delFboard(bVO);
		// 결과 처리에 따라서 페이지 번호와 전달 메세지(msg)를 전달해줘야 한다.
		// 결과값 변수
		String msg = "YES";
		if(cnt != 1) {
			// 삭제에 실패
			msg = "NO";
		}
		// 뷰세팅
		rv.setUrl("/fboard/fileboard.son?nowPage=" + nowPage + "&MSG=" + msg);
		mv.setView(rv);
		return mv;
	};
	/**
	 * 게시글 수정 폼보기 요청 전담 처리함수
	 */
	@RequestMapping("/fileboardEdit.son")
	public ModelAndView boardEdit(HttpSession session, ModelAndView mv, RedirectView rv, BoardVO bVO, int nowPage) {
		// 할일
		// 세션검사
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/member/login.son");
			mv.setView(rv);
			return mv;
		}
		// 글번호에 해당하는 상세내용 조회
		bVO = fDao.getBnoDetail(bVO.getBno());
		// 첨부파일 리스트 조회
		List<FileVO> list = fDao.getImgList(bVO.getBno());
		
		mv.addObject("nowPage", nowPage); // 현재페이지
		mv.addObject("DATA", bVO); // 게시글 정보
		mv.addObject("LIST", list);// 이미지리스트
		// 뷰세팅
		mv.setViewName("fboard/fileboardEdit");
		
		return mv;
	}
	/**
	 * 첨부파일 삭제 요청 전담 처리함수.
	 */
	@ResponseBody
	@RequestMapping("/fboardDelImg.son")
	public HashMap<String, String> delImgProc(int fno){
		// 반환값 변수
		HashMap<String, String> map = new HashMap<String, String>();
		
		int cnt = fDao.delImg(fno); // 삭제 처리에 성공하면 1, 실패하면 0 반환
		String result = "OK";
		if(cnt != 1) {
			// 삭제처리에 실패한 경우
			result = "NO";
		}
		map.put("result", result);
		return map;
	}
	/**
	 *  이미지 삭제 일괄 처리 요청 전담 처리함수
	 */
	@RequestMapping("/delImgList.son")
	public ModelAndView delImgList(HttpSession session, ModelAndView mv, RedirectView rv, BoardVO bVO, int nowPage) {
		// 할일
		// 세션검사
		
		// 데이터베이스 작업 처리
		
		int cnt = fDao.delImages(bVO.getImgList());
		// 데이터 전달
		mv.addObject("nowPage", nowPage);
		mv.addObject("BNO", bVO.getBno());
		mv.addObject("PATH", "/fboard/fileboardEdit.son");
		
		// 뷰를 부르고
		// 여기서는 forward 방식으로 리다이렉트용 뷰를 만들어서 전달하는 것으로 한다.
		/*
			rv.setUrl("/fboard/fileboard.son?bno=" + bVO.getBno() + 
													"&nowPage=" + nowPage);
			mv.setView(rv)
		 */
		mv.setViewName("fboard/redirect");
		return mv;
	}
	/**
	 * 게시글 수정 처리 요청 전담 처리함수
	 */
	@RequestMapping("/editProc.son")
	public ModelAndView editProc(HttpSession session, ModelAndView mv, RedirectView rv, int nowPage, BoardVO bVO) {
		// 할일
		// 서비스 함수 호출해서 처리
		boolean bool = fService.editProc(bVO);
		String path = "/fboard/fileboardDetail.son";
		if(!bool) {
			// 실패한 경우 수정페이지로 리다이렉트
			path = "/fboard/fileboardEdit.son";
		}
		// 데이터 전달하고
		mv.addObject("PATH", path);
		mv.addObject("nowPage", nowPage);
		mv.addObject("BNO", bVO.getBno());
		
		// 뷰 부르고
		mv.setViewName("fboard/redirect");
		// 반환하고
		return mv;
	}
}






























