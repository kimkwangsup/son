package com.human.son.service;

import java.lang.reflect.Method;
import javax.servlet.http.*;
import org.aspectj.lang.*;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.*;
import org.slf4j.*;
import org.springframework.stereotype.*;
import com.human.son.vo.*;

@Service
@Aspect
public class GboardLogService {
	
	private static final Logger gboardLog = LoggerFactory.getLogger("gboardLog");
	
	@After("execution(* com.human.son.controller.Gboard.**Proc(..))")
	public void gboardLog(JoinPoint join) {
		HttpSession session = (HttpSession) join.getArgs()[0];
		String sid = (String) session.getAttribute("SID");
		BoardVO bVO = (BoardVO) join.getArgs()[3];
		String act = bVO.getCnt() != 1 ? "성공" : "실패";
		String body = bVO.getBody();
		gboardLog.info("[ " + sid + " ] 님이 [ " + body + " ] 내용으로 방명록 작성에 " + act + "하였습니다.");
	}
}
