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
			$(location).attr('href', '/member/logout.son');
		});
		
		$('#join').click(function(){
			$(location).attr('href', '/member/join.son');
		});
		
		// reset 버튼 클릭이벤트
		$('#reset').click(function(){
			$('#body').val('');
		});
		$('#list').click(function(){
			$('#frm').submit();
		});
		$('#write').click(function(){
			var sbody = $('#body').val();
			if(!sbody){
				$('#body').focus();
				return;
			}
			
			var el = document.createElement('input');
			$(el).attr('type', 'hidden');
			$(el).attr('name', 'body');
			$(el).val(sbody);
			$('#frm').append(el);
			$('#frm').attr('action', '/gboard/gWriteProc2.son');
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<form method="post" action="/gboard/gboard.son" id="frm">
		<input type="hidden" name="nowPage" id="nowPage" value="${nowPage}">
		<input type="hidden" name="id" value="${SID}">
	</form>
	
	<div class="w3-content mxw600">
		<h1 class="w3-col w3-pale-green w3-center w3-padding w3-card-4 w3-round-large w3-btn" id="home"> 방명록 작성</h1>
		<div class="w3-col">
<c:if test="${empty SID }"><!-- 로그인 안한 경우 -->
			<div class="w3-light-gray w3-btn w3-right w3-small" id="login">로그인</div>
			<div class="w3-light-blue w3-btn w3-right w3-small" id="join">회원가입</div>
</c:if>
<c:if test="${not empty SID }"><!-- 로그인한경우 -->
			<div class="w3-pale-red w3-btn w3-right w3-small" id="logout">로그아웃</div>
</c:if>
		</div>
		<div class="w3-col w3-margin-top" >
			<div class="w3-container w3-padding w3-margin-bottom w3-card-4" style="padding: 15px 20px!important;">
				<textarea name="body" id="body" class="w3-input w3-border" rows="5" style="resize: none;" placeholder="인사글을 작성하세요!"></textarea>
			</div>
			<footer class="w3-col w3-margin-top">
				<div class="w3-third w3-light-gray w3-btn" id="reset">초기화</div>
				<div class="w3-third w3-gray w3-btn" id="list">목록</div>
				<div class="w3-third w3-blue-gray w3-btn" id="write">작성</div>
			</footer>
		</div>
	</div>
</body>
</html>