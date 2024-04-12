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
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
	});
</script>
</head>
<body>
	<div class="w3-content mxw700">
		<h1 class="w3-col w3-padding w3-center w3-pale-green w3-card-4 w3-round-large w3-btn" id="home">게시글 수정</h1>
		
		<form method="POST" action="/fboard/writeProc.son" name="frm" id="frm"
			 		class="w3-col w3-padding w3-card-4 w3-light-grey">
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-user"></span>작성자 : 
				</label>
		    	<div class="w3-rest mgt20">
		    		<input type="text" name="id" id="id" readonly 
		    			class="w3-input w3-left-align w3-text-blue-gray w3-border w3-border-bottom" value="${SID}" >
		    	</div>
			</div>
			<div class="w3-row w3-section w3-padding">
				<label for="title" class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-tag"></span>글제목 : 
				</label>
		    	<div class="w3-rest mgt20">
		    		<input type="text" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom" name="title" id="title" value="${DATA.title}">
		    	</div>
			</div>
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-file-image-o"></span>첨부파일 :
				</label>
		    	<div class="w3-rest mgt20">
		    		<div class="w3-col"  id="fileBox">
			    		<input type="file" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom" id="file1" name="file">
		    		</div>
		    		<div class="w3-col w3-rest w3-center w3-left-align pdl10" id="files">
<c:forEach var="IMG" items="${LIST}">
						<img src="${IMG.dir}${IMG.savename}" width="200" height="auto" class="w3-btn">
</c:forEach>
					</div>
		    	</div>
			</div>
			 
			
			
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-file-image-o"></span>글내용 :
				</label>
		    	<div class="w3-rest w3-text-blue-gray w3-border mgt20">
		    		<textarea name="body" id="body" placeholder="글 내용을 작성하세요." class="w3-input" style="resize: none;" rows=10>${DATA.body}</textarea>
				</div>
			</div>
		</form>
			
			
		<div class="w3-col">
			<div class="w3-third w3-btn w3-section w3-pale-red w3-ripple" id="home">글삭제</div>
			<div class="w3-third w3-btn w3-section w3-pale-green w3-ripple" id="list">글목록</div>
			<div class="w3-third w3-btn w3-section w3-pale-blue w3-ripple" id="submit">글등록</div>
		</div>
	</div>
</body>
</html>