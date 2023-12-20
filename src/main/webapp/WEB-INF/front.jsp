<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#container1{
	 text-align: center;
	}
	
	#container2{
	 text-align: center;
	}
	
	#insert{
	 margin-top: 2%;
	}
	
	#modify{
	 margin-left: 38%;
	}
	#delete{
	 margin-left: 2%;
	}
	
	#title{
     margin-top: 2%;
     margin-left: 30%;
     font-weight: bold;
	}
	
	#table1,#table2,#table3 {
	  margin-top: 5%;
	  margin-left: auto;
 	  margin-right: auto;
	  text-align: center;
	  width: 40%;
	}

	
</style>
<meta charset="EUC-KR">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		let search = document.querySelector("#search");
		let insert = document.querySelector("#insert");	
		let insertExecute = document.querySelector("#insertExecute");	
		let modify = document.querySelector("#modify");
		let del = document.querySelector("#delete");
		let userid;
		let nm;
		let brdt;
		let mbl_no;
		let nsp_rsvt_no;
		let insp_addr;
		let insp_dt;
		let datetime;
		
		//초기화면세팅
		$('#msg1').hide();
		$('#msg2').hide();
		$('#insert').hide();
		$('#table1').hide();
		$('#table2').hide();
		$('#container3').hide();
		$('#container4').hide();
		
	 	let jsonData = {
				"id" : userid,
				"nm" : nm,
				"brdt" : brdt,
				"mbl_no" : mbl_no,
				"nsp_rsvt_no" : nsp_rsvt_no,
				"insp_addr" : insp_addr,
				"insp_dt" : insp_dt		
		};
 
	
		//기능1.사용자정보 및 예약정보 검색	
		search.addEventListener("click", ()=>{
		
		$('#container4').hide();
		$('#insert').hide();
		userid = $('#userkey').val();
		console.log("you clicked search");
		
		
		 $.get("/search", 
					{ id : userid }, 
					// 서버가 필요한 정보를 같이 보냄. 
					function(data, status) { 
						console.log(data);
						console.log(status);
						
						userid = data.id;
						nm = data.nm;
						brdt = data.brdt;
						mbl_no = data.mbl_no;
						nsp_rsvt_no = data.nsp_rsvt_no;
						insp_addr = data.insp_addr;
						insp_dt = data.insp_dt;
						
						//예약버튼 visible 설정
						if(data.id != null && data.insp_rsvt_no == null){
							$('#insert').show();
						}
						
						//사용자정보가 있으면 회원정보테이블을 보여준다.
						if(data.id != null){
							console.log("user table show");
							  //사용자 테이블 값 세팅				  
							 $("#name").text(data.nm);
							 $("#birth").text(data.brdt.substring(0, 10));
							 $("#mobile").text(data.mbl_no);
							 
							 $('#msg1').hide();	
							 $('#msg2').hide();	
							 $('#table1').show();
							 $('#container3').hide();
							 
						}else{
							 $('#container3').hide();
							 $('#table1').hide();
							 $('#msg1').show();	
							 $('#msg2').hide();	
						}
						//예약정보가 있으면 병역판정검사테이블을 보여준다.
						if(data.insp_rsvt_no != null){
							console.log("reservation table show");
							console.log(data.insp_rsvt_no);
							 $("#address").text(data.insp_addr);
							 $("#date").text(data.insp_dt.substring(0, 10));
							 $("#time").text(data.insp_dt.substring(11,19));
							 
							 $('#msg2').hide();
							 $('#table2').show();
							 $('#container3').show();
						}else{
							$('#msg2').show();
							$('#table2').hide();
						}						
					}); 
		 
			//기능2.예약정보등록
			insert.addEventListener("click", ()=>{
				$('#container3').hide();
				$('#container4').show();
				$('#msg2').hide();
				$('#insert').hide();
			});
			
			
			
			insertExecute.addEventListener("click", ()=>{
				console.log( $('#iaddress').val());
				console.log( $('#idate').val());
				console.log( $('#itime').val());
				datetime = $('#idate').val()+$('#itime').val();
				console.log("datetime | "+datetime);
				
				jsonData = {
						"id" : userid,
						"nm" : nm,
						"brdt" : brdt,
						"mbl_no" : mbl_no,
						"nsp_rsvt_no" : nsp_rsvt_no,
						"insp_addr" : $('#iaddress').val(),
						"insp_dt" : datetime
						};
						
				console.log("insertExecute");
				$.ajax({ 
					  url: 'insert', 
					  type: 'POST', 
					  data: JSON.stringify(jsonData), 
					  headers: { 
						  'Accept': 'application/json',
					      'Content-Type': 'application/json'
					  }, 
					  success: function(response) { 
						  console.log('success');
					  }, 
					  error: function(xhr, status, error) { 
						  console.log('fail ' + status + ' , ' + error);
					  } 
					}); 
				
 				
				

			}); 
		});	
			
	}); //.ready	

</script>
</head>
<body>
	<div id="title">병역판정검사 예약 조회
	<br>
	#회원번호를 입력하세요:
	<input id="userkey" name="userkey" placeholder="5bda87ad" size="4"> 
	<button id="search"  class="btn btn-outline-secondary">검색</button> 
	</div>
	
	<div id="container1">
		<div id="msg1"> 회원정보가 없습니다 </div>
		<div id="table1">
		 ㅁ 회원정보
		<table class="table table-light table-hover">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col"></th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">1</th>
		      <td>성명</td>
		      <td id="name"></td>
		    </tr>
		    <tr>
		      <th scope="row">2</th>
		      <td>생년월일</td>
		      <td id="birth"></td>
		    </tr>
		    <tr>
		      <th>3</th>
		      <td>휴대전화</td>
		      <td id="mobile"></td>
		    </tr>
		  </tbody>
		</table>
		</div>
	</div>
	
	
	<div id="container2">
		<div id="msg2"> 예약내역이 없습니다</div>
		<button id="insert"  class="btn btn-outline-success">검사예약</button>  
		
		<div id="table2">
		 ㅁ병역판정검사 예약정보
		<table class="table table-light table-hover">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col"></th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th>1</th>
		      <td>검사장소</td>
		      <td id="address"></td>
		    </tr>
		    <tr>
		      <th>2</th>
		      <td>검사일자</td>
		      <td id="date"></td>
		    </tr>
		    <tr>
		      <th>3</th>
		      <td>시간</td>
		      <td id="time"></td>
		    </tr>
		  </tbody>
		</table>
		</div>	
	</div>
	
	<div id="container3">
		<button id="modify"  class="btn btn-outline-warning">예약변경</button> 
		<button id="delete"  class="btn btn-outline-danger">예약삭제</button> 
	</div>
	
	<div id="container4">	
		<div id="table3">
		 ㅁ검사희망 장소, 시간, 일정을 입력하세요
		<table class="table table-light table-hover">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col"></th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th>1</th>
		      <td>검사장소</td>
		      <td>
		      <input id="iaddress" name="iaddress" placeholder="ex.서울시 영등포구 여의대방로 43길 13" size="12" value="테스트장소"></td>
		    </tr>
		    <tr>
		      <th>2</th>
		      <td>검사일자</td>
		      <td><input id="idate" name="idate" placeholder="ex.20231225" size="12" value="2023-12-11"></td>
		    </tr>
		    <tr>
		      <th>3</th>
		      <td>시간</td>
		      <td><input id="itime" name="itime" placeholder="ex.13:30:00" size="12" value="13:23:30"></td>
		    </tr>
		  </tbody>
		</table>
			<button id="insertExecute"  class="btn btn-outline-warning">예약실행</button> 
		</div>	
	</div>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>