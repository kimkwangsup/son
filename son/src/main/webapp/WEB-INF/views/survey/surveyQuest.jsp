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
		$('#join').click(function(){
			$(location).attr('href', '/member/join.son');
		});
		$('#sbtn').click(function(){
			var sano = $('input[type="radio"]:checked');
			for(var i = 0 ; i < sano.length ; i++){
				var sno = sano.eq(i).val();
				var el = document.createElement('input');
				$(el).attr('type', 'hidden').attr('name', 'qanos').val(sno);
				
				$('#frm').append(el);
			}
			$('#frm').attr('action', '/survey/surveyAnswer.son');
			//$('#frm').submit();
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
				<c:forEach var="SVO" items="${LIST}" varStatus="st1">
					<c:if test="${st1.index eq 0}">
						<script type="text/javascript">
							$(document).ready(function(){
								$('#frm').append('<input type="hidden" name="tpno" value="${SVO.tpno}">');
							});
						</script>
					</c:if>
					<div class="w3-col w3-padding w3-margin-bottom w3-light-gray w3-card-4 w3-left-align pdl50">
						<h4><li>${SVO.body}</li>
							<ol style="list-style-type: none; padding-left: 0px!important;">
								<c:forEach var="ANS" items="${SVO.bogis}" varStatus="st">
									<li>
										<input type="radio" name="${ANS.qupno}" value="${ANS.qno}" id="i${ANS.qno}">
										<label for="i${ANS.qno}" ><small>${st.index + 1}). ${ANS.body}</small></label>
									</li>
								</c:forEach>
							</ol>
						</h4>
					</div>
				</c:forEach>
			</ol>
		</div>
		<div class="w3-col w3-margin-top">
			<div class="w3-btn w3-gray w3-left w3-small" id="cancel">목록으로</div>
			<div class="w3-btn w3-blue-gray w3-right w3-small" id="sbtn">설문제출</div>
		</div> 
	</div>
</body>
</html>