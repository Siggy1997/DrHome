<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<link rel="stylesheet" href="./css/qnaBoard.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<%@ include file="loginAlert.jsp"%>
<main>
	
	
<div class="freeContainer">

<!-- <h1>자유 게시판</h1> -->
<div class="backGroundBar">
	<div class="space">
<button class="writeButton" onclick="confirmWriteFree()">작성하기</button>
</div>
</div>

	<c:forEach items="${requestScope.freeList}" var="free">
		<a href="<c:url value='/freeDetail'>
    <c:param name='bno' value='${free.bno}' />
  </c:url>">
			<div class="freeList">
				<div class="space">
				<div class="title">${free.btitle}</div>
				<div class="fcontent">${free.bcontent}</div>
				<div class="bottomContainer">
				<div class="nickname">${free.mnickname}</div>
				<div class= "rightSide">
				<div class="xi-comment-o xi-x"></div>
				<div class="countComment">${free.comment_count}</div>
				<div class="xi-heart-o xi-x"></div>
				<div class="countCalldibs">${free.bcalldibsCount}</div>
				</div>

				</div>
				</div>
			</div>
			 <div class="line"></div>
		</a>
	</c:forEach>
	</div>
	
	<!-- 로그인 알림 -->
	<div class="dh-modal-wrapper">
		<div class="dh-modal-login">
			<div class="dh-modal-header">
				<img src="https://cdn-icons-png.flaticon.com/512/7960/7960597.png">
				<div class="dh-modal-body">
					<span class="h4">로그인 후에<br> 이용하실 수 있는 서비스입니다.</span>
					<span class="h6">닥터홈 로그인 후 많은 서비스를 경험해 보세요.</span>
				</div>
			</div>
			<div class="dh-modal-footer">
				<button class="dh-modal-button dh-close-modal">취소</button>
				<button class="dh-modal-button" onclick="location.href='/login'">로그인</button>
			</div>
		</div>
     </div>
	
	
	
	
	
	<div style="height: 9vh"></div>

	</main>

	<footer></footer>



</body>
<script>
	
    var maxLength = 30; // 최대 문자열 길이
    var contentElements = document.querySelectorAll(".content");


		if (text.length > maxLength) {
			var truncatedText = text.slice(0, maxLength) + "...";
			contentElement.textContent = truncatedText;
		}
	});

        if (text.length > maxLength) {
            var truncatedText = text.slice(0, maxLength) + "...";
            contentElement.textContent = truncatedText;
        }
    });
    
function confirmWriteFree() {
		
		const mno = "${mno}";

		if (mno === null || mno === undefined || mno === "") {
			$(".dh-modal-wrapper").show();
			
		} else {
			window.location.href = 'writeFree';
		}
	}
	

</script>

</html>