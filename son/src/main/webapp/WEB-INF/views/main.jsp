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
	$('#sdata').click(function(){
		$(location).attr('href', '/survey/dataInit.son');
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
	$('#myInfo').click(function(){
		var el = document.createElement('input');
		$(el).attr('type', 'hidden');
		$(el).attr('name', 'id');
		$(el).val('${SID}');
		$('#frm').append(el);
		$('#frm').attr('action', '/member/myInfo.son');
		$('#frm').submit();
	});
	$('#survey').click(function(){
		$(location).attr('href', '/survey/surveyList.son');
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
			<div class="inblock w3-left w3-btn w3-small w3-pale-red" id="gboard">방명록</div>
			<div class="inblock w3-left w3-btn w3-small w3-sand" id="fboard">파일게시판</div>
	<c:if test="${not empty SID}">
			<div class="inblock w3-btn w3-small w3-right w3-pale-red" id="logout">로그아웃</div>
			<div class="inblock w3-btn w3-small w3-right w3-blue-gray" id="idList">회원목록</div>
			<div class="inblock w3-btn w3-small w3-right w3-gray" id="myInfo">내정보</div>
	</c:if>
	<c:if test="${not empty SID and SID eq 'ks'}">
		<c:if test="${empty SCNT or SCNT eq 0}">
				<div class="inblock w3-left w3-btn w3-small w3-brown" id="sdata">설문초기화</div>
		</c:if>
	</c:if>
	<c:if test="${INGCNT ne 0}">
			<div class="inblock w3-left w3-btn w3-small w3-light-green" id="survey">설문조사</div>
	</c:if>
	<c:if test="${empty SID}">
			<div class="inblock w3-right w3-btn w3-small w3-pale-green" id="join">회원가입</div>
			<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
	</c:if>
		</div>
	</div>
	<c:if test="${not empty param.RESULT}">
		<div id="wmodal" class="w3-modal">
			<div class="w3-modal-content mxw550">
				<header class="w3-container w3-pale-green"> 
					<span class="w3-btn w3-display-topright" id="close">&times;</span>
					<h2 class="w3-center">설문 데이터 초기화 완료</h2>
				</header>
				<div class="w3-container w3-padding">
					<h3 class="w3-center">
						<c:if test="${param.RESULT eq 'OK'}">설문 조사 데이터 초기화가 완료되었습니다.</c:if>				
						<c:if test="${param.RESULT eq 'NO'}">설문 조사 데이터 초기화에 실패하였습니다.</c:if>				
					</h3>
				</div>
				<footer class="w3-col">
					<div class="w3-col w3-light-gray w3-btn" id="cbtn">확인</div>
				</footer>
			</div>>
		</div>
		<script type="text/javascript" >
			$(document).ready(function(){
				$('#wmodal').css('display', 'block');
				// modal 클릭 이벤트
				$('#cbtn, #close').click(function(){
					$('#wmodal').css('display', 'none');
				});
			});
		</script>
	</c:if>
</body>