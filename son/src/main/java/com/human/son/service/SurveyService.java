package com.human.son.service;

import java.util.*;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import com.human.son.dao.*;
import com.human.son.vo.*;

@Aspect
public class SurveyService {
	@Autowired
	SurveyDao sDao;
	
	/**
	 *	입력 문항 갯수 조회 전담 처리함수
	 */
	@Before("execution(* com.human.**.**.**.**Main(..))")
	public void getQuestCnt(JoinPoint join) {
		int cnt = sDao.getQlistCnt();
		SurveyVO sVO = (SurveyVO)join.getArgs()[1];
		sVO.setCnt(cnt);
	}
	/**
	 *	데이터베이스에 문제 정보 입력 전담 처리함수 
	 */
	@Transactional
	public String setQData() {
		String result = "NO";
		// 문항 내용들 가져오기
		ArrayList<SurveyVO> list = getQuests();
		// 데이터베이스에 입력하고
		for(int i = 0 ; i < list.size() ; i++) {
			// 문제 데이터 꺼내고
			SurveyVO sVO = list.get(i);
			// 문제 정보 입력
			int cnt = sDao.addQuest(sVO);
			
			if(cnt == 1) {
				result = "OK";
				// 보기들 정보 꺼내고
				ArrayList<SurveyVO> bogis = sVO.getBogis();
				for(int j = 0 ; j < bogis.size(); j++) {
					// 보기 한개 정보 꺼내고
					SurveyVO bogi = bogis.get(j);
					// 문제 번호 채워주고
					bogi.setQupno(sVO.getQno());
					// 데이터베이스에 입력하고
					cnt = sDao.addQuest(bogi);
					result = cnt == 1 ? "OK" : "NO";
				}
			}
		}
		
		return result;
	}
	
	
	public ArrayList<String> getTitles(){
		ArrayList<String> list = new ArrayList<String>();
		list.add("원피스 멤버중 최애 멤버는?");
		list.add("가장 가지고 싶은 악마의 열매는?");
		list.add("원피스 최고의 빌런은?");
		list.add("원피스를 처음 접한 나이대는?");
		list.add("원피스 캐릭터중 가장 불쌍한 캐릭터는?");
		return list;
	}
	// 보기들을 반환해주는 함수
	public ArrayList<ArrayList<String>> getBogis(){
		ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
		for(int i = 0 ; i < getTitles().size() ; i++) {
			ArrayList<String> bogi = new ArrayList<String>();
			list.add(bogi);
		}
		// 1번 문항 보기
		list.get(0).add("쵸파");
		list.get(0).add("루피");
		list.get(0).add("조로");
		list.get(0).add("상디");
		
		// 2번 문항 보기
		list.get(1).add("고무고무");
		list.get(1).add("뭉게뭉게");
		list.get(1).add("사람사람");
		list.get(1).add("번개번개");
		
		// 3번 문항 보기
		list.get(2).add("루피");
		list.get(2).add("우솝");
		list.get(2).add("로저");
		list.get(2).add("에넬");
		
		// 4번 문항 보기
		list.get(3).add("10대");
		list.get(3).add("20대");
		list.get(3).add("30대");
		list.get(3).add("40대");
		
		// 5번 문항 보기
		list.get(4).add("버기");
		list.get(4).add("우솝");
		list.get(4).add("아론");
		list.get(4).add("빅맘");
		
		return list;
	}
	
	// 문제 내용 반환해주는 함수
	public ArrayList<SurveyVO> getQuests(){
		// 리스트 만들고
		ArrayList<SurveyVO> list = new ArrayList<SurveyVO>();
		
		// 리스트만큼 반복해서 SurveyVO를 만든다.
		ArrayList<String> titles = getTitles();
		for(int i = 0 ; i < titles.size(); i++) {
			String title = titles.get(i);
			// VO 만들고
			SurveyVO vo = new SurveyVO(); // 문제 하나를 기억할 VO
			// 문제 기억시키고
			vo.setBody(title);
			// 보기 입력하고
			ArrayList<SurveyVO> bogis = new ArrayList<SurveyVO>();
			ArrayList<ArrayList<String>> tmp = getBogis();
			vo.setBogis(bogis);
			
			ArrayList<String> imsi = tmp.get(i);
			// 보기 반복
			for(int j = 0 ; j < tmp.get(i).size(); j++) {
				String bogi = imsi.get(j);
				SurveyVO bogiVO = new SurveyVO(); // 보기 하나를 기억할 VO
				bogiVO.setBody(bogi); // 보기 하나 내용 입력
				bogis.add(bogiVO); // 보기 리스트에 보기 하나 추가
			}
			vo.setBogis(bogis);
			
			list.add(vo);
		}
		return list;
	}
	// 설문 문항 등록 전담 처리함수
	@Transactional
	public String setSurvey(SurveyVO sVO) {
		String result = "OK";
		int cnt = 0;
		// 등록 페이지가 없으므로 실제는 없어야 하는 코드
		for(int i = 0 ; i < 25 ; i++) {
			sVO.setQno(1001 + i);
			cnt += sDao.setSurvey(sVO);
		}
		if(cnt != 25) {
			result = "NO";
		}
		return result;
	}
	/**
	 * 원피스 설문조사 문항 리스트 반환함수
	 */
}























