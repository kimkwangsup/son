package com.human.son.service;

import java.io.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.web.multipart.*;

import com.human.son.dao.*;
import com.human.son.util.*;
import com.human.son.vo.*;

public class FileBoardService {
	@Autowired
	FileBoardDao fDao;
	@Autowired
	FileUtil fUtil;
	/*
		파일 게시판 게시글 등록은 
		데이터베이스 작업이 두개의 테이블에 여러번 입력되는 작업이 진행될 것이다.
		이 작업들은 파일 정보의 경우 한가지 작업이 반복적으로 수행이 될 것이다.
		
		따라서 여기서 그 전체에 대한 작업을 처리해주도록 하겠다.
	 */
	/**
	 * 파일 업로드 처리함수
	 * 이 함수는 업로드한 파일을 서버에 저장하고
	 * 저장된 이름들을 반환해주는 함수
	 */
	public String[] uploadProc(MultipartFile[] file) {
		/*
			반환값 변수는 배열 타입이다.
			그런데 배열은 타입과 길이가 결정이 되어야 만들 수 있다.
			반환값으로 만들 배열은 타입은 정해져 있지만
			길이는 업로드하는 상황에 따라서 달라질 수 있다.
			이 배열을 만들려면 타입은 결정이 되었으니
			몇 개의 데이터를 기억할 지를 결정하면 된다.
		 */
		String[] upname = new String[file.length];
		// 경로 변수
		String path = this.getClass().getResource("/").getPath();
		path += "../../resources/upload";
		
		// 업로드한 파일의 갯수만큼 반복해준다.
		for(int i = 0; i < file.length ; i++) {
			// 업로드한 원래 파일 이름을 꺼낸다.
			String oriname = file[i].getOriginalFilename();
			if(oriname == null) {
				// 업로드할 파일이 없는 경우
				upname[i] = "";
				continue;
			}
			// 경로와 업로드 이름을 입력해서 저장이름을 꺼내오고
			String sname = fUtil.rename(path, oriname);
			upname[i] = sname;
			
			// 저장 가능한 이름을 꺼내왔으므로 파일을 저장한다
			try {
				// File 객체 만들고
				File saveFile = new File(path, sname);
				file[i].transferTo(saveFile); // 파일로 저장시켜주는 함수
				String path1 = "D:\\repo\\son\\son\\src\\main\\webapp\\resources\\upload";
				File saveFile1 = new File(path1, sname);
				// 아직 파일이 저장된 상태는 아니므로
				// 배열에 들어있는 파일 데이터를 이 객체에 쓴다.
				file[i].transferTo(saveFile1);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		// 저장된 이름은 데이터 작업에도 필요하므로 반환해준다.
		return upname;
	}
	
	/**
	 * 게시글과 파일정보 데이터를 데이터베이스에 입력하는 함수
	 */
	public boolean insertProc(BoardVO bVO) {
		// 반환값 변수
		boolean bool = true;
		// 게시글 업로드
		int cnt = fDao.addBoard(bVO);
		if(cnt != 1) {
			return false;
		}
		// 파일 저장
		String[] sname = uploadProc(bVO.getFile());
		// 저장 경로
		String path = this.getClass().getResource("/").getPath();
		path += "../../resources/upload";
		
		int fcnt = 0;
		// 파일 정보 입력
		for(int i = 0 ; i < bVO.getFile().length; i++) {
			// vo 만들고
			FileVO fVO = new FileVO();
			// 업로드 파일이름 꺼내고
			String oriname = bVO.getFile()[i].getOriginalFilename();
			// 파일 크기
			long len = bVO.getFile()[i].getSize(); // byte 단위로 파일 크기 반환
			
			// vo에 데이터 채우기
			fVO.setDir(path);
			fVO.setUpname(oriname);
			fVO.setSavename(sname[i]);
			fVO.setLen(len);
			fVO.setId(bVO.getId());
			cnt += fDao.addFileInfo(fVO);
		}
		if(fcnt != bVO.getFile().length) {
			bool = false;
		}
		
		// 반환값 반환
		return bool;
	}
}












