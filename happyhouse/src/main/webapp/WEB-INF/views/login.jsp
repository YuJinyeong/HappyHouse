<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${root }/css/login.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <c:set value="${pageContext.request.contextPath }" var="root"
      scope="session"></c:set>




   <c:if test="${msg != null}">
      <script type="text/javascript">
         alert("회원가입 완료되었습니다. 로그인 해주세요. ");
      </script>
   </c:if>

   <div id="bg"></div>
   <!-- ID , PW 입력  -->

   <form action="${root }/Member_control/login" method="Post">
      <label for=""></label> <input type="text" name="id" id="id"
         placeholder="ID" class="email"> <label for=""></label> <input
         type="password" name="passwd" id="pw" placeholder="password"
         class="pass"> <input type="submit" value="login">
      <button type="button"
         onclick="window.location.href='${root }/Member_control/register_page'">Register</button>
      <button type="button"
         onclick="window.location.href='${root }/Member_control/mv_home'">Back</button>
   </form>

</body>
</html>