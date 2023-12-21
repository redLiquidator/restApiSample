<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style>
#container1 {
	text-align: center;
}

#container2 {
	text-align: center;
}

#insert {
	margin-top: 2%;
}

#modify {
	margin-left: 38%;
}

#delete {
	margin-left: 2%;
}

#title {
	margin-top: 2%;
	margin-left: 30%;
	font-weight: bold;
}

#table1, #table2, #table3 {
	margin-top: 5%;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	width: 40%;
}
</style>
<meta charset="EUC-KR">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		const search = document.querySelector("#search");
		const insert = document.querySelector("#insert");	
		const insertExecute = document.querySelector("#insertExecute");	
		const modify = document.querySelector("#modify");
		const modifyExecute = document.querySelector("#modifyExecute");
		const deleteExecute = document.querySelector("#deleteExecute");
		let userid;
		let nm;
		let brdt;
		let mbl_no;
		let insp_rsvt_no;
		let insp_addr;
		let insp_dt;
		
		//�ʱ�ȭ�鼼��
		$('#msg1').hide();
		$('#msg2').hide();
		$('#insert').hide();
		$('#table1').hide();
		$('#table2').hide();
		$('#container3').hide();
		$('#container4').hide();
		$('#modifyExecute').hide();
		
	 	let jsonData = {
				"id" : userid,
				"nm" : nm,
				"brdt" : brdt,
				"mbl_no" : mbl_no,
				"insp_rsvt_no" : insp_rsvt_no,
				"insp_addr" : insp_addr,
				"insp_dt" : insp_dt		
		};
 
	
	 	function userSearch(userid){
	 		//�ʱ�ȭ�鼼��
			$('#msg1').hide();
			$('#msg2').hide();
			$('#insert').hide();
			$('#table1').hide();
			$('#table2').hide();
			$('#container3').hide();
			$('#container4').hide();
			$('#modifyExecute').hide();
			
			 $.get("/search", 
						{ id : userid }, 
						// ������ �ʿ��� ������ ���� ����. 
						function(data, status) { 
							console.log(data);
							console.log(status);
							
							userid = data.id;
							nm = data.nm;
							brdt = data.brdt;
							mbl_no = data.mbl_no;
							insp_rsvt_no = data.insp_rsvt_no;
							insp_addr = data.insp_addr;
							insp_dt = data.insp_dt;
							
							//�����ư visible ����
							if(data.id != null && data.insp_rsvt_no == null){
								$('#insert').show();
							}
							
							if(data.id != null && data.insp_rsvt_no != null){
								//���ຯ����� ��ư �����
								$('#container2').show();
								$('#container3').show();
							}
							
							
							//����������� ������ ȸ���������̺��� �����ش�.
							if(data.id != null){
								console.log("user table show");
								  //����� ���̺� �� ����				  
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
							//���������� ������ ���������˻����̺��� �����ش�.
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
			}
	 	
	 	
	 	
		//���1.��������� �� �������� �˻�	
		search.addEventListener("click", ()=>{
		
		$('#container4').hide();
		$('#insert').hide();
		userid = $('#userkey').val();
		console.log("you clicked search");
		userSearch(userid);
		
		 
			
			insert.addEventListener("click", ()=>{
				$('#container3').hide();
				$('#container4').show();
				$('#msg2').hide();
				$('#insert').hide();
			});
			
			//���2.�����������
			insertExecute.addEventListener("click", ()=>{

				insp_addr = $('#iaddress').val()
				insp_dt = $('#idate').val()+" "+$('#itime').val();
				
				console.log(insp_addr);
				console.log(insp_dt);
				
				jsonData = {
						"id" : userid,
						"nm" : nm,
						"brdt" : brdt,
						"mbl_no" : mbl_no,
						"insp_rsvt_no" : insp_rsvt_no,
						"insp_addr" : insp_addr,
						"insp_dt" : insp_dt
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
						  alert("��ϿϷ�");
						  userSearch(userid);					  
					  }, 
					  error: function(xhr, status, error) { 
						  alert("��ϿϷ�");
						  userSearch(userid);
					  } 
					}); 
				
				
			});
			
			modify.addEventListener("click", ()=>{
				console.log("you clicked modify");

				$('#container3').hide();
				$('#container2').hide();
				$('#container4').show();
				$('#msg2').hide();
				$('#insert').hide();
				$('#insertExecute').hide();
				$('#modifyExecute').show();
					
				//����� �������� ���̺� �ҷ����� 			
				console.log(insp_addr);
				console.log(insp_dt);
				$('#iaddress').val(insp_addr);
				$('#idate').val(insp_dt.substring(0,10));
				$('#itime').val(insp_dt.substring(11,19));				
			});
			
			//���3.������������
			modifyExecute.addEventListener("click", ()=>{
			console.log("you clicked modifyExecute");
			insp_addr = $('#iaddress').val();
			insp_dt =$('#idate').val()+" "+$('#itime').val();
			console.log(insp_rsvt_no);
			console.log(insp_addr);
			console.log(insp_dt);
			$.ajax({ 
				  url: 'modify', 
				  type: 'POST', 
				  data: JSON.stringify({ insp_rsvt_no : insp_rsvt_no , insp_addr : insp_addr, insp_dt : insp_dt }), 
				  headers: { 
					  'Accept': 'application/json',
				      'Content-Type': 'application/json'
				  }, 
				  success: function(response) { 
					  console.log('success');
					  alert("�����Ϸ�");
					  userSearch(userid);		  
				  }, 
				  error: function(xhr, status, error) { 
					  console.log('fail ' + status + ' , ' + error);
					  alert("�����Ϸ�");
					  userSearch(userid);
				  } 
				}); 				
			  });	
		});
		//���4.������������
		deleteExecute.addEventListener("click", ()=>{
		console.log("you clicked deleteExecute");
		console.log(userid);
		console.log(insp_rsvt_no);
		
		$.ajax({ 
			  url: 'delete', 
			  type: 'POST', 
			  data: JSON.stringify({id: userid, insp_rsvt_no : insp_rsvt_no}), 
			  headers: { 
				  'Accept': 'application/json',
			      'Content-Type': 'application/json'
			  }, 
			  success: function(response) { 
				  console.log('success');
				  alert("�����Ϸ�");
				  userSearch(userid);  				  
			  }, 
			  error: function(xhr, status, error) { 
				  console.log('fail ' + status + ' , ' + error);
				  alert("�����Ϸ�");
				  userSearch(userid);
			  } 
			}); 
			
		
		
		
		
		});	
	}); //.ready	

</script>
</head>
<body>
	<div id="title">
		���������˻� ���� ��ȸ <br> #ȸ����ȣ�� �Է��ϼ���: <input id="userkey"
			name="userkey" placeholder="5bda87ad" size="4">
		<button id="search" class="btn btn-outline-secondary">�˻�</button>
	</div>

	<div id="container1">
		<div id="msg1">ȸ�������� �����ϴ�</div>
		<div id="table1">
			�� ȸ������
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
						<td>����</td>
						<td id="name"></td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>�������</td>
						<td id="birth"></td>
					</tr>
					<tr>
						<th>3</th>
						<td>�޴���ȭ</td>
						<td id="mobile"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>


	<div id="container2">
		<div id="msg2">���೻���� �����ϴ�</div>
		<button id="insert" class="btn btn-outline-success">�˻翹��</button>

		<div id="table2">
			�����������˻� ��������
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
						<td>�˻����</td>
						<td id="address"></td>
					</tr>
					<tr>
						<th>2</th>
						<td>�˻�����</td>
						<td id="date"></td>
					</tr>
					<tr>
						<th>3</th>
						<td>�ð�</td>
						<td id="time"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div id="container3">
		<button id="modify" class="btn btn-outline-warning">���ຯ��</button>
		<button id="deleteExecute" class="btn btn-outline-danger">�������</button>
	</div>

	<div id="container4">
		<div id="table3">
			���˻���� ���, �ð�, ������ �Է��ϼ���
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
						<td>�˻����</td>
						<td><input id="iaddress" name="iaddress"
							placeholder="ex.����� �������� ���Ǵ��� 43�� 13" size="12" value="�׽�Ʈ���"></td>
					</tr>
					<tr>
						<th>2</th>
						<td>�˻�����</td>
						<td><input id="idate" name="idate" placeholder="ex.20231225"
							size="12" value="2023-12-11"></td>
					</tr>
					<tr>
						<th>3</th>
						<td>�ð�</td>
						<td><input id="itime" name="itime" placeholder="ex.13:30:00"
							size="12" value="13:23:30"></td>
					</tr>
				</tbody>
			</table>
			<button id="insertExecute" class="btn btn-outline-warning">�������</button>
			<button id="modifyExecute" class="btn btn-outline-warning">�������</button>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>