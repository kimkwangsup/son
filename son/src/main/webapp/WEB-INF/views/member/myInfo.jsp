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
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		$('#logout').click(function(){
			$(location).attr('href', '/member/logoutProc.son');
		});
		$('#edit').click(function(){
			$(location).attr('href', '/member/myInfoEdit.son');
		});
		
		$('#avtBox').attr('src', '/avatar/${DATA.savename}');
		$('#name').html("${DATA.name}");
		$('#id').html("${DATA.id}");
		$('#mail').html("${DATA.mail}");
		$('#tel').html("${DATA.tel}");
		$('#gen').html("${DATA.gen}");
		$('#jdate').html("${DATA.sdate}");
		$('.membdata').addClass("w3-border-bottom");
	});
</script>
</head>
<body>
	<div class="w3-content mxw650 w3-center">
<c:if test="${not empty SID}">
		<h1 class="w3-col w3-padding w3-pale-green w3-card-4 w3-btn" id="home">${DATA.id} 정보 페이지</h1>
</c:if>
		<div class="w3-col">
			<div class="w3-btn w3-small w3-pale-red w3-right" id="logout">로그아웃</div>
			<div class="w3-btn w3-small w3-sand w3-left" id="edit">내정보수정</div>
		</div>
		<hr class="w3-col w3-margin">
		<div class="w3-col w3-center">
			<div class="w3-content mxw550" >
				<header class="w3-container w3-pale-blue w3-center"> 
					<span class="w3-btn w3-display-topright" id="close">&times;</span>
					<h2><span id="tid membdata"></span>내정보</h2>
				</header>
				<div class="w3-container w3-padding">
					<div class="w3-col w3-center">
						<img class="avtBox2 w3-border w3-border-gray w3-margin" id="avtBox">
					</div>
					<hr class="w3-col w3-margin-top w3-margin-bottom">
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">이 름 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="name"></h3>
					</div>
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">아이디 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="id"></h3>
					</div>
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">메 일 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="mail"></h3>
					</div>
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">연락처 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="tel"></h3>
					</div>
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">성 별 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="gen"></h3>
					</div>
					<div class="w3-col">
						<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">가입일 : </h3>
						<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="jdate"></h3>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>