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
		$('#bno').val(sbno);
		$('#frm').submit();
	});
	$('#write').click(function(){
		$(location).attr('href', '/fboard/fileboardWrite.son');
	});
	
});
</script>
</head>
<body>
<form method="POST" action="/fboard/fileboardDetail.son" id="frm" name="frm">
	<input type="hidden" name="bno" id="bno">
</form>
<div class="w3-content mxw650 w3-center">
	<h1 class="w3-teal w3-padding w3-card-4 w3-round-large">파일 게시판</h1>
	<div class="w3-col mgt10">
		<div class="inblock w3-left w3-btn w3-small w3-sand" id="home">메인화면</div>
<c:if test="${not empty SID}">
		<div class="inblock w3-btn w3-small w3-right w3-blue-gray" id="write">글작성</div>
		<div class="inblock w3-btn w3-small w3-left w3-pale-red" id="logout">로그아웃</div>
</c:if>
<c:if test="${empty SID}">
		<div class="inblock w3-right w3-btn w3-small w3-pale-green" id="join">회원가입</div>
		<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
</c:if>
		<div class="w3-col w3-margin-top">
			<div class="w3-blue-gray inblock" style="width: 80px">글번호</div>
			<div class="w3-blue-gray inblock" style="width: 220px">글제목</div>
			<div class="w3-blue-gray inblock" style="width: 165px">작성일</div>
			<div class="w3-blue-gray inblock" style="width: 80px">작성자</div>
			<div class="w3-blue-gray inblock" style="width: 80px">파일</div>
		</div>
		
		<div class="w3-col w3-margin-top fblist" id="1234">
			<div class="w3-border inblock w3-left-align fbno" style="width: 80px">1</div>
			<div class="w3-border inblock w3-left-align file" style="width: 220px">2</div>
			<div class="w3-border inblock w3-left-align wdate" style="width: 165px">3</div>
			<div class="w3-border inblock w3-left-align writer" style="width: 80px">4</div>
			<div class="w3-border inblock w3-left-align title" style="width: 80px">5</div>
		</div>
		
	</div>
	<div class="w3-col w3-center w3-margin-top">
		<div class="w3-bar w3-border w3-round">
			<a href="#" class="w3-bar-item w3-button w3-light-gray w3-hover-blue-gray">&laquo;</a>
			<a href="#" class="w3-bar-item w3-button">1</a>
			<a href="#" class="w3-bar-item w3-button">2</a>
			<a href="#" class="w3-bar-item w3-button">3</a>
			<a href="#" class="w3-bar-item w3-button">4</a>
			<a href="#" class="w3-bar-item w3-button w3-light-gray w3-hover-blue-gray">&raquo;</a>
		</div>
	</div>
</div>
</body>