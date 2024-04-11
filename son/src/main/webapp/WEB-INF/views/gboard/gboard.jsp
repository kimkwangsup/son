<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>son</title>
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="/js/colorClass.js"></script>
<style type="text/css">
	p {
		margin: 0px!important
	}
	hr {
		margin:	3px!important 
	}
	#wmodal{
		display: none;
	}
	#msg{
		display: block;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		
		$('#login').click(function(){
			$(location).attr('href', '/member/login.son');
		});
		
		$('#logout').click(function(){
			$(location).attr('href', '/member/logoutProc.son');
		});
		$('#join').click(function(){
			$(location).attr('href', '/member/join.son');
		});
		$('#wbtn').click(function(){
			$('#wmodal').css('display', 'block');
		});
		$('#close, #cbtn').click(function(){
			document.frm.reset();
			$('#wmodal').css('display', 'none');
		});
		$('#mclose, #cmbtn').click(function(){
			$('#msg').css('display', 'none');
		});
		$('#write').click(function(){
			// 데이터 유효성검사
			
			var sid = $(document.frm.id).val();
			if(!sid || sid == 'null'){
				// 로그인이 안되어있는 경우
				// 로그인 페이지로 보낸다
				$(location).attr('href', '/member/login.son');
			}
			var body = $('#body').val();
			if(!body){
				// 내용 입력인 안된 상태
				alert('내용을 입력해주세요.');
				$('#body').focus();
				return;
			}
			$('#frm').submit();
		});
	});
</script>
</head>
<body style="background-color: gray">
	<div class="w3-content mxw600">
		<h1 class="w3-col w3-pale-green w3-center w3-padding w3-card-4 w3-round-large">son 방명록</h1>
		<div class="w3-col">
			<div class="w3-blue-gray w3-btn w3-left w3-small" id="home">처음화면</div>
<c:if test="${empty SID }"><!-- 로그인 안한 경우 -->
			<div class="w3-light-gray w3-btn w3-right w3-small" id="login">로그인</div>
			<div class="w3-light-blue w3-btn w3-right w3-small" id="join">회원가입</div>
</c:if>
<c:if test="${not empty SID }"><!-- 로그인한경우 -->
			<div class="w3-pale-red w3-btn w3-left w3-small" id="logout">로그아웃</div>
	<c:if test="${CNT ne 1}">
			<div class="w3-pale-blue w3-btn w3-right w3-small" id="wbtn">글작성</div>
	</c:if>
</c:if>
		</div>
		<div class="w3-col ">
<c:forEach var="DATA" items="${LIST }">
			<div class="w3-col w3-card-4 mgt10 w3-teal" style="padding: 7px;">
				<div class="w3-col" style="width: 110px; height: 100px; padding-right: 10px; border-right: 1px solid lightgrey">
					<img src="/image/avatar/${DATA.sname}" class="imgBox w3-left" >
				</div>
				<div class="w3-rest" style="padding-right: 10px;">
					<div class="w3-col">
						<p class="w3-half w3-left-align" style="padding-left:10px;"><strong>작성자 : ${DATA.id}</strong></p>
						<p class="w3-half w3-right-align">작성일 : ${DATA.sdate}</p>
					</div>
					<hr class="w3-col">
					<div class="w3-col w3-padding">
						<pre class="w3-small">${DATA.body}</pre>
					</div>
				</div>
			</div>
</c:forEach>
		</div>
	</div>
	<div id="wmodal" class="w3-modal">
		<form method="post" action="/gboard/gWriteProc.son" name="frm" id="frm" class="w3-modal-content mxw550">
			<input type="hidden" name="id" value="${SID}">
			<header class="w3-container w3-pale-green"> 
				<span class="w3-btn w3-display-topright" id="close">&times;</span>
				<h2 class="w3-center">방명록</h2>
			</header>
			<div class="w3-container w3-padding">
				<textarea name="body" id="body" class="w3-input w3-border" style="resize: none" placeholder="글을 작성하세요."></textarea>
			</div>
			<footer class="w3-col">
				<div class="w3-half w3-blue-gray w3-btn" id="write">작성</div>
				<div class="w3-half w3-light-gray w3-btn" id="cbtn">취소</div>
			</footer>
		</form>
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
	</div>
<c:if test="${not empty MSG}">
	<div id="msg" class="w3-modal">
		<div class="w3-modal-content mxw550">
<c:if test="${MSG eq 'OK'}">
			<header class="w3-container w3-pale-green"> 
</c:if>			
<c:if test="${MSG ne 'OK'}">
			<header class="w3-container w3-pale-red"> 
</c:if>			
				<span class="w3-btn w3-display-topright" id="mclose">&times;</span>
				<h2 class="w3-center">방명록 등록 결과</h2>
			</header>
			<div class="w3-container w3-padding">
				<h3 class="w3-center">
<c:if test="${MSG eq 'OK'}">
	방명록 등록에 성공했습니다.
</c:if>
<c:if test="${MSG ne 'OK'}">
	방명록 등록에 실패했습니다.
</c:if>
				</h3>
			</div>
			<footer class="w3-col">
				<div class="w3-col w3-dark-gray w3-btn" id="cmbtn">확인</div>
			</footer>
		</div>
	</div>
</c:if>
</body>
</html>