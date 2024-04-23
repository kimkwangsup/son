package com.human.son.service;

import java.util.*;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.*;

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
}
