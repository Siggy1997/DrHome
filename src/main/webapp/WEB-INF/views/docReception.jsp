<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>DocReception</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="/css/docReception.css">
<script src="/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		//enter눌러도 메세지 보내기
		$('#mname').keyup(function(a) {
			if (a.keyCode === 13) {
				send();
			}
		});
		
		//버튼 눌러도 메세지 보내기
		$('.xi-search').click(function() {
			send();
		});
		
		function send(){
			let mname =$('#mname').val();
			let form = $('<form></form>');
			form.attr("action","/docReception/${sessionScope.mno}/${sessionScope.dno}");
			form.attr("method", "get");
			form.append($("<input>",{type:'hidden', name:"mname", value:mname}));
			form.appendTo("body");
			form.submit();
		}
		

		$("#allCheck").click(function() {
			if ($("#allCheck").is(":checked"))
				$("input[name=check]").prop("checked", true);
			else
				$("input[name=check]").prop("checked", false);
		});

	});

	function cancel() {
		let row = [];

		$("input[name=check]:checked").each(function() {
			let tno = $(this).closest('.tr').find('.td#tno').text();
			let tstatus = $(this).closest('.tr').find('.td#tstatus').text();
			
			if(tstatus == "진료완료") {
				alert("처리완료된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else if(tstatus == "진료취소") {
				alert("취소된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else {
				row.push(tno);
			    if (row.length > 0) {
			        $.ajax({
			            url: "/updateRows", // 서버의 URL을 입력하세요.
			            type: "post",
			            data: { "row" : row },
			            dataType: "json",
			            success: function (data) {
			                alert("진료가 취소되었습니다.");
			                $("input[name=check]:checked").prop("checked", false);
			                location.href="/docReception/"+${sessionScope.mno}+"/"+${sessionScope.dno};
			            },
			            error: function (error) {
			                alert("진료 취소 중 오류가 발생했습니다.");
			            }
			        });//ajax끝
			        
			    }//행 1개 이상 선택
			    else {
			        alert("진료취소할 행을 선택해주세요.");
			    }//행 1개 이상 선택x else
			}
			
		});
	}
	
	function progress() {
		let count = $("input[name=check]:checked");
		
		if(count.length == 0){
	    	alert("진료 처리할 행을 선택해주세요.");
	    	return false;
		}
		
		if(count.length > 1){
	    	alert("진료 처리는 하나만 가능합니다.");
	    	$("input[name=check]:checked").prop("checked", false);
	    	$("input[name=allCheck]:checked").prop("checked", false);
	    	return false;
		}
		
		$("input[name=check]:checked").each(function() {
			let tno = $(this).closest('.tr').find('.td#tno').text();
			let tstatus = $(this).closest('.tr').find('.td#tstatus').text();
			
			if(tstatus == "진료완료") {
				alert("처리완료된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else if(tstatus == "진료취소") {
				alert("취소된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else {
				location.href="/docReceptionDetail/"+${sessionScope.mno}+"/"+${sessionScope.dno}+"?tno="+tno;
			}
			
		});
	}
	

</script>

</head>
<body>
	<header>
		<a href="/main"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">${docMainDetail.hname}</div>
		<div class="blank"></div>
	</header>
		
		<main>
			<div class="subMenu">
				<ul>
					<li>접수내역</li>
				</ul>
			</div>
			<div class="title">실시간 비대면 접수내역</div>
			
			<div class="todayInfo">
				<div class="today todayTimeInfo">
	            <div class="dayTitle">오늘</div>
	            <c:if test="${!(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && now.dayOfWeek != hospital.hnightday}">
	                <span class="openTime">${hospital.hopentime }</span> ~
	         		<span class="closeTime">${hospital.hclosetime }</span>
	            </c:if>
	
	            <c:if test="${now.dayOfWeek == hospital.hnightday}">
	               <span class="openTime">${hospital.hopentime }</span> ~ 
	         		<span class="closeTime">${hospital.hnightendtime }</span>
	            </c:if>
	
	            <c:if test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday !=0}">
	               <span class="openTime">${hospital.hopentime }</span> ~
	         	   <span class="closeTime">${hospital.hholidayendtime }</span>
	            </c:if>
	
	            <c:if test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
	               <span>휴진</span>
	            </c:if>
	           </div>
	         
		    	<div class="today todayBreakInfo">
		               <div class="dayTitle">점심시간</div>
		               <span id="todayBreak"> <c:if test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
		                  휴진
		               </c:if> <c:if test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==1}">
		                  없음
		               </c:if> <c:if test="${now.dayOfWeek == '월요일' || now.dayOfWeek == '화요일' || now.dayOfWeek == '수요일' || now.dayOfWeek == '목요일' || now.dayOfWeek == '금요일'}">
		            		${hospital.hbreaktime } ~ ${hospital.hbreakendtime }
		               </c:if>
		               </span>
		        </div>
           </div>
           
	        <div id="mainSearch">
				<i class="xi-search xi-x"></i><input id="mname" name="mname" placeholder="환자명을 입력하세요.">
		    </div>
	    
    <div class="table-area">        
		<div class="table">
			<div class="table-head">
				<div class="tr">
					<div class="check-td"><input type="checkbox" id="allCheck" name="allCheck"></div>
					<div class="th" style="display: none;">번호</div>
					<div class="th">환자명</div>
					<div class="th">신청과</div>
					<div class="th">증상</div>
					<div class="th" id="tstatus">대기상태</div>
				</div>
			</div>
			<div class="table-body">
				<c:forEach items="${searchMname}" var="row">
					<div class="tr">
						<div class="check-td" id="checkboxDetail"><input type="checkbox" name="check" class="check"></div>
						<div class="td" style="display: none;" id="tno">${row.tno}</div>
						<div class="td" id="mname">${row.mname}</div>
						<div class="td" id="dpkind">${row.dpkind}</div>
						<div class="td" id="tsymptomdetail">${row.tsymptomdetail}</div>
						<c:choose>
						<c:when test="${row.tstatus eq 0}">
							<div class="td" id="tstatus">진료대기</div>
						</c:when>
						<c:when test="${row.tstatus eq 1}">
							<div class="td" style="color: blue" id="tstatus">진료완료</div>
						</c:when>
						<c:otherwise>
							<div class="td" style="color: red" class="tstatus" id="tstatus">진료취소</div>
						</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div class="graySeperate"></div>
	
	<div class="dpCount-area">
		<div class="title" id="dpCount">진료과목</div>
		<span class="subtitle">${dpCount}개</span>
	</div>
	
		<c:forEach items="${dpKind}" var="row">
		<div class="dpname-area">
			<div class="dpname">
				<img src="/img/dp${row.dpno}.png">
				<div class="comment">${row.dpkind}</div>
			</div>
		</div>
		</c:forEach>
		
	</main>
	
	<footer>
		<button type="button" id="cancel" onclick="cancel()">진료취소</button>
		<button type="button" id="progress" onclick="progress()">진료처리</button>
	</footer>
</body>
</html>