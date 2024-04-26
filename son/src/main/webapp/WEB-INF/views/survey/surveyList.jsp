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
		$('#home').click(function(){
			$(location).attr('href','/main.son');
		});
		// ingSurvey 클릭이벤트
		$('.ingSurvey').click(function(){
			if(!confirm('설문에 참여하시겠습니까?')){
				return;
			}
			// 할일 
			// 1. 클릭된 설문의 설문번호 알아내고
			var sno = $(this).attr('id');
			
			// 설문번호를 폼태그에 채우고
			var el = document.createElement('input');
			$(el).attr('type', 'hidden').attr('name', 'tpno').val(sno);
			
			$('#frm').append(el);
			// $('#frm').append('<input type="hidden" name="tpno" value="' + sno +  '">');
			
			$('#frm').attr('action', '/survey/surveyQuest.son');
			
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<form method="post" id="frm"></form>
	<div class="w3-content mxw650 w3-center">
		<h1 class="w3-pale-green w3-padding w3-card-4 w3-round-large w3-btn w3-col" id="home">설문조사</h1>
		<div class="w3-col mgt10 w3-margin-bottom">
			<c:if test="${not empty SID}">
				<div class="inblock w3-btn w3-small w3-right w3-pale-red" id="logout">로그아웃</div>
				<c:if test="${SID eq 'ks'}">
					<div class="inblock w3-btn w3-small w3-left w3-pale-yellow" id="addSvy">설문입력</div>
				</c:if>
			</c:if>
			<c:if test="${empty SID}">
				<div class="inblock w3-right w3-btn w3-small w3-blue-gray" id="join">회원가입</div>
				<div class="inblock w3-right w3-btn w3-small w3-pale-blue" id="login">로그인</div>
			</c:if>
		</div>
		<div class="w3-col">
			<ol style="padding-left: 0px!important;">
				<c:forEach var="data" items="${LIST}">
					<c:if test="${empty SID}">
						<c:if test="${data.ing eq 'NO'}">
							<h4 class="w3-col w3-padding w3-margin-bottom w3-light-gray w3-card-4 w3-left-align pdl50"><li>${data.title}</li></h4>
						</c:if>
						<c:if test="${data.ing eq 'OK'}">
							<h4 class="w3-col w3-padding w3-margin-bottom w3-light-blue w3-card-4 w3-left-align pdl50"><li>${data.title}</li></h4>
						</c:if>
					</c:if>
					<c:if test="${not empty SID}">
						<c:if test="${data.cnt eq 0}"><!-- 문항등록 안된 경우 -->
							<c:if test="${data.ing eq 'NO'}">
								<h4 class="w3-col w3-margin-bottom w3-light-gray w3-card-4 w3-left-align w3-padding pdl50" id="${data.tpno}"><li>${data.title}</li></h4>
							</c:if>
							<c:if test="${data.ing eq 'OK'}">
								<h4 class="w3-col w3-margin-bottom w3-light-blue w3-card-4 w3-left-align w3-padding pdl50" id="${data.tpno}">
									<c:if test="${SID eq 'ks'}">
										<script type="text/javascript">
											$(function(){
												$('.setSvy').click(function(){
													// 클릭된 태그의 아이디 읽어서 설문주제번호 꺼내오고
													var sno = $(this).attr('id').substring(1);
													$('#frm').append('<input type="hidden" name="tpno" value="' + sno + '">');
													$('#frm').attr('action', '/survey/addSurvey.son');
													$('#frm').submit();
												});
											});
										</script>
										<li class="w3-col m10">${data.title}</li>
										<div class="w3-col m2 w3-btn w3-small w3-brown setSvy" id="s${data.tpno}">문항등록</div>
									</c:if>
									<c:if test="${SID ne 'ks'}">
										<li class="w3-col">${data.title}</li>
									</c:if>
								</h4>
							</c:if>
						</c:if>
						<c:if test="${data.cnt ne 0}"><!-- 문항등록된 경우 -->
							<c:if test="${data.ing eq 'NO'}">
								<h4 class="w3-col w3-btn w3-margin-bottom w3-light-gray w3-card-4 resultSurvey w3-left-align w3-padding pdl50" id="${data.tpno}"><li>${data.title}</li></h4>
							</c:if>
							<c:if test="${data.ing eq 'OK'}">
								<h4 class="w3-col w3-btn w3-margin-bottom w3-light-blue w3-card-4 ingSurvey w3-left-align w3-padding pdl50" id="${data.tpno}"><li>${data.title}</li></h4>
							</c:if>
						</c:if>
					</c:if>
				</c:forEach>
			</ol>
		</div>
	</div>
</body>
</html>