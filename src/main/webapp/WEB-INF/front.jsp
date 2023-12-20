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
	
	#table1 {
	  margin-top: 5%;
	  margin-left: auto;
 	  margin-right: auto;
	  text-align: center;
	  width: 40%;
	}
	
	#table2 {
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
		let userid;
		let nm;
		let brdt;
		let mbl_no;
		let nsp_rsvt_no;
		let insp_addr;
		let insp_dt;
		
		//초기화면세팅
		$('#msg1').hide();
		$('#msg2').hide();
		$('#table1').hide();
		$('#table2').hide();
		$('#container3').hide();
		
	 	let jsonData = {
				tableno: 2,
				itemId : 2,
				name : 'Kalguksu',
				price : 8000				
		};
 
	
		//사용자정보 및 예약정보 검색
		
		search.addEventListener("click", ()=>{
		
		userid = $('#userkey').val();

		console.log("you clicked search");
		
		 $.get("/search", 
					{ id : userid }, 
					// 서버가 필요한 정보를 같이 보냄. 
					function(data, status) { 
						console.log(data);
						console.log(status);		
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
							 $("#time").text(data.insp_dt.substring(12,5));
							 
							 $('#msg2').hide();
							 $('#table2').show();
							 $('#container3').show();
						}else{
							$('#msg2').show();
							 $('#table2').hide();
						}						
					} ); 
		});
		
		
		$.ajax({
			type:"post",
			url:"reservation",
	        headers: {"asd": "asdf"}, //adding data to header
			data: jsonData 
		}).done(function(data, status, xhr){ // done - success 와 동일
			console.log("JSON.stringify");
			console.log(JSON.stringify(data));
				
			console.log("<1>data");
			console.log(data);
			console.log("<2>status");
			console.log(status);
			console.log("<3>xhr");
			console.log(xhr);
			console.log("<4>header");
			let headers = xhr.getAllResponseHeaders();	
			//headers = headers.substring(1, 4);
			console.log(headers);
			console.log("<5>get RequestHeader");
			console.log(xhr.getRequestHeader);
			console.log("<6>get ResponseHeader");
			console.log(xhr.getResponseHeader);
			
			//const str = String(headers);
			//console.log(str);
			//console.log(JSON.parse(str));
			//console.log(JSON.parse(str));
			//console.log(headers["content-type"]);
			//console.log(headers.content-type);	x
			//console.log(headers.get("content-type"));   x
			/* headers is string so we convert this to map */
			console.log("<7>header iteration");
			headers = headers.split(/\n|\r|\r\n/g).reduce(function(a, b) {
			    if (b.length) {
			      var [ key, value ] = b.split(': ');
			      a[key] = value;
			    }
			    return a;
			  }, {});
			console.log(headers)		
		});
		
			//console.log("<8>set Content-type");
			//xhr.SetRequestHeader("Content-type", "text/html");
			//console.log(headers);
			
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
	${user}
	${data}
	
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
		<div id="msg2"> 예약정보가 없습니다 </div>	
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
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>