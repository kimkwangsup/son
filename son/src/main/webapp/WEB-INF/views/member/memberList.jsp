<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Member List</title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 아이디 버튼 클릭이벤트
		$('.idbtn').click(function(){
			// 아이디 읽고
			var sid = $(this).html(); // 일반태그이므로 html() 또는 text() 형태로 읽는다.
			
			// 읽을 데이터 서버로 보내고 
			// 보낸 아이디에 해당하는 회원의 조회 결과 받기
			$.ajax({
				url:'/member/memberInfo.son',
				type:'post',
				dataType:'json',
				data:{
					id: sid					
				},
				success: function(result){
					/*
						통신에 성공해서 데이터가 정상적으로 가져오는 경우 result는
						
						var result = {
							"id":"jennie",
							"name":"김제니",
							...
						};
						의 형태로 변수가 준비가 되기 때문에...
						
						var id = result.id;
					*/
					// 데이터 꺼내고
					var id = result.id;
					var name = result.name;
					var mail = result.mail;
					var tel = result.tel;
					var gen = (result.gen == 'F' ? '여자' : '남자');
					var jdate = result.sdate;
					var avatar = result.savename;
					
					// 태그에 데이터 채우고
					$('#avtBox').attr('src', '/avatar/' + avatar);
					$('#tid').html(id);
					$('#id').html(id);
					$('#name').html(name);
					$('#mail').html(mail);
					$('#tel').html(tel);
					$('#gen').html(gen);
					$('#jdate').html(jdate);
					
					// 창보이게처리
					$('#wmodal').css('display', 'block');
				},
				error: function(){
					alert('서버 통신 에러');
				}
			});
		});
		$('#cbtn, #close').click(function(){
			// 입력된 정보 지우고
			// membdata 클래스로 선택하기로 하자.
			$('#wmodal').css('display', 'none');
			$('.membdata').html('');
			$('#avtBox').attr('src', '');
		});
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		$('#logout').click(function(){
			$(location).attr('href','/member/logoutProc.son');
		});
	});
</script>
</head>
<body>
	<div class="w3-content mxw650 w3-center">
		<h1 class="w3-padding w3-pale-green w3-card-4 w3-round-large">회원리스트</h1>
		<div class="w3-col">
			<div class="w3-btn w3-small w3-pale-blue w3-card-4 w3-round-large w3-left" id="home">처음화면</div>		
			<div class="w3-btn w3-small w3-pale-red w3-card-4 w3-round-large w3-right" id="logout">로그아웃</div>		
		</div>
		<div class="w3-col w3-margin-top">
<c:forEach var="DATA" items="${LIST}" varStatus="st">
			<div class="w3-quarter idbtn w3-btn w3-round-large ${COLOR[st.index]}">${DATA}</div>
</c:forEach>
		</div>
	</div>
	<div id="wmodal" class="w3-modal">
		<div class="w3-modal-content mxw550">
			<input type="hidden" name="id" value="${SID}">
			<header class="w3-container w3-pale-green"> 
				<span class="w3-btn w3-display-topright" id="close">&times;</span>
				<h2 class="w3-center"><span id="tid membdata"></span>Info</h2>
			</header>
			<div class="w3-container w3-padding w3-pale-blue">
				<div class="w3-col w3-center">
					<img class="avtBox2 w3-border w3-border-gray w3-margin" id="avtBox">
				</div>
				<hr class="w3-col w3-margin">
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">이  름 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="name"></h3>
				</div>
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">아이디 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="id"></h3>
				</div>
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">메  일 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="mail"></h3>
				</div>
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">연락처 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="tel"></h3>
				</div>
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">성  별 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="gen"></h3>
				</div>
				<div class="w3-col">
					<h3 class="w3-col m3 pdr10 w3-text-gray w3-right-align">가입일 : </h3>
					<h3 class="w3-col m8 pdr10 membdata" id="jdate"></h3>
				</div>
			</div>
			<footer class="w3-col">
				<div class="w3-col w3-light-gray w3-btn" id="cbtn">확인</div>
			</footer>
		</div>
	</div>
</body>
</html>