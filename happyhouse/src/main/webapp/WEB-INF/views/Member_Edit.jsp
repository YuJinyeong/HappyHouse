<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${root }/css/login.css">
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<c:set value="${pageContext.request.contextPath }" var="root" scope="session"></c:set>

<!-- 1. java script 사용해서 session에 저장된  ID를 이용하자. -->
<!-- 2. select 를 통해서 , 관련 정보를 value 값에 출력해 주자. -->
<script>
   // let colorArr = ['table-primary','table-success','table-danger'];
   
//    $(document).ready(function(){
//       $.get("${pageContext.request.contextPath}/Member_control"
//          ,{act:"basic_Info" }
//          ,function(data, status){
//             console.log(data);
                     
//             $.each(data, function(index, vo) {
//                $("#Basic_information").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
//             });//each
//          }//function
//          , "json"
//       );//get
      
      
//    });//ready
         
   function delete_event(){
      if (confirm(" 정말 회원정보를 삭제 하시겠습니까? ") == true   ){
         document.location.href = '${root }/Member_control/delete';
      }
      else {
         return;
      }
   }
</script>

<div id="bg"></div>
<form action="${root }/Member_control/edit" method="Post" id = "Basic_information">
 <h3> 회원정보 수정페이지 </h3>
   
   
  ID <input type="ID" name="id"  value="${loginId }" class="email" readonly="readonly" >
  PW <input type="passowrd" name="pw"  value="${loginpasswd }" class="pass">    
  NAME <input type="NAME" name="name"  value="${loginname }" class="email"> 
  EMAIL <input type="EMAIL" name="email"  value="${loginemail }" class="email">
  <input type="submit" value="Edit">
  
 <!-- <button type= "button" onclick="window.location.href='${root }/Member_control?action=delete'">Info_Delete</button> --> 
  <button type= "button" onclick="delete_event();">Info_Delete</button>
<!-- <button type= "button" onclick="window.location.href='${root }/index.jsp'">Back</button> -->  
  <button type= "button" onclick="window.location.href='${root }/Member_control/mv_home'">Back</button>
    
    
</form>
</body>
</html>