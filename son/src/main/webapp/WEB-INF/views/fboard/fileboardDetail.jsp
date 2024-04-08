<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="/js/colorClass.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		$('#list').click(function(){
			// frm 의 action 값을 변경
			$('#frm').attr('action', '/fboard/fileboard.son');
			// 글 번호는 리스트 뷰에서 필요 없으므로 전송하지 않게 처리
			$('#bno').prop('disabled', true);
			// 폼태그 전송
			$('#frm').submit();
		});
		$('#edit').click(function(){
			$('#frm').submit();
		});
		
	});
</script>
</head>
<body>
	<form method="post" action="/fboard/fileboardEdit.son" name="frm" id="frm">
		<input type="hidden" name="bno" id="bno" value="${DATA.bno}">
		<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}">
	</form>
	<div class="w3-content mxw650 w3-center">
		<h1 class="w3-col w3-teal w3-padding w3-card-4 w3-round-large w3-btn" id="home">게시글 상세보기</h1>
		<div class="w3-col w3-margin-top w3-card-4 w3-light-grey w3-text-blue-gray">
			<div class="w3-content w3-padding ">
				<h2 class="w3-center w3-pale-red" id="title">${DATA.title}</h2>
				
				<div class="w3-col">
					<h4 class="w3-col inblock w3-right-align" style="width: 150px"><span class="w3-xlarge fa fa-user"></span> 작성자 : </h4>
					<h4 class="w3-rest w3-left-align pdl10" id="writer">${DATA.id }</h4>
				</div>
				<div class="w3-col">
					<h4 class="w3-col inblock w3-right-align" style="width: 150px"><span class="w3-xlarge fa fa-calendar-o"></span> 작성일 : </h4>
					<h4 class="w3-rest w3-left-align pdl10" id="wdate">${DATA.sdate }</h4>
				</div>
				<div class="w3-col">
					<h4 class="w3-col inblock w3-right-align" style="width: 150px"><span class="w3-xlarge fa fa-file-image-o"></span> 첨부파일 : </h4>
					<div class="w3-rest w3-left-align pdl10" id="files">
<c:forEach var="IMG" items="${LIST}">
						<img src="/upload/${IMG}" width="100" height="auto">
</c:forEach>
					</div>
				</div>
				<div class="w3-col">
					<h4 class="w3-col inblock w3-right-align" style="width: 150px"><span class="w3-xlarge fa fa-calendar-o"></span> 글내용 : </h4>
					<pre class="w3-rest w3-left-align pdl10" id="body">${DATA.body}</pre>
				</div>
			</div>	
		</div>
	<div class="w3-col">
<c:if test="${not empty DATA}">
	<c:if test="${SID eq DATA.id}">
			<div class="w3-half w3-btn w3-section w3-pale-blue w3-ripple" id="list">글목록</div>
			<div class="w3-half w3-btn w3-section w3-pale-red w3-ripple" id="edit">글수정</div>
	</c:if>
</c:if>
<c:if test="${empty DATA or empty SID or (SID ne DATA.id)}">
			<div class="w3-col w3-btn w3-section w3-pale-green w3-ripple" id="list">글목록</div>
</c:if>
	</div>
</div>
</body>
</html>