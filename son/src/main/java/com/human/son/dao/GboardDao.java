package com.human.son.dao;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.son.util.PageUtil;
import com.human.son.vo.*;

public class GboardDao {
	@Autowired
	SqlSessionTemplate session;
	
	/**
	 * 방명록 전체 조회 전담처리함수
	 */
	public List<BoardVO> getGboardList(PageUtil page){
		return session.selectList("gSQL.selList", page);
	}
	/**
	 * 작성한 방명록 갯수 조회 전담 처리함수
	 */
	public int getCnt(String id) {
		return session.selectOne("gSQL.getCnt", id);
	}
	/**
	 * 총 방명록 갯수 조회 전담 처리함수
	 */
	public int getTotal() {
		return session.selectOne("gSQL.getTotal");
	}
	/**
	 * 방명록 작성 전담 처리함수
	 */
	public int writeProc(BoardVO bVO) {
		return session.insert("gSQL.writeProc", bVO);
	}
}


