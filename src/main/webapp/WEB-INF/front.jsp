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
	
	#search{
	  height: 30px;
	  text-align: center;
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
										
						userid = data.id;

						//사용자정보가 있으면 회원정보테이블을 보여준다.
						if(userid != null){
							console.log("user table show");
							  //사용자 테이블 값 세팅	
							  
							 $("#name").text(data.nm);
							 $("#birth").text(data.brdt.substring(0, 10));
							 $("#mobile").text(data.mbl_no);
							 
							 $('#msg1').hide();				
							 $('#table1').show();
							 
						}else{
							 $('#table1').hide();
						}
						//예약정보가 있으면 병역판정검사테이블을 보여준다.
						if(nsp_rsvt_no != null){
							console.log("reservation table show");
							 $('#msg2').hide();
							 $('#table2').show();
						}else{
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
	<button id="search"  class="btn btn-info">검색</button> 
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
		      <th scope="col">First</th>
		      <th scope="col">Last</th>
		      <th scope="col">Handle</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">1</th>
		      <td>Mark</td>
		      <td>Otto</td>
		      <td>@mdo</td>
		    </tr>
		    <tr>
		      <th scope="row">2</th>
		      <td>Jacob</td>
		      <td>Thornton</td>
		      <td>@fat</td>
		    </tr>
		    <tr>
		      <th scope="row">3</th>
		      <td colspan="2">Larry the Bird</td>
		      <td>@twitter</td>
		    </tr>
		  </tbody>
		</table>
		</div>	
	</div>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>