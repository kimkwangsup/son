<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>son Main</title>
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<style type="text/css">
	.fblist{
		cursor: pointer;
	}
	
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('#login').click(function(){
		var sid = '${SID}';
		if(!sid || sid == 'null'){
			$(location).attr('href','/member/login.son');
		}else{
			alert('이미 로그인 했습니다.')
		}
	});
	$('#logout').click(function(){
		$(location).attr('href','/member/flogoutProc.son');
	});
	$('#join').click(function(){
		// 로그인 여부 검사
		var sid = '${SID}';
		if(!sid || sid == 'null'){
			$(location).attr('href', '/member/join.son');
		} else{
			return;
		}
	});
	$('#home').click(function(){
		$(location).attr('href', '/main.son');
	});
	$('.fblist').click(function(){
		var sbno = $(this).attr('id');
		// 현재 페이지 세팅
		$('#nowPage').val('${PAGE.nowPage}');
		$('#bno').val(sbno);
		$('#frm').submit();
		
	});
	$('#write').click(function(){
		$(location).attr('href', '/fboard/fileboardWrite.son');
	});
	// 페이지 클릭 이벤트
	$('.pageBtn').click(function(){
		// 이동할 페이지 번호 알아내고
		var nowPage = $(this).attr('id');
		// 입력 태그에 데이터 채우고
		$('#nowPage').val(nowPage);
		// 폼태그 전송하고
		$('#pageFrm').submit();
	});
	$('span').addClass('w3-round-large w3-border');
});
</script>
</head>
<body>
	<!-- 전송용 폼태그 -->
	<form method="POST" action="/fboard/fileboardDetail.son" id="frm" name="frm">
		<input type="hidden" name="bno" id="bno">
		<input type="hidden" name="nowPage" id="nowPage">
	</form>
	
	<!-- 페이지 요청 폼 -->
	<form method="POST" action="/fboard/fileboard.son" id="pageFrm" name="pageFrm">
		<input type="hidden" name="nowPage" id="nowPage">
	</form>
<div class="w3-content mxw650 w3-center">
	<h1 class="w3-col w3-teal w3-padding w3-card-4 w3-round-large w3-btn" id="home">파일 게시판</h1>
	<div class="w3-col mgt10">
<c:if test="${not empty SID}">
		<div class="inblock w3-btn w3-small w3-right w3-blue-gray" id="write">글작성</div>
		<div class="inblock w3-btn w3-small w3-left w3-pale-red" id="logout">로그아웃</div>
</c:if>
<c:if test="${empty SID}">
		<div class="inblock w3-right w3-btn w3-small w3-pale-green" id="join">회원가입</div>
		<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
</c:if>
		<div class="w3-col w3-margin-top">
			<div class="w3-col w3-center">
				<div class="inblock w3-left pdr5" style="width: 100px;"><div class="w3-blue-gray">글번호</div></div>
				<div class="inblock w3-right" style="width: 50px;"><div class="w3-blue-gray">파일</div></div>
				<div class="inblock w3-right pdr5" style="width: 170px;"><div class="w3-blue-gray">작성일</div></div>
				<div class="inblock w3-right pdr5" style="width: 150px;"><div class="w3-blue-gray">작성자</div></div>
				<div class="w3-rest pdr5"><div class="w3-blue-gray">글제목</div></div>
			</div>
<c:if test="${not empty LIST}">
	<c:forEach var="DATA" items="${LIST}">
		<c:if test="${not empty SID}">
			<div class="w3-col w3-border-bottom w3-margin-top fblist" id="${DATA.bno}">
		</c:if>
		<c:if test="${empty SID}">
			<div class="w3-col w3-border-bottom w3-margin-top" id="${DATA.bno}">
		</c:if>
				<div class="inblock w3-left pdr5" style="width: 100px;"><div class="w3-center fbno">${DATA.bno}</div></div>
				<div class="inblock w3-right" style="width: 50px;"><div class="w3-center file">${DATA.cnt}</div></div>
				<div class="inblock w3-right pdr5" style="width: 170px;"><small class="w3-center wdate">${DATA.sdate}</small></div>
				<div class="inblock w3-right pdr5" style="width: 150px;"><div class="w3-center writer">${DATA.id}</div></div>
				<div class="w3-rest pdr5">
					<div class="title">${DATA.title}</div>
				</div>
			</div>
	</c:forEach>
	<div class="w3-col w3-center w3-margin-top">
		<div class="w3-bar w3-round">
<c:if test="${PAGE.startPage eq 1}">
			<span class="w3-bar-item w3-light-gray" id="${PAGE.startPage - 1}" >&laquo;</span>
</c:if>
<c:if test="${PAGE.startPage ne 1}">
			<span class="w3-bar-item w3-button w3-light-gray w3-hover-blue-gray pageBtn" id="${PAGE.startPage - 1}" >&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
	<c:if test="${PAGE.nowPage eq pno}">
				<span class="w3-bar-item pageBtn w3-pink" id="${pno}">${pno}</span>
	</c:if>
	<c:if test="${PAGE.nowPage ne pno}">
				<span class="w3-bar-item w3-button pageBtn" id="${pno}">${pno}</span>
	</c:if>
</c:forEach>
<c:if test="${PAGE.endPage ne PAGE.totalPage}">
			<span class="w3-bar-item w3-button w3-light-gray w3-hover-blue-gray pageBtn" id="${PAGE.endPage + 1}">&raquo;</span>
</c:if>
<c:if test="${PAGE.endPage eq PAGE.totalPage}">
			<span class="w3-bar-item w3-light-gray">&raquo;</span>
</c:if>
		</div>
	</div>
</c:if>
<c:if test="${empty LIST }">
		<div class="w3-col w3-margin-top">
			<h2 class="w3-center w3-text-gray">아직 작성된 글이 없습니다.</h2>
		</div>
</c:if>
	</div>
</div>
</body>