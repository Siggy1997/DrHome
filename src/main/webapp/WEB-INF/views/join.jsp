
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
<title>Join</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="./css/aram.css" rel="stylesheet" />
<link href="./css/join.css" rel="stylesheet" />
<link href="/css/modal.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">

$(function(){
	
    $("#joinMemberBtn").click(function(){
    	let mid = $("#mid").val();
    	
        let isIdDuplicated = mid === "";
        
        if (isIdDuplicated) {
            $("#dh-modal-alert").addClass("active").fadeIn();
            setTimeout(function() {
                $("#dh-modal-alert").fadeOut(function(){
                    $(this).removeClass("active");
                });
            }, 1000);
            $("#joinMemberBtn").attr('disabled', true);
        } 
    });
	
	   $("#midCheck").click(function(){
		   		
			$("#idInfo").text("");	
		   		
		      let mid = $("#mid").val();
		      let special = /[^a-zA-Z0-9가-힣]/; //특수문자 확인
		      
		      if (mid == "") {
		         $("#mid").focus();
		         $("#idInfo").text("아이디를 입력해주세요.");
		         $("#idInfo").css("color", "red");
		         return false;
		      }
		      
		      if (mid.length < 4) {
			         $("#mid").focus();
			         $("#idInfo").text("아이디를 4글자 이상 입력해주세요.");
			         $("#idInfo").css("color", "red");
			         return false;
			      }
		      
			  if (special.test(mid)) {
			        $("#idInfo").text("아이디에 특수문자는 허용되지 않습니다.");
			        $("#idInfo").css("color", "red");
			        return false;
			  }
			  
		  //ajax 
	      $.ajax({
	          url:"./midCheck",
	          type:"post",
	          data:{"mid":mid},
	          dataType:"json",
	          success:function(data){
	             if(data.midCheck==1){
	                $("#idInfo").text("중복된 아이디입니다. 다시 입력해주세요.");
	                $("#idInfo").css("color","red");
	                $("#joinMemberBtn").attr('disabled', true);
	             } 
	             else{
	                $("#idInfo").text("사용가능한 아이디입니다.");
	                $('#joinMemberBtn').attr('disabled', false);
	                $("#idInfo").css("color","green");
	             }
	          },
	          error:function(request, status, error){
	             $("#idInfo").text("오류가 발생함")
	          }
	       });//ajax끝
		      
		   }); //midCheck아이디체크
		   
		  	//중복확인
		  	$("#mpwDuplication").on("blur", function() {
		  		
     			let mpw = $("#mpw").val();
    			let mpwDuplication = $("#mpwDuplication").val();
				
				if(mpw != mpwDuplication) {
    		           $("#pwInfo2").text("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
    		           $("#pwInfo2").css("color", "red");
    		           return false;
				} 
		        $("#pwInfo2").text("비밀번호가 일치합니다.");
		        $("#pwInfo2").css("color", "green");
				
				});  //비밀번호 중복확인 
		   
		   $("#joinMemberBtn").click(function(){
			   event.preventDefault(); //폼 전송 막기
			   
				let mid = $("#mid").val();
				let mrrn = $("#firstMrrn").val() + "-" + $("#lastMrrn").val();
				
				$("#idInfo").text("");
				$("#pwInfo").text("");
				$("#pwInfo2").text("");
				$("#nameInfo").text("");
				$("#mrrnInfo").text("");
				$("#mrrnInfo2").text("");
				$("#mrrnInfo3").text("");
				$("#emailInfo").text("");
				$("#homeAddrInfo").text("");
				$("#birthInfo").text("");
				$("#phoneInfo").text("");
				$("#joinInfo").text("");
			   
			      $.ajax({
			          url:"./midCheck",
			          type:"post",
			          data:{"mid":mid},
			          dataType:"json",
			          success:function(data){
			             if(data.midCheck==1){
			                $("#idInfo").text("중복된 아이디입니다. 다시 입력해주세요.");
			                $("#idInfo").css("color","red");
			                $("#joinMemberBtn").attr('disabled', true);
			                return false;
			             } 
			             else{
			             } //else끝
			          },
			          error:function(request, status, error){
			             $("#idInfo").text("오류가 발생함")
			          }
			       });//midCheck ajax끝
			       
	                $.ajax({
				          url:"./mrrnCheck",
				          type:"post",
				          data:{"mrrn":mrrn},
				          dataType:"json",
				          success:function(data){
				             if(data.mrrnCheck==1){
				            	$("#firstMrrn").focus();
				                $("#mrrnInfo").html("이미 등록된 주민등록번호입니다.<br>");
				                $("#mrrnInfo").css("color","red");
	                    	    $("#mrrnInfo2").css("color","black");
	                    	    $("#mrrnInfo2").html("<div class='form-area'><div class='form'><span>아이디 찾기가 필요하신가요? </span><a href='./findID'>&nbsp;&nbsp;아이디 찾으러 가기</a></div></div>");
	            				$("#idInfo").text("");
	            				$("#pwInfo").text("");
	            				$("#pwInfo2").text("");
	            				$("#nameInfo").text("");
	            				$("#emailInfo").text("");
	            				$("#homeAddrInfo").text("");
	            				$("#birthInfo").text("");
	            				$("#phoneInfo").text("");
	            				$("#joinInfo").text("");
	                    	    $("#joinMemberBtn").attr('disabled', true);
	                    	    return false;
				             } 
				             else{
				     			let mpw = $("#mpw").val();
				    			let mpwDuplication = $("#mpwDuplication").val();
				    			let mname = $("#mname").val();
				    			let firstMrrn = $("#firstMrrn").val();
				    			let lastMrrn = $("#lastMrrn").val();
				    			let memail = $("#memail").val();
				    			let mhomeaddr = $("#mhomeaddr").val();
				    			let mhomeaddr2 = $("#mhomeaddr2").val();
				    			let mcompanyaddr = $("#mcompanyaddr").val();
				    			let mcompanyaddr2 = $("#mcompanyaddr2").val();
				    		    let mgender = document.getElementById("mgender").value;
				    		    let mbirth = document.getElementById("mbirth").value;
				    			let firstNumber = $("#firstNumber").val();
				    			let MiddleNumber = $("#MiddleNumber").val();
				    			let lastNumber = $("#lastNumber").val();
				    			let checkMrrn = $("#firstMrrn").val() + $("#lastMrrn").val();
				    			let phoneNumber = $("#firstNumber").val() + $("#MiddleNumber").val() + $("#lastNumber").val();
				    			let special = /[^a-zA-Z0-9가-힣]/; //특수문자 확인
				    			let kor = /[가-힣]/; //한글 확인
				    			let notNum = /[^0-9]/g; //숫자아닌지 확인
				    			
				    		      if (mid == "") {
				    		         $("#mid").focus();
				    		         $("#idInfo").text("아이디를 입력해주세요.");
				    		         $("#idInfo").css("color", "red");
				    		         return false;
				    		      }
				    		      
				    		      if (mid.length < 4) {
				    			         $("#mid").focus();
				    			         $("#idInfo").text("아이디를 4글자 이상 입력해주세요.");
				    			         $("#idInfo").css("color", "red");
				    			         return false;
				    			      }
				    			
				    			  if (special.test(mid)) {
				    			        $("#idInfo").text("아이디에 특수문자는 허용되지 않습니다.");
				    			        $("#idInfo").css("color", "red");
				    			        return false;
				    			  }
				    			  
				    		       if (mpw == "") {
				    		           $("#mpw").focus();
				    		           $("#pwInfo").text("비밀번호를 입력해주세요.");
				    		           $("#pwInfo").css("color", "red");
				    		           return false;
				    		        } 
				    		       
				    			      if (mpw.length < 4) {
				    				         $("#mpw").focus();
				    				         $("#pwInfo").text("비밀번호를 4글자 이상 입력해주세요.");
				    				         $("#pwInfo").css("color", "red");
				    				         return false;
				    				      }
				    			      
				    		       if (mpwDuplication == "") {
				    		           $("#mpw").focus();
				    		           $("#pwInfo2").text("비밀번호를 확인해주세요.");
				    		           $("#pwInfo2").css("color", "red");
				    		           return false;
				    		        } 
				    		       
				    		       if (mpw != mpwDuplication) {
				    		           $("#pwInfo2").text("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
				    		           $("#pwInfo2").css("color", "red");
				    		           return false;
				    		        } else{
				    			           $("#pwInfo2").text("비밀번호가 일치합니다.");
				    			           $("#pwInfo2").css("color", "green");
				    		        }
				    		       
				    		        if (mname == "") {
				    			           $("#mname").focus();
				    			           $("#nameInfo").text("이름을 입력해주세요.");
				    			           $("#nameInfo").css("color", "red");
				    			           return false;
				    			        }
				    		        
				    			    if (!kor.test(mname)) {
				    			        $("#nameInfo").text("한글만 입력 가능합니다.");
				    			        $("#nameInfo").css("color","red");
				    			        return false;
				    			    }
				    			    
				    		         if (firstMrrn == "" || lastMrrn=="") {
				    		              $("#mrrnInfo").text("주민번호를 모두 입력해주세요.");
				    		              $("#mrrnInfo").css("color", "red");
				    		              return false;
				    		           } else{
				    		        	   
				    		           }
				    		         
				    				    if(notNum.test(checkMrrn) || checkMrrn.length !== 13) {
				    				        $("#mrrnInfo").text("올바른 주민번호를 입력해주세요.");
				    				        $("#mrrnInfo").css("color","red");
				    				        return;
				    				    } else{
				    				    	
				    				    }
				    		        
				    		        if (memail == "" ) {
				    		           $("#memail").focus();
				    		           $("#emailInfo").text("이메일을 입력해주세요.");
				    		           $("#emailInfo").css("color", "red");
				    		           return false;
				    		        } 
				    		        
				    		        if (memail.indexOf("@") === -1) {
				    			           $("#memail").focus();
				    			           $("#emailInfo").text("올바른 이메일을 입력해주세요.");
				    			           $("#emailInfo").css("color", "red");
				    			           return false;
				    			        } 

				    		           if (mgender === "") {
				    			              $("#mgender").focus();
				    			              $("#genderInfo").text("성별을 선택하세요.");
				    			              $("#genderInfo").css("color","red");
				    			              return false;
				    			           }
				    		           
				    		           if (mhomeaddr === "") {
				    			              $("#mhomeaddr").focus();
				    			              $("#homeAddrInfo").text("주소를 입력하세요.");
				    			              $("#homeAddrInfo").css("color","red");
				    			              return false;
				    			           }
				    		           
				    		           if (mbirth === "") {
				    		              $("#mbirth").focus();
				    		              $("#birthInfo").text("생년월일을 선택하세요");
				    		              $("#birthInfo").css("color","red");
				    		              return false;
				    		           }
				    		           
				    				    if (phoneNumber == "") {
				    				        $("#phoneInfo").text("전화번호를 입력해주세요.");
				    				        $("#phoneInfo").css("color","red");
				    				        return false;
				    				    }
				    					
				    				    if(notNum.test(phoneNumber) || phoneNumber.length !== 11) {
				    				        $("#phoneInfo").text("올바른 전화번호를 입력해주세요.");
				    				        $("#phoneInfo").css("color","red");
				    				        return false;
				    				    }
				             }//esle 끝
				             			//모피어스 암호화
				             			/* let mpw = $("#mpw").val();
							            let encrypt = M.sec.encrypt(mpw);
							            M.tool.log(encrypt);
							            
							         	// JSON.stringify(encrypt)의 결과 문자열
							            let jsonString = JSON.stringify(encrypt); 

							            try {
							                let jsonObject = JSON.parse(jsonString); // JSON 문자열을 파싱하여 객체로 변환
							                let resultValue = jsonObject.result; // result 속성에 해당하는 값 추출

							                // resultValue를 사용하면 원하는 값에 접근할 수 있습니다.
							                console.log(resultValue); 
							            	$("#mpw").val(resultValue);
							            } catch (error) {
							                console.error("JSON 파싱 에러: " + error);
							            } */
				    				    $("#join").submit();
				          },//success 끝
				          error:function(request, status, error){
				             $("#mrrnInfo").text("오류가 발생함")
				          }//error끝
				       });//mrrnCheck ajax끝        
	});//joinMemberBtn끝
	
		 //모달 열릴 때 footer 숨기기
		   $('#modal').on('show.bs.modal', function (e) {
		       $('#joinMemberBtn').hide(); 
		   });

		   $('#modal').on('hidden.bs.modal', function (e) {
		       $('#joinMemberBtn').show();
		   });
		   
		   $('#modal2').on('show.bs.modal', function (e) {
		       $('#joinMemberBtn').hide(); 
		   });

		   $('#modal2').on('hidden.bs.modal', function (e) {
		       $('#joinMemberBtn').show();
		   });
	
});//function끝

</script>
<script type="text/javascript">
/* window.onload = function(){
    document.getElementById("mhomeaddr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("mhomeaddr").value = data.address; // 주소 넣기
                document.querySelector("input[name=mhomeaddr2]").focus(); //상세입력 포커싱
            }
        }).open();
    });  
    
    document.getElementById("mcompanyaddr").addEventListener("click", function(){
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("mcompanyaddr").value = data.address;
                document.querySelector("input[name=mcompanyaddr2]").focus();
            }
        }).open();
    });
} */

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Morpheus Image Upload Sample</title>
</head>
	<!-- 본문내용 -->
	<main>
<!-- 		<div class="center-circle-area">
			<div class="center-circle">
				<div class="center-img">
					<img alt="없음" src="/img/hospital2.png" onclick="location.href='/main'">
				</div>
			</div>
		</div> -->
		
	<div class="main-area">
	<div class="top-area">
		<p class="top-title">DR.Home 💊</p>
		<p class="top-introduce">닥터홈에 오신 것을 환영합니다!</p>
		<p class="top-introduce">계정 생성을 위해 아래 내용을 입력해주세요.</p>
	</div>
	
	<form action="./join" method="post" id="join">
	<div class="middle-area">
	<div class="input-area">
		<div class="id-p">
			<span>아이디</span><button class="button" type="button" id="midCheck"> 중복확인</button>
		</div>
		<input type="text" id="mid" name="mid" placeholder="아이디를 입력해주세요." maxlength="11">
	    <p id="idInfo" class="info"></p>
	</div>
	<div class="input-area">
		<p>비밀번호</p>
		<input type="password" id="mpw" name="mpw" placeholder="비밀번호를 입력해주세요." maxlength="8">
		<p id="pwInfo" class="info"></p>
    </div>
	    <div class="input-area">
	   	<p>비밀번호 확인</p>
		<input type="password" id="mpwDuplication" name="mpwDuplication" placeholder="비밀번호를 입력해주세요." maxlength="8">
	    <p id="pwInfo2" class="info"></p>
    </div>
    <div class="input-area">
	    <p>이름</p>
		<input type="text" id="mname" name="mname" placeholder="이름을 입력해주세요." maxlength="11">
	    <p id="nameInfo" class="info"></p>
    </div>
    <div class="input-area">
	    <p>주민등록번호</p>
		<input type="text" id="firstMrrn" name="firstMrrn" maxlength="6" placeholder="960614"> -
		<input type="text" id="lastMrrn" name="lastMrrn" maxlength="7" placeholder="2XXXXXX">
		<p id="mrrnInfo" class="info"></p>
		<p id="mrrnInfo2" class="info"></p>
		<p id="mrrnInfo3" class="info"></p>
	</div>
	<div class="input-area">
		<p>이메일 주소</p>
		<input type="text" id="memail" name="memail" placeholder="이메일 주소를 입력해주세요." maxlength="40">
	    <p id="emailInfo" class="info"></p>
	    </div>
    <div class="input-area">
	    <p>성별</p>
	    <select class="select" name="mgender" id="mgender">
		<option class="option" value="0">남자</option>
		<option class="option" value="1">여자</option>
	    </select>
	    <p id="genderInfo" class="info"></p>
    </div>
    <div class="input-area">
	    <p>집주소</p>
		<input type="text" id="mhomeaddr" name="mhomeaddr" placeholder="집주소를 입력해주세요." onclick="searchAddr()">
		<input type="text" id="mhomeaddr2" name="mhomeaddr2" placeholder="상세주소를 입력해주세요.">
	    <p id="homeAddrInfo" class="info"></p>
    </div>
    <div class="input-area">
	    <p>회사주소(선택)</p>
		<input type="text" id="mcompanyaddr" name="mcompanyaddr" placeholder="회사 주소를 입력해주세요." onclick="searchComAddr()">
		<input type="text" id="mcompanyaddr2" name="mcompanyaddr2" placeholder="상세주소를 입력해주세요.">
	    <p id="companyAddrInfo" class="info"></p>
    </div>
    <div class="input-area">
	    <p>생일</p>
	    <input type="date" id="mbirth" name="mbirth">
	    <p id="birthInfo" class="info"></p> 
    </div>
    <div class="input-area">
    	<p>전화번호</p>
		<input type="text" id="firstNumber" name="firstNumber" maxlength="3" placeholder="010"> -
		<input type="text" id="MiddleNumber" name="MiddleNumber" maxlength="4" placeholder="xxxx"> -
		<input type="text" id="lastNumber" name="lastNumber" maxlength="4" placeholder="xxxx">
		<p id="phoneInfo" class="info"></p>
	</div>
	<div class="input-area">
		<p id="joinInfo" class="info"></p>
	</div>
	
	 <div style="height: 9vh"></div>
	
	<footer> 
		<button type="submit" id="joinMemberBtn">회원가입</button>
    </footer>
	</div> 
	</form>
	</div>
    </main> <!-- 컨테이너 끝 -->
    
    	<!-- 알람모달 -->
	
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">아이디 중복확인 후 회원가입이 가능합니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

    
	<!-- 모달1 start -->
	<div class="modal" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg modal-dialog-centered">
	<div class="modal-content">
	<div class="header">
	<h5 class="title" id="exampleModalLabel"></h5>
	</div>
	<div class="modal-body">
	<!-- 내용 start -->
	<div class="card-body">
	<p class="card-title">우편번호 찾기</p>
	</div>
	<!-- 내용 end -->
	</div>
	<div>
		<input type="text" id="sample2_postcode" placeholder="우편번호">
		<input type="button" onclick="sample2_execDaumPostcode()" value="주소 찾기" class="addrBtn"><br>
		<input type="text" id="sample2_address" placeholder="주소" class="modal-input"><br>
		<input type="text" id="sample2_detailAddress" placeholder="상세주소" class="modal-input">
		<input type="text" id="sample2_extraAddress" placeholder="참고항목" class="modal-input">
		</div>
		<button type="button" class="btn btn-info close" data-bs-dismiss="modal" aria-label="Close">X 닫기</button>
		<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
	<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
	</div>
	</div>
	</div>
	<!-- 모달1 end -->

	<!-- 모달2 start -->
	<div class="modal" id="modal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg">
	<div class="modal-content">
	<div class="header">
	<h5 class="title" id="exampleModalLabel"></h5>
	</div>
	<div class="modal-body">
	<!-- 내용 start -->
	<div class="card-body">
	<h5 class="card-title">우편번호 찾기</h5>
	</div>
	<!-- 내용 end -->
	</div>
	<div>
		<input type="text" id="sample2_postcode2" placeholder="우편번호">
		<input type="button" onclick="sample2_execDaumPostcode2()" value="주소 찾기" class="addrBtn"><br>
		<input type="text" id="sample2_address2" placeholder="주소" class="modal-input"><br>
		<input type="text" id="sample2_detailAddress2" placeholder="상세주소" class="modal-input">
		<input type="text" id="sample2_extraAddress2" placeholder="참고항목" class="modal-input">
		</div>
		<button type="button" class="btn btn-info close" data-bs-dismiss="modal" aria-label="Close">X 닫기</button>
		<div id="layer2" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode2()" alt="닫기 버튼">
		</div>
	<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
	</div>
	</div>
	</div>
	<!-- 모달2 end -->	
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    
</body>
<script src="./js/jquery-3.7.0.min.js"></script>
<script src="/js/wnInterface.js"></script>
<script src="/js/mcore.min.js"></script>
<script src="/js/mcore.extends.js"></script>
<script>

  (function () {

    $.imagePicker = function () {
      return new Promise((resolve) => {
        M.media.picker({
          mode: "SINGLE",
          media: "PHOTO",
          // path: "/media", // 값을 넘기지않아야 기본 앨범 경로를 바라본다.
          column: 3,
          callback: (status, result) => {
            resolve({ status, result })
          }
        });
      })
    }

    $.convertBase64ByPath = function (imagePath) {
      if (typeof imagePath !== 'string') throw new Error('imagePath must be string')
      return new Promise((resolve) => {
        M.file.read({
          path: imagePath,
          encoding: 'BASE64',
          indicator: true,
          callback: function (status, result) {
            resolve({ status, result })
          }
        });
      })
    }

    $.uploadImageByPath = function (targetImgPath, progress) {
      return new Promise((resolve) => {
        const _options = {
          url: `${location.origin}/file/upload`,
          header: {},
          params: {},
          body: [
            // multipart/form-data 바디 데이터
            { name: "file", content: targetImgPath, type: "FILE" },
          ],
          encoding: "UTF-8",
          finish: (status, header, body, setting) => {
            resolve({ status, header, body })
          },
          progress: function (total, current) {
            progress(total, current);
          }
        }
        M.net.http.upload(_options);
      })
    }

  })();


  $(function () {

    let selectImagePath = '';
    let $previewImg = null;
    let $uploadImg = null;
    const $box = $('#box');
    const $uploadBox = $('#upload-box');
    const $progress = $('#progress');
    const $picker = $('#picker');
    const $upload = $('#upload');



    $picker.on('click', () => {
      if ($previewImg !== null) {
        $previewImg.remove();
        $previewImg = null;
      }
      selectImagePath = '';
      $.imagePicker()
        .then(({ status, result }) => {
          if (status === 'SUCCESS') {
            selectImagePath = result.path;
            return $.convertBase64ByPath(selectImagePath)
          } else {
            return Promise.reject('이미지 가져오기 실패')
          }
        })
        .then(({ status, result }) => {
          if (status === 'SUCCESS') {
            $previewImg = $(document.createElement('img'))
            $previewImg.attr('height', '200px')
            $previewImg.attr('src', "data:image/png;base64," + result.data)
            $box.append($previewImg);
          } else {
            return Promise.reject('BASE64 변환 실패')
          }
        })
        .catch((err) => {
          if (typeof err === 'string') alert(err)
          console.error(err)
        })
    })

    $upload.on('click', () => {
      if (selectImagePath === '') return alert('이미지를 선택해주세요.')
      if ($uploadImg) {
        $uploadImg.remove();
        $uploadImg = null;
      }
      $progress.text('')
      $.uploadImageByPath(selectImagePath, (total, current) => {
        console.log(`total: ${total} , current: ${current}`)
        $progress.text(`${current}/${total}`)
      })
        .then(({
          status, header, body
        }) => {
          // status code
          if (status === '200') {
            $progress.text('업로드 완료')
            const bodyJson = JSON.parse(body)
            $uploadImg = $(document.createElement('img'))
            $uploadImg.attr('height', '200px')
            $uploadImg.attr('src', bodyJson.fullpath)
            $uploadBox.append($uploadImg)
          } else {
            return Promise.reject('업로드를 실패하였습니다.')
          }
        })
        .catch((err) => {
          if (typeof err === 'string') alert(err)
          console.error(err)
        })
    })
  });


</script>

</html>
