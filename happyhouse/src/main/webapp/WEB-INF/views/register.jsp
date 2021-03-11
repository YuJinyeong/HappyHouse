<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${root }/css/login.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set value="${pageContext.request.contextPath }" var="root" scope="session"></c:set>
<!-- ID/ PW /NAME / EMAIL 입력  --> 
<!-- action : register 로 전달 -->
<div id="bg"></div>   

<form action="${root }/Member_control/register" method ="Post">
    
 <h3> 회원가입 페이지 </h3>
  <input type="ID" name="id" id="" placeholder="ID" class="email">
    
  <input type="password" name="pw" id="" placeholder="password" class="pass">
   <input type="Name" name="name" id="" placeholder="Name" class="email">
  <input type="EMAIL" name="email" id="" placeholder="email" class="email">
   <input type="submit" value="Register">  
   <button type= "button" onclick="window.location.href='${root }/Member_control/mv_home'">Back</button>
<!--   <button type="submit">Register</button> -->
    
</form>

</body>
</html>