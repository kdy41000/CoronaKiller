<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronaKiller</title>

</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<body>
<%@ include file="header.jsp" %>
<div class="container-fluid">

<br/><br/><br/><br/><br/><br/><br/><br/>
  
  <div class="row">
    <img alt="img" src="../resources/images/home/Mainimg02.png" style="width: 90%; margin-left: 5%;"/>
    <input type="button" value="마스크판매처 정보" onclick="location.href='../store.do?command=store';" style="background:skyblue; color:white; width:30%; height:50px; font-size:20px; border-radius:10px; margin-left: 33%; cursor:pointer;"/>
    </div>
  </div><br/><br/><br/>
<hr/>
  <div class="row">
    <img alt="img" src="../resources/images/home/Mainimg01.jpg" style="width: 90%; margin-left: 5%; margin-top: 5%;"/>
    <input type="button" value="선별진료소 정보" onclick="location.href='../hospitalTwo.do?command=hospitalTwo';" style="background:skyblue; color:white; width:30%; height:50px; font-size:20px; border-radius:10px; margin-left: 33%; margin-top: 3%; cursor:pointer;"/>
    </div>
  </div><br/><br/><br/>
<hr/>  
  <div class="row">
    <img alt="img" src="../resources/images/home/Mainimg03.jpg" style="width: 90%; margin-left: 5%; margin-top: 5%;"/>
    <input type="button" value="국민안심병원 정보" onclick="location.href='../hospital.do?command=hospital';" style="background:skyblue; color:white; width:30%; height:50px; font-size:20px; border-radius:10px; margin-left: 33%; margin-top:3%; cursor:pointer;"/>
    </div>
  </div>


  <div class="row">
    <div class="projetos col-md-12 text-center">
<form action="../sendmail.do" method="post">
<input type="hidden" name="command" value="sendmail"/>      
    	<fieldset style="background: white;
    width: 70%;
    height: 550px;
    margin: 18% 0% 0% 13%;
    text-align: center;
    border-radius: 10px;
    border: 2px solid navajowhite;">
      		<h1 style="color:black;">버그 및 문의사항</h1><br/>
      		<p>개선사항 및 문제점을 요청해주세요.</p>
      		<input type="text" name="user_name" placeholder="이름을 입력해 주세요" style="width:80%; height:40px; border-radius:10px; border:1px solid skyblue;"/><br/><br/><br/>
      		<input type="email" name="user_email" placeholder="이메일을 입력해 주세요" style="width:80%; height:40px; border-radius:10px; border:1px solid skyblue;"/><br/><br/><br/>
      		<textarea name="user_content" id="textarea" placeholder="내용을 입력해주세요" style="width:80%; height:80px; border-radius:10px; border:1px solid skyblue;"></textarea>
    		<input type="button" onclick="submitinfo();" value="Send" style="background:skyblue; border:1px solid white; color:white; font-weight:bold; border-radius:10px; margin-top:5%; width:50%; height:50px; font-size:20px;"/>
    	</fieldset>
    	</form> 
    </div>
  </div> 
</div>
</body>
<script type="text/javascript">
	function submitinfo(){
		if($('input[name=user_name]').val() ==""){
			alert("이름을 입력해주세요.");
		}else if($('input[name=user_email]').val() ==""){
			alert("이메일을 입력해주세요.");
		}else if($('#textarea').val()==""){
			alert("내용을 입력해주세요.");
		}else{
			$("form").submit();
		}
	}
</script>
</html>