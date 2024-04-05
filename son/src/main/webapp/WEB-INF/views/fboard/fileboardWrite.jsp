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
<style type="text/css">

</style>
<script type="text/javascript">
	var fno = 1;
	function getFno(){
		fno += 1;
		return fno;
	}
	
	$(document).ready(function(){
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		$('#list').click(function(){
			$(location).attr('href', '/fboard/fileboard.son');
		});
		
		$(document.frm.file).change(function(){
			
			var sfile = $(this).val();
			if(sfile){
				var tno = getFno();
					$('#fileBox').append('<input type="file" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom" id="file' + tno + '" name="file">');
					$('#file'+tno).change()
			}
		});
		
		$('#write').click(function(){
			var sid = $('#id').val();
			var title = $('#title').val();
			var body = $('#body').val();
			if(!sid){
				$('#id').focus();
				return;
			}
			if(!body){
				$('#body').focus();
				return;
			}
			if(!title){
				$('#title').focus();
				return;
			}
			var file = $(document.frm.file).val();
			for(var i = 0 ; i < file.length ; i++){
				if(!file){
					$(document.frm.file).eq(i).prop('disabled', 'true');
				}
			}
			$('#frm').submit();
		});
		
		
	});
</script>
</head>
<body class="w3-sand">
	<div class="w3-content mxw700">
		<h1 class="w3-padding w3-center w3-pale-green w3-card-4 w3-round-large">게시글 작성</h1>
		
		<form method="POST" action="/fboard/writeProc.son" name="frm" id="frm"
			 		class="w3-col w3-padding w3-card-4 w3-light-grey" encType="multipart/form-data">
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-user"></span>작성자 : 
				</label>
		    	<div class="w3-rest mgt10">
		    		<input type="text" name="id" id="id" readonly 
		    			class="w3-input w3-left-align w3-text-blue-gray w3-border w3-border-bottom" value="${SID}" >
		    	</div>
			</div>
			<div class="w3-row w3-section w3-padding">
				<label for="title" class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-tag"></span>글제목 : 
				</label>
		    	<div class="w3-rest mgt10">
		    		<input type="text" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom" name="title" id="title">
		    	</div>
			</div>
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-file-image-o"></span>첨부파일 :
				</label>
		    	<div class="w3-rest mgt10" id="fileBox">
		    		<input type="file" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom" id="file1" name="file">
		    	</div>
			</div>
			 
			
			
			<div class="w3-row w3-section w3-padding">
				<label class="w3-col w3-right-align lbl" style="width: 150px;">
					<span class="w3-xxlarge fa fa-file-image-o"></span>글내용 :
				</label>
		    	<div class="w3-rest w3-text-blue-gray w3-border">
		    		<textarea name="body" id="body" placeholder="글 내용을 작성하세요." class="w3-input" style="resize: none;" rows=10></textarea>
				</div>
			</div>
		</form>
			
			
		<div class="w3-col">
			<div class="w3-third w3-btn w3-section w3-pale-green w3-ripple" id="home">Home</div>
			<div class="w3-third w3-btn w3-section w3-pale-red w3-ripple" id="list">글목록</div>
			<div class="w3-third w3-btn w3-section w3-pale-blue w3-ripple" id="write">글등록</div>
		</div>
	</div>
</body>
</html>