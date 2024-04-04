<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="/js/colorClass.js"></script>
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
		$('#idList').click(function(){
			$(location).attr('href', '/member/memberList.son');
		});
	});
	</script>
</head>
<body>
	<div class="w3-content mxw650 w3-center">
		<h1 class="w3-pale-green w3-padding w3-card-4 w3-round-large">파일게시판</h1>
		<div class="w3-col mgt10">
	<!-- 로그인에 성공하면 session에 SID 라는 속성으로 아이디를 기억시켜놓을 것이므로 -->
			<div class="inblock w3-left w3-btn w3-small w3-pale-red" id="gboard">방명록</div>
	<c:if test="${not empty SID}">
			<div class="inblock w3-btn w3-small w3-right w3-pale-red" id="logout">로그아웃</div>
			<div class="inblock w3-btn w3-small w3-right w3-blue-gray" id="idList">회원목록</div>
	</c:if>
	<c:if test="${empty SID}">
			<div class="inblock w3-right w3-btn w3-small w3-pale-green" id="join">회원가입</div>
			<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
	</c:if>
	
		</div>
	</div>
</html>