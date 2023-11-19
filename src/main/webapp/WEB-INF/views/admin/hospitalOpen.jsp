<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>hospitalOpen</title>
<link rel="stylesheet" href="../css/hospitalOpen.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="../js/jquery-3.7.0.min.js"></script>

<style type="text/css">
.dh-modal-wrapper {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 1499;
}

.dh-modal-body {
	width: 85%;
	background-color: white;
	display: flex;
	flex-direction: column;
	padding: 20px;
	align-items: center;
	border-radius: 8px;
	margin: 25px;
	z-index: 1500;
	height: 60%;
}

.swiper {
	width: 300px;
	height: 90%;
	z-index: 2000;
}
</style>



<script type="text/javascript">
	$(document)
			.ready(
					function() {
						let rhno = 0;

						$(document)
								.on(
										"click",
										".chkData",
										function() {
											rhno = $(this).children().first()
													.html();

											$
													.ajax({
														url : "./detail",
														type : "get",
														data : {
															"rhno" : rhno,
														},
														dataType : "json",
														success : function(data) {

															let hos = data.hospitalDetail;
															let doc = data.doctorDetail;

															$('#rhno').text(
																	hos.rhno);
															$('#rhname').text(
																	hos.rhname);
															$('#rhopendate')
																	.text(
																			hos.rhopendate);
															$('#rhaddr').text(
																	hos.rhaddr);
															$('#rhtelnumber')
																	.text(
																			hos.rhtelnumber);
															$('#rhinfo').text(
																	hos.rhinfo);
															$('#rhopentime')
																	.text(
																			hos.rhopentime);
															$('#rhclosetime')
																	.text(
																			hos.rhclosetime);
															$('#rhnightday')
																	.text(
																			hos.rhclosetime);
															$('#rhnightendtime')
																	.text(
																			hos.rhnightendtime);
															$('#rhbreaktime')
																	.text(
																			hos.rhbreaktime);
															$('#rhbreakendtime')
																	.text(
																			hos.rhbreakendtime);
															$('#rhholiday')
																	.text(
																			hos.rhholiday);
															$(
																	'#rhholidayendtime')
																	.text(
																			hos.rhholidayendtime);
															$('#rhparking')
																	.text(
																			hos.rhparking);
															$('#rhimg').text(
																	hos.rhimg);

															for (let i = 0; i < doc.length; i++) {
																let oneDoc = doc[i];
																let item = "<div class='swiper-slide'>";
																item += "<div class= 'detailTitle'>DOCTOR</div>";
																item += "<div>의사이름 : "
																		+ oneDoc.rdname
																		+ "</div>"
																item += "<div>소개 : "
																		+ oneDoc.rdinfo
																		+ "</div>"
																item += "<div>성별 : "
																		+ oneDoc.rdgender
																		+ "</div>"
																item += "<div>학력 : "
																		+ oneDoc.rdcareer
																		+ "</div>"
																item += "<div>전문의 : "
																		+ oneDoc.rdspecialist
																		+ "</div>"
																item += "<div>비대면 진료 여부 : "
																		+ oneDoc.rdtelehealth
																		+ "</div>"
																item += "<div>진료과 : "
																		+ oneDoc.dpno
																		+ "</div>"
																item += "<div>등록 병원 : "
																		+ oneDoc.rhno
																		+ "</div>"
																item += "<div>이미지 : "
																		+ oneDoc.rdimg
																		+ "</div>"
																item += "</div>"

																$(
																		'.swiper-wrapper')
																		.append(
																				item);
															}

															$(
																	'.dh-modal-wrapper')
																	.show();

														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$("#searchHos")
								.click(
										function() {
											$("#searchDiv").html("");
											searchN = $(
													"#searchN option:selected")
													.val();
											searchV = $("input[name=searchV]")
													.val();

											$
													.ajax({
														url : "./searchHos",
														type : "POST",
														data : {
															"searchN" : searchN,
															"searchV" : searchV,
														},
														dataType : "json",
														success : function(data) {
															let searchHos = data.searchHos;
															let tableMake = "";

															$("#searchTable")
																	.empty();

															for (let i = 0; i < searchHos.length; i++) {
																tableMake += "<div class='chkData' id='searchTable'>";
																tableMake += "<div>"
																		+ searchHos[i].rhno
																		+ "</div>";
																tableMake += "<div>"
																		+ searchHos[i].rhname
																		+ "</div>";
																tableMake += "<div>"
																		+ searchHos[i].rhaddr
																		+ "</div>";
																tableMake += "<div>"
																		+ searchHos[i].rhtelnumber;
																tableMake += "<span>"
																		+ searchHos[i].rhopendate
																		+ "</span></div>";
																tableMake += "<div class='graySeperate'></div></div>";
															}

															$("#searchDiv")
																	.append(
																			tableMake);

														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$(document).on("click", "#cancel", function() {
							rhno = $("#data-rhno").html();
							alert(rhno);

							if (confirm("삭제하시겠습니까?")) {
								$.ajax({
									url : "./deleteHos",
									type : "POST",
									data : {
										"rhno" : rhno,
									},
									dataType : "json",
									success : function(data) {
										location.reload();
									},
									error : function(error) {
										alert("잘못된 에러입니다.");
									}
								});
							} else {
								return false;
							}
						});
					});
</script>
</head>
<body>
	<header>

		<a href="/login"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">병원 등록 관리</div>
		<div id="blank"></div>

	</header>
	<main>
		<div class="grabSearch">
			<div class="searchTab">
				<select class="searchN" id="searchN" name="searchN">
					<option value="" selected="selected">전체</option>
					<option value="rhname">병원명</option>
					<option value="rhaddr">주소</option>
				</select> <input type="text" class="searchV" id="searchV" name="searchV"
					maxlength="10" />
				<button id="searchHos" type="button">검색</button>
			</div>
		</div>


		<div id="searchDiv">
			<c:forEach items="${hospitalOpen}" var="hospitalOpen">
				<div class="chkData" id="searchTable">
					<div>${hospitalOpen.rhno }</div>
					<div>${hospitalOpen.rhname }</div>
					<div>${hospitalOpen.rhaddr}</div>
					<div>${hospitalOpen.rhtelnumber}
						<span>${hospitalOpen.rhopendate}</span>
					</div>
					<div class="graySeperate"></div>
				</div>
			</c:forEach>
		</div>

		<!-- 모달 -->
		<div class="dh-modal-wrapper" style="display: none">
			<div class="dh-modal-body">
				<div class="swiper">

					<div class="swiper-wrapper">

						<div class="swiper-slide">
							<div class="detailTitle">HOSPITAL</div>

							<div>
								<div>번호</div>
								<div id="rhno">번호</div>
							</div>

							<div>
								<div>등록병원명</div>
								<div id="rhname">등록병원명</div>
							</div>

							<div>
								<div>개원일</div>
								<div id="rhopendate">개원일</div>
							</div>

							<div>
								<div>주소</div>
								<div id="rhaddr">주소</div>
							</div>

							<div>
								<div>전화번호</div>
								<div id="rhtelnumber">전화번호</div>
							</div>

							<div>
								<div>등록병원 소개</div>
								<div id="rhinfo">등록병원 소개</div>
							</div>

							<div>
								<div>시작시간</div>
								<div id="rhopentime">시작시간</div>
							</div>

							<div>
								<div>종료시간</div>
								<div id="rhclosetime">종료시간</div>
							</div>

							<div>
								<div>야간 진료요일</div>
								<div id="rhnightday">야간 진료요일</div>
							</div>

							<div>
								<div>야간 종료시간</div>
								<div id="rhnightendtime">야간 종료시간</div>
							</div>

							<div>
								<div>브레이크타임</div>
								<div id="rhbreaktime">브레이크타임</div>
							</div>

							<div>
								<div>브레이크 종료시간</div>
								<div id="rhbreakendtime">브레이크 종료시간</div>
							</div>

							<div>
								<div>공휴일 진료여부</div>
								<div id="rhholiday">공휴일 진료여부</div>
							</div>

							<div>
								<div>공휴일 종료시간</div>
								<div id="rhholidayendtime">공휴일 종료시간</div>
							</div>

							<div>
								<div>주차여부</div>
								<div id="rhparking">주차여부</div>
							</div>
							<div>
								<div>이미지</div>
								<div id="rhimg">이미지</div>
							</div>

						</div>


					</div>

					<div class="swiper-pagination"></div>



				</div>



			</div>
		</div>


		<div class="dh-modal-footer">
			<button class="dh-modal-button dh-close-modal">취소</button>
			<button class="dh-modal-button" onclick="location.href='/login'">로그인</button>
		</div>






		<form action="/admin/newHosDoc" method="POST">
			<input type="hidden" id="approve" name="rhno" value="" />
			<button type="submit" class="dhBtn" id="confirm">승인</button>
		</form>
		<button type="button" class="dhBtn" id="cancel">삭제</button>




		<div style="height: 9vh"></div>
	</main>
	<footer> </footer>

	<script type="text/javascript">
		//스와이퍼 시작
		const swiper = new Swiper('.swiper', {
			// Optional parameters
			direction : 'horizontal',
			loop : true,

			pagination : {
				el : '.swiper-pagination',
			},

		});
	</script>



</body>
</html>