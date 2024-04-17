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
		$(location).attr('href','/member/logoutProc.son');
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
	$('#gboard').click(function(){
		$(location).attr('href', '/gboard/gboard.son');
	})
	$('#fboard').click(function(){
		$(location).attr('href', '/fboard/fileboard.son');
	})
	$('#idList').click(function(){
		$(location).attr('href', '/member/memberList.son');
	});
	
	/*  
		myInfo 버튼이 클릭되면 아이디가 frm 태그에 bno 를 기억할 태그를 추가해서 
		/member/myInfo.son 으로 전송해서
		로그인한 회원의 정보를 출력하도록
		myInfo.jsp의 내용을 완성하세요.
		
		컨트롤러 함수는 myInfo()로 한다.
		
		단, 이페이지의 모든 작업은 jQuery로 처리하기로 한다.
		
		제출은 
			main.jsp
			myInfo.jsp
			Member.java
		파일을 제출하는 것으로 한다.
	
	*/

	/*  이 부분에 코드 작성 */
	$('#myList').click(function(){
		$(location).attr('href', '/member/myInfo.son');
	});
});
</script>
</head>
<form method="post" id="frm"></form>
<body>
<div class="w3-content mxw650 w3-center">
<c:if test="${not empty SID }">
	<h1 class="w3-pale-green w3-padding w3-card-4 w3-round-large">${SID} 메인</h1>
</c:if>
<c:if test="${empty SID}">
	<h1 class="w3-teal w3-padding w3-card-4 w3-round-large">son 메인</h1>
</c:if>
	<div class="w3-col mgt10">
<!-- 로그인에 성공하면 session에 SID 라는 속성으로 아이디를 기억시켜놓을 것이므로 -->
		<div class="inblock w3-left w3-btn w3-small w3-pale-red" id="gboard">방명록</div>
		<div class="inblock w3-left w3-btn w3-small w3-sand" id="fboard">파일게시판</div>
		
<c:if test="${not empty SID}">
		<div class="inblock w3-btn w3-small w3-right w3-pale-red" id="logout">로그아웃</div>
		<div class="inblock w3-btn w3-small w3-right w3-blue-gray" id="idList">회원목록</div>
		<div class="inblock w3-btn w3-small w3-right w3-gray" id="myList">내정보</div>
</c:if>
<c:if test="${empty SID}">
		<div class="inblock w3-right w3-btn w3-small w3-pale-green" id="join">회원가입</div>
		<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
</c:if>

	</div>
</div>
</body>