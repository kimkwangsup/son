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
		var fno = 1;
		function getFno(){
			fno += 1;
			return fno;
		}
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
			
		
		
		
		/* 1. 비동기 통신으로 처리하는 방법
		$('.imgBtn').click(function(){
			// 삭제처리 확인
			var bool1 = confirm('삭 제할 까요?');
			if(!bool1){
				return;
			}
			// 클릭된 이미지의 파일번호 꺼내오기
			var sfno = $(this).attr('id').substring(3);
			// 비동기통신
			$.ajax({
				url: '/fboard/fboardDelImg.son',
				type: 'post',
				dataType: 'json',
				data: {
					fno: sfno
				},
				success: function(obj){
					var result = obj.result;
					if(result == "OK"){
						// 삭제처리에 성공한 경우
						// 삭제를 요청한 태그를 화면에서 삭제한다.
						$('#img' + sfno).remove();
					}else{
						// 실패한 경우
					}
				},
				error: function(){
					alert("서버 통신 에러");
				}
			});
		});
		*/
		$('.imgBtn').click(function(){
			if(confirm('이미지를 삭제할까요?')){
				// 삭제 확인을 클릭한 경우
				// 할일
				// 1. 클릭된 이미지 번호를 읽어야한다
				var imgno = $(this).attr('id').substring(3);
				// 중복처리
				var inolist = $(document.imgFrm.imgnos);
				for(var i = 0 ; i < inolist.length ; i++){
					if(inolist.eq(i).val() == imgno){
						alert('중복선택');
						return;
					}
				}				
				
				// $('#imgFrm').append('<input type="hidden" name="imgnos" id="del' + imgno + '" value="' + imgno + '">'); 
				var el = document.createElement('input');
				$(el).attr('type', 'hidden');
				$(el).attr('id', 'del' + imgno);
				$(el).attr('name', 'imgnos');
				$(el).val(imgno);
				
				$('#imgFrm').append(el);
				
				var qt = $(document.imgFrm.imgnos).length;
				$('#qt').html(qt);
				if(qt != 0){
					$('#delfiles').removeClass('w3-hide');
				}
			}
		});
		$('#delImgBtn').click(function(){
			$('#imgFrm').submit();
		});
		$('#list').click(function(){
			$('#imgFrm').attr('action', '/fboard/fileboard.son');
			$('#imgFrm').submit();
		});
		
		$('#fileBox').on('change', document.frm.file, function(evt){
			var filename = evt.target.value;
			var tid = evt.target.id;
			var first_id = $('#fileBox > input').first().attr('id');
			var old_no = tid.substring(3);
			// 선택된 이미지 URL 꺼내기
			if(!filename){
				if(tid != ('file' + first_id)){
					$('#' + tid).remove();
					$('#imgFr' + old_no).remove();
				}
			}else{
				var imgPath = URL.createObjectURL(evt.target.files[0]);
				if(tid == first_id){
					// 마지막 태그에서 파일을 선택하는 경우
					var tno = getFno();
					var el1 = document.createElement('input');
					$(el1).attr('type', 'file');
					$(el1).attr('id', 'file' + tno);
					$(el1).attr('name', 'file');
					$(el1).addClass('w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom mgt10');
					$('#fileBox').prepend(el1);
					
					
					var imgEl = document.createElement('img');
					$(imgEl).attr('id', 'img' + old_no);
					$(imgEl).attr('width', '100');
					$(imgEl).attr('height', 'auto');
					$(imgEl).attr('src', imgPath);
					
					
					var imgFr = document.createElement('div');
					$(imgFr).addClass('imgBox100 w3-border inblock mgw10 w3-margin-top');
					$(imgFr).append(imgEl);
					$(imgFr).attr('id', 'imgFr' + old_no);
					$('#imgBox').append(imgFr);
				}else{
					// 마지막이 아닌 태그들이 변경되는 경우
					$('#img' + old_no).attr('src', imgPath);
				}
			}
		});
		$('#edit').click(function(){
			var oldTitle = $('#oldTitle').val();
			var oldBody = $('#oldBody').val();
			
			var newTitle = $('#title').val();
			var newBody = $('#body').val();
			
			if(newTitle == oldTitle){
				$('#title').prop('disabled', true);
			}
			if(newBody == oldBody){
				$('#body').prop('disabled', true);
			}
			$('[type="file"]').first().prop('disabled', true);
			
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<div class="w3-hide">
		<input type="hidden" id="oldTitle" value="${DATA.title}">
		<textarea id="oldBody">${DATA.body}</textarea>
	</div>
	<!-- 이미지 번호 전송용 폼태그 -->
	<form method="post" action="/fboard/delImgList.son" name="imgFrm" id="imgFrm">
		<input type="hidden" name="bno" value="${DATA.bno}">
		<input type="hidden" name="nowPage" value="${nowPage}">
	</form>
	<div class="w3-content mxw700">
		<h1 class="w3-col w3-padding w3-center w3-pale-green w3-card-4 w3-round-large w3-btn" id="home">게시글 수정</h1>
		
		<form method="POST" action="/fboard/editProc.son" name="frm" id="frm" class="w3-col w3-padding w3-card-4 w3-light-grey" enctype="multipart/form-data">
				<input type="hidden" name="bno" value="${DATA.bno}">
				<input type="hidden" name="nowPage" value="${nowPage}">
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
		    	<div class="w3-col w3-margin w3-center" id="imgBox"></div>
		    		<div class="w3-col" id="fileBox">
			    		<input type="file" class="w3-input w3-center w3-text-blue-gray w3-border w3-border-bottom mgt10" id="file1" name="file">
		    		</div>
		    		<div class="w3-col w3-rest w3-center w3-left-align pdl10" id="files">
<c:forEach var="IMG" items="${LIST}">
						<div class="inblock w3-border imgBox100 mgw10 w3-margin-top w3-btn imgBtn"  id="img${IMG.fno}">
							<img src="${IMG.dir}${IMG.savename}" width="100" height="auto"">
						</div>
</c:forEach>
					</div>
					<div class="w3-col w3-hide" id="delfiles">
						<div class="w3-col w3-btn w3-blue-gray" id="delImgBtn"><span id="qt"></span> 개 이미지 삭제</div> 
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
			<div class="w3-third w3-btn w3-section w3-pale-blue w3-ripple" id="edit">글등록</div>
		</div>
	</div>
</body>
</html>