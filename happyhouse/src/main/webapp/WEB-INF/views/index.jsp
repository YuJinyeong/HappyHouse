<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Happy House</title>
        <link rel="icon" type="image/x-icon" href="${root }assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${root }/css/styles.css" rel="stylesheet" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="shortcut icon" href="${root }/img/favicon.ico">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <style type="text/css">
      td, thead{
      color : white;
      }
      </style>
        <script type="text/javascript">
        let colorArr = ['table-primary','table-success','table-danger'];
   $(document).ready(function() {
      
      
      $(document).ready(function(){
              $.get("${pageContext.request.contextPath}/map"
                 ,{act:"sido"}
                 ,function(data, status){
                    $.each(data, function(index, vo) {
                       $("#sido").append('<label class="dropdown-item cafe_area" value="'+vo.sido_code+'">'+vo.sido_name+'</label>');
                    });//each
                 }//function
                 , "json"
              );//get
           });//ready
      
      
//           $(document).on("click", ".dropdown-item.cafe_area", function() {
//         var selArea = $(this).text();
//         $("#areaBtn").text(selArea);
//           });
              
//         var offices = cafeArea[selArea];
//         $("#office_div1").empty();
//         $.each(offices, function(i, office) {
//            $("#office_div1").append('<label class="dropdown-item cafe_office">' + office + '</label>');
//         });
       $(document).on("click", ".dropdown-item.cafe_area", function() {
         var selName = $(this).text();
         var selVal = $(this).attr("value");
         $("#areaBtn").text(selName);
         $.get("${pageContext.request.contextPath}/map"
                    ,{act:"gugun", sido:selVal}
                    ,function(data, status){
                       $("#office_div1").empty();
                      $.each(data, function(index, vo) {
                       $("#office_div1").append('<label class="dropdown-item cafe_office" value="'+vo.gugun_code+'">'+vo.gugun_name+'</label>');
                       });//each
                    }//function
                    , "json"
              );//get
           });
       
       $(document).on("click", ".dropdown-item.cafe_office", function() {
            var selName = $(this).text();
            var selVal = $(this).attr("value");
            $("#officeBtn1").text(selName);
            $.get("${pageContext.request.contextPath}/map"
                       ,{act:"dong", gugun:selVal}
                       ,function(data, status){
                          $("#office_div").empty();
                         $.each(data, function(index, vo) {
                          $("#office_div").append('<label class="dropdown-item cafe_office1">'+vo.dong+'</label>');
                          });//each
                       }//function
                       , "json"
                 );//get
              });
      
      $(document).on("click", ".dropdown-item.cafe_office1", function() {
         var selOffice = $(this).text();
         $("#officeBtn").text(selOffice);
         
         $.get("${pageContext.request.contextPath}/map"
                     ,{act:"apt", dong:selOffice}
                     ,function(data, status){
                        $("#searchResult").empty();
                        $.each(data, function(index, vo) {
                           let str = "<tr class="+colorArr[index%3]+">"
                           + "<td>" + vo.no + "</td>"
                           + "<td>" + vo.dong + "</td>"
                           + "<td>" + vo.aptName + "</td>"
                           + "<td>" + vo.jibun + "</td>"
                           + "<td>" + vo.code
                           + "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
                           $("#searchResult").append(str);
                           $("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
                        });//each
                        geocode(data);
                     }//function
                     , "json"
               );//get
               
               
               $.get("${pageContext.request.contextPath}/map"
                        ,{act:"house", dong:selOffice}
                        ,function(data, status){
                           $("#searchre").empty();
                           $.each(data, function(index, vo) {
                              let str = "<tr class="+colorArr[index%3]+">"
                              + "<td>" + (index+1) + "</td>"
                              + "<td>" + vo.dong + "</td>"
                              + "<td>" + vo.buildingName + "</td>"
                              + "<td>" + vo.buildYear + "</td>"
                              + "<td>" + vo.dealAmount
                              + "만원</td><td>"+vo.area+"평</td><td>"+vo.floor+"층</td></tr>";
                              $("#searchre").append(str);
                              $("#searchre").append(vo.dong+" "+vo.roadname+" "+vo.buildingName+"<br>");
                           });//each
                        }//function
                        , "json"
                  );//get
      });
      function geocode(jsonData) {
            let idx = 0;
            deleteMarkers();
            $.each(jsonData, function(index, vo) {
               let tmpLat;
               let tmpLng;
               $.get("https://maps.googleapis.com/maps/api/geocode/json"
                     ,{   key:'AIzaSyC1evnKYA-lY7SfC1XwsH5goNbDFF_wFto'
                        , address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
                     }
                     , function(data, status) {
                        //alert(data.results[0].geometry.location.lat);
                        tmpLat = data.results[0].geometry.location.lat;
                        tmpLng = data.results[0].geometry.location.lng;
                        $("#lat_"+index).text(tmpLat);
                        $("#lng_"+index).text(tmpLng);
                        addMarker(tmpLat, tmpLng, vo.aptName, vo.jibun);
                     }
                     , "json"
               );//get
            });//each
         }
      
   });
   
   function callHouseDealInfo(aptName,jibun) {
      $.get("${pageContext.request.contextPath}/map"
              ,{act:"apt2", apt:aptName, jibun:jibun}
               ,function(data, status){
                  $("#searchResult").empty();
                  $.each(data, function(index, vo) {
                     let str = "<tr class="+colorArr[index%3]+">"
                      + "<td>" + index + "</td>"
                      + "<td>" + vo.dong + "</td>"
                      + "<td>" + vo.aptName + "</td>"
                      + "<td>" + vo.jibun + "</td>"
                      + "<td>" + vo.dealAmount
                      + "만원</td><td>"+vo.area+"평</td><td>아파트 매매</td></tr>";
                      $("#searchResult").append(str);
                      $("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
                  });//each
               }//function
               , "json"
         );//get
    }
   
   
   
   </script>
    </head>
    <body id="page-top">
    <c:set value="${pageContext.request.contextPath }" var="root" scope="session"></c:set>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top">
                <!-- 여기가 로고 넣는 위치 -->
                </a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ml-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                       <!-- 0. 로그인 가능한지 ? 회원 가입 가능 한지 체크해보기 : id : ssafy , pw : ssafy , name : ssafy , email : ssafy 로 test -->
                    <!-- 1. session 값이 uiserid Null 이 아니라면, login 값은 logout 으로 바뀌고, register 대신 회원정보 보기 로 바꿔어야 할듯  -->
                    <!-- 2. logout 누르면 -> 해당 process 실행 //  -->
                    <!-- 3. 회원정보 보기 버튼 누르면 -> select 로 로그인 정보 받아온 후에 , edit + delete 할 수 있는 화면으로 이동   -->
                    
                    <!-- 로그인이 안되어 있을 경우 -->
                    <c:if test="${loginId eq null}">
                       <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root }/Member_control/login_page">login</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root }/Member_control/register_page">Register</a></li>
                    </c:if>
                    <!-- 로그인이 되어있는 경우 -->
                    <c:if test="${loginId != null}">
                       <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root }/Member_control/logout">Logout</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root }/Member_control/Edit_info_page">Edit_Info</a></li>
                    
                    </c:if>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services">지도</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio">주택관련기사</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">SSAFY 4기 소식</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#team">사이트 개발자</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact">공지사항</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead">
<!--             <div class="container"> -->
                <div class="masthead-subheading">행복한 우리집</div>
                <div class="masthead-heading text-uppercase">Happy House</div>
                <a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" href="#services">바로 찾기</a>
            </div>
        </header>
        <!-- Services-->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
            <div class="dropdown">
               <div class="btn-group">
                   <button type="button" id="areaBtn" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">도/광역시</button>
                   <div class="dropdown-menu" id="sido">
                   </div>
                 </div>
                 <div class="btn-group">
                   <button type="button" id="officeBtn1" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">시/구/군</button>
                   <div id="office_div1" class="dropdown-menu"></div>
                 </div>
                 <div class="btn-group">
                   <button type="button" id="officeBtn" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">동</button>
                   <div id="office_div" class="dropdown-menu"></div>
                 </div>
            </div>
         </div>
         <div class="row">
         <div class="col-lg-12">
         <div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
         </div>
         </div>
            <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
            <script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1evnKYA-lY7SfC1XwsH5goNbDFF_wFto&callback=initMap"></script>
         <script>
            var multi = {lat: 37.5012743, lng: 127.039585};
            var map;
            var markers = [];
            var infoWindow;
            
            function initMap() {
               map = new google.maps.Map(document.getElementById('map'), {
                        center: multi, zoom: 12
                     });
                     var marker = new google.maps.Marker({position: multi, map: map});
               
               const myposition = "img/my_position.png"; // 마이포지션이라는 이미지를 설정 (마크모양)
               
               /*
               //멀티캠퍼스
               //const multimarker = new google.maps.Marker({coords: multi, content: '멀티캠퍼스', iconImage: myposition});
               var multimarker = {
                     coords: multi,
                     iconImage: myposition,
                     content: '멀티캠퍼스(역삼)'
               };
               addMarker(multimarker);
               infoWindow.setPosition(multi);
               infoWindow.setContent('멀티캠퍼스.');
               infoWindow.open(map);
            }
            */
               
               // Geolocation
               infoWindow = new google.maps.InfoWindow;
                console.log(4 * 5);
               if (navigator.geolocation) {
               
                  navigator.geolocation.getCurrentPosition(function(position) {
                     console.log(4 * 5);
                     var pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                     };
                     var mymarker = {
                           coords: pos,
                           iconImage: myposition,
                           content: '현재위치'
                     };
                     
                     addMarker(mymarker);
                     infoWindow.setPosition(pos);
                     infoWindow.setContent('현재 당신의 위치입니다. 원하는 동을 눌러주세요');
                     infoWindow.open(map);
                     map.setCenter(pos);
                  });//, function() {
                  //   handleLocationError(true, infoWindow, map.getCenter());
                  //});
               } else {
                  handleLocationError(false, infoWindow, map.getCenter());
               }
            }
            
            function handleLocationError(browserHasGeolocation, infoWindow, pos) {
               infoWindow.setPosition(pos);
               infoWindow.setContent(browserHasGeolocation ?
                  'Error: Geolocation 서비스 실패.' :
                  'Error: Geolocation을 지원하지 않는 브라우저.');
               infoWindow.open(map);
            }
            
            //geolocation  여기까지
            
            function addMarker(tmpLat, tmpLng, aptName,jibun) {
               const marker = new google.maps.Marker({
                  position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
                  map: map
               });
               map.setCenter(marker.getPosition());
               map.setZoom(15);
               
               marker.addListener('click', function() {
                  map.setZoom(17);
                  map.setCenter(marker.getPosition());
                  bounceMarker(marker);
                  callHouseDealInfo(aptName,jibun);
               });
               markers.push(marker);
               setMapOnAll(map);
            }
            
            function bounceMarker(marker) {
               if (marker.getAnimation() !== null) {
                  marker.setAnimation(null);
               } else {
                  marker.setAnimation(google.maps.Animation.BOUNCE);
               }
            }
            
            function deleteMarkers() {
               clearMarkers();
               markers = [];
            }
            
            function clearMarkers() {
               setMapOnAll(null);
            }
            
            function setMapOnAll(map) {
               for (let i = 0; i < markers.length; i++) {
                  markers[i].setMap(map);
               }
            }
         </script>
            </div>
            <div>
            <div class="container">
               <div class="text-center">
               <h2>아파트 거래 정보</h2>
               <table class="table mt-1">
                  <thead>
                     <tr>
                     <th style="color: black;">번호</th>
                     <th style="color: black;">법정동</th>
                     <th style="color: black;">아파트이름</th>
                     <th style="color: black;">지번</th>
                     <th style="color: black;">지역코드/매매가</th>
                     <th style="color: black;">위도/평수</th>
                     <th style="color: black;">경도/분류</th>
                     </tr>
                  </thead>
                  <tbody id ="searchResult"> <!--  추가한 부분 -->
                  </tbody>
               </table>
            </div>
         </div>
         </div>
        </section>
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
<!--                <div class="text-center"> -->
<!--                     <h2 class="section-heading text-uppercase">주택 거래 정보</h2> -->
<!--                     <h3 class="section-subheading text-muted">최근의 주택 관련 기사로 좋은 집을 찾는데 도움을 줍니다.</h3> -->
<!--                 </div> -->
                <div>
<!--                <table class="table mt-1"> -->
<!--                <thead> -->
<!--                   <tr> -->
<!--                      <th style="color: black;">번호</th> -->
<!--                      <th style="color: black;">법정동</th> -->
<!--                      <th style="color: black;">주택이름</th> -->
<!--                      <th style="color: black;">준공년도</th> -->
<!--                      <th style="color: black;">매매가</th> -->
<!--                      <th style="color: black;">평수</th> -->
<!--                      <th style="color: black;">층수</th> -->
<!--                   </tr> -->
<!--                </thead> -->
<!--                <tbody id ="searchre"> -->
<!--                </tbody> -->
<!--             </table> -->
            </div>
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">주택관련기사</h2>
                    <h3 class="section-subheading text-muted">최근의 주택 관련 기사로 좋은 집을 찾는데 도움을 줍니다.</h3>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal1">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/skyview.PNG" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">주택 종부세 납세자 28%...</div>
                                <div class="portfolio-caption-subheading text-muted">동아일보</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal2">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/portfolio/02-thumbnail.jpg" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">2022년까지 ‘공급절벽’…</div>
                                <div class="portfolio-caption-subheading text-muted">국민일보</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal3">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/portfolio/03-thumbnail.jpg" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">LH, 유턴기업 지원한다…</div>
                                <div class="portfolio-caption-subheading text-muted">뉴시스</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4 mb-lg-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal4">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/portfolio/04-thumbnail.jpg" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">‘방 3개가 전부가 아니다’…</div>
                                <div class="portfolio-caption-subheading text-muted">헤럴드경제</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4 mb-sm-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal5">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/portfolio/05-thumbnail.jpg" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">종부세 서울 39만명 '최다'···</div>
                                <div class="portfolio-caption-subheading text-muted">서울경제</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal6">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${root }/assets/img/portfolio/06-thumbnail.jpg" alt="" />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">'호텔 개조 임대' 11·19 ···</div>
                                <div class="portfolio-caption-subheading text-muted">한국일보</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About-->
        <section class="page-section" id="about">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">SSAY 4기 소식</h2>
                    <h3 class="section-subheading text-muted">오늘은 무슨 일이 있는 지 알아봅시다.</h3>
                </div>
                <ul class="timeline">
                    <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="${root }/assets/img/about/1.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h4>2020.11.27</h4>
                                <h4 class="subheading">★퇴실체크&오후건강설문★</h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted">홍승길님 퇴실체크 및 설문조사 해주세요~</p></div>
                        </div>
                    </li>
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="${root }/assets/img/about/2.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h4>2020.11.27</h4>
                                <h4 class="subheading">★입실체크 및 설문조사진행★</h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted">윤형준, 전혜린, 송승연님 입실체크 및 설문조사 해주세요~</p></div>
                        </div>
                    </li>
                    <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="${root }/assets/img/about/3.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h4>2020.11.25</h4>
                                <h4 class="subheading">♥Thanks to ○○○♥</h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"></p>커뮤니티>열린게시판>학습서포터추천 많관부</div>
                        </div>
                    </li>
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="${root }/assets/img/about/4.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h4>2020.11.24</h4>
                                <h4 class="subheading">온라인 학습 전환</h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"></p>11/24~27 온라인 학습 전환(공지사항 확인)</div>
                        </div>
                    </li>
                    <li class="timeline-inverted">
                        <div class="timeline-image">
                            <h4>
                                4기
                                <br />
                                충전!
                            </h4>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
        <!-- Team-->
        <section class="page-section bg-light" id="team">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">사이트 개발자</h2>
                    <h3 class="section-subheading text-muted">행복한 집을 만들기 위해 노력합니다.</h3>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="team-member">
                            <img class="mx-auto rounded-circle" src="${root }/assets/img/noname.jpg" alt="" />
                            <h4>윤형준</h4>
                            <p class="text-muted">SSAFY</p>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="team-member">
                            <img class="mx-auto rounded-circle" src="${root }/assets/img/noname.jpg" alt="" />
                            <h4>유진영</h4>
                            <p class="text-muted">SSAFY</p>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center"><p class="large text-muted">우리는 HappyHouse 서비스를 제공하기 위해 최선을 다합니다.</p></div>
                </div>
            </div>
        </section>
        <!-- Clients-->
        <div class="py-5">
        </div>
        <!-- Contact-->
        <section class="page-section" id="contact">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">공지사항</h2>
                    <h3 class="section-subheading text-muted">공지할 내용이 적혀 있는 곳입니다.</h3>
                </div>
                <table class="table table-bordered">
    <thead>
      <tr>
        <th>공지번호</th>
        <th>작성자</th>
        <th>공지내용</th>
      </tr>
    </thead>
    <tbody>
      <tr class="info">
        <td>1</td>
        <td>관리자</td>
        <td>로그인 기능이 업데이트 되었습니다.</td>
      </tr>      
      <tr class="success">
        <td>2</td>
        <td>관리자</td>
        <td>아파트 거래 정보를 업데이트 중입니다. </td>
      </tr>
      <tr class="info">
        <td>3</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr class="success">
        <td>4</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr class="info">
        <td>5</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr class="success">
        <td>6</td>
        <td>-</td>
        <td>-</td>
      </tr>
    </tbody>
  </table>
  
            </div>
        </section>
        <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-left">Copyright © HappyHouse 2020</div>
                    <div class="col-lg-4 my-3 my-lg-0">
                        <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <div class="col-lg-4 text-lg-right">
                        <a class="mr-3" href="#!">Privacy Policy</a>
                        <a href="#!">Terms of Use</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Portfolio Modals-->
        <!-- Modal 1-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">올해 주택 종부세 납세자 28%, 세액 43% 급증</h2>
                                    <p class="item-intro text-muted">66만7000명에 1조8148억원 부과</p>
                                    <p class="item-intro text-muted">현정부 들어 종부세 납세자-세액 각각 2.2배, 2.5배로 크게 늘어나</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/skyview.PNG" alt="" />
                                    <p>올해 종합부동산세 납부 인원과 세액이 1년 전보다 25%가량 늘어 역대 최대치를 나타냈다. 이로써 현 정부 들어 납세자와 세액 모두 2배 이상으로 증가했다. 집값 안정과 투기 방지를 위해 종부세를 도입했지만 집 한 채 있는 중산층까지 징세 대상에 포함되고 있다는 지적이 나온다.25일 국세청에 따르면 올해 종부세 납세 대상자는 74만4000명으로 지난해보다 25.0%(14만9000명) 늘었다. 이들에게 고지한 세액은 4조2687억 원으로 1년 전보다 27.5%(9216억 원) 증가했다. 현 정부 출범 전인 2016년 종부세 납부 대상과 세액은 각각 33만9000명, 1조7180억 원이었다. 이번 정부 들어 종부세 납세자는 2.2배로, 세금은 2.5배로 늘어난 셈이다. 특히 주택분 종부세 증가세가 두드러졌다. 올해 주택분 종부세 납세 대상은 66만7000명으로 1년 전보다 28.3% 늘었고, 세액은 1조8148억 원으로 42.9% 증가했다. 이는 집값과 공시가격이 크게 오른 데다 종부세 계산에 쓰이는 ‘공정시장가액비율’ 상향 조정까지 겹쳤기 때문이다. 주택분 종부세 납세자가 서울에서만 1년 새 9만5000명 늘어나는 등 그동안 종부세를 내지 않았던 1주택자들이 과세 대상에 포함되면서 전체 세액이 늘었다.</p>
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.26</li>
                                        <li>URL: <a href="https://www.donga.com/news/Economy/article/all/20201126/104152296/1">https://www.donga.com/news/Economy/article/all/20201126/104152296/1</a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 2-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">2022년까지 ‘공급절벽’ 이어져… 현 정부 임기 내내 집값 오를 듯</h2>
                                    <p class="item-intro text-muted">국토연, ‘수도권 주택공급’ 보고서… 집값 폭등·전세난 대책 효과 미미</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/portfolio/02-full.jpg" alt="" />
                                    <p>향후 2년간 수도권 신규 주택 공급 감소 추세가 이어진다는 국책연구기관의 분석이 나왔다. 정부가 수도권 집값 폭등과 전세난에 연이어 대책을 내놨지만 단기 파급 효과가 미미하다는 것이다. 아파트를 중심으로 한 주택 공급은 2023년에야 원활해지는 것으로 나와 현 정부 임기 동안에는 집값 상승세가 이어질 전망이다. 실수요자의 고통이 쉽게 끝나지 않는다는 얘기다. 당분간은 수도권 지역의 ‘공급 절벽’을 피해가기 힘들 것으로 보인다. 국토연구원이 25일 발간한 ‘수도권 중장기 주택공급 전망과 시사점’ 보고서는 주택 인허가 실적 감소에 주목했다. 국토교통통계누리에 따르면 2015년에 76만5000가구로 정점을 찍었던 주택 인허가 실적은 2016년부터 내리막이다. 지난해에는 48만8000가구까지 떨어졌다. 중심에는 수도권이 있다. 수도권의 주택 인허가 실적은 2015년 40만9000가구를 찍은 뒤 지난해 27만2000가구까지 급감했다.</p>
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.26</li>
                                        <li>URL: <a href="http://news.kmib.co.kr/article/view.asp?arcid=0924166701&code=11151500">http://news.kmib.co.kr/article/view.asp?arcid=0924166701&code=11151500</a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 3-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">LH, 유턴기업 지원한다…맞춤형 입지 컨설팅</h2>
                                    <p class="item-intro text-muted">코트라·산업단지공단과 업무협약</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/portfolio/03-full.jpg" alt="" />
                                    <p>한국토지주택공사(LH)는 26일 코트라(대한무역투자진흥공사·KOTRA), 한국산업단지공단(산단공)과 해외진출기업의 국내복귀 지원을 위한 업무협약(MOU)을 체결했다고 밝혔다. 최근 신종 코로나바이러스 감염증(코로나19) 확산으로 전 세계적으로 해외 진출 기업이 자국으로 돌아오는 유턴 현상이 심화되고 있는 상황이다. 우리 정부 또한 최근 관련 법령을 개정해 유턴기업 보조금 한도를 기존 기업별 100억원에서 최대 600억원(사업장별 300억원)으로 대폭 늘리고 '20인 이상 상시 고용' 요건을 폐지하는 등 유턴기업에 대한 지원을 확대해 나가고 있다. 이번 협약은 산업단지 입주지원 등 다양한 입지정보를 제공할 수 있는 LH와 유턴기업 지원을 전담하는 코트라, 유턴보조금 지원업무를 담당하는 산단공이 함께 유턴기업의 사업장 입지 물색을 도와 성공적인 국내정착을 돕고, 유턴 활성화에 기여하기 위해 추진됐다.</p>
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.26</li>
                                        <li>URL: <a href="https://newsis.com/view.html?ar_id=NISX20201126_0001247911">https://newsis.com/view.html?ar_id=NISX20201126_0001247911</a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 4-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">‘방 3개가 전부가 아니다’…임대주택 강조한 정부에 “세입자 현실 전혀 모른다” 불만 터져나와[부동산360]</h2>
                                    <p class="item-intro text-muted">정부, 신축 매입임대 품질 개선 강조…넓은 평형·고급 옵션 도입</p>
									<p class="item-intro text-muted">시장은 “인프라가 더 중요” 불만</p>
									<p class="item-intro text-muted">전문가들 “품질 높여도 주변 환경 열악하면 입주 꺼릴것</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/portfolio/04-full.jpg" alt="" />
                                    <p>정부가 다세대 매입임대 중심의 전세대책을 발표해 신축 매입임대의 품질 개선을 강조하고 나섰지만, 시장에서는 세입자들의 현실을 제대로 알지 못하는 것이라는 비판이 나온다. 아파트 전월세를 선호하는 것은 단순히 주택 품질이 아니라 교육환경과 교통, 주차, 보안, 상가 등 주변 환경 영향이 더 크다는 지적이다. 23일 국토교통부에 따르면, 이번 전세 대책의 전체 공급 물량 11만4000가구 중 아파트는 3만 가구로 나머지 8만4000가구는 다세대나 오피스텔 등이다. 정부는 공사가 오래 걸리는 아파트는 단시간에 전세수급을 안정화하는 데 적합하지 않다고 밝혔다. 대신 기존과 달리 넓은 평형에 고급 옵션과 지하주차장을 도입한 양질의 다세대가 어려움을 겪는 전세 수요자에게 아파트의 대체제가 될 수 있다는 입장이다.하지만 전월세 수요자들 사이에서는 “육아와 출퇴근으로 교육환경·교통 등 인프라가 중요한 세입자들의 고충을 전혀 모른다”는 불만의 목소리가 커지고 있다. 실제 정부가 그동안 다가구·다세대를 활용한 임대 공급을 확충했지만 열악한 주변 환경 등을 이유로 공실이 상당수 발생했다. 현재 전국 공공임대 중 3개월 이상 공실인 주택은 3만9100가구에 이른다. 전문가들도 다세대 주택이 아파트 수요를 흡수하는 데는 한계가 있다고 입을 모은다.</p>
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.23</li>
                                        <li>URL: <a href="http://news.heraldcorp.com/view.php?ud=20201123000269">http://news.heraldcorp.com/view.php?ud=20201123000269</a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 5-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">종부세 서울 39만명 '최다'…1인당 세액은 경남 1,361만원 '최고'</h2>
                                    <p class="item-intro text-muted">종부세 고지 인원 81%가 서울·경기 거주</p>
                                    <p class="item-intro text-muted">서울 1인당 평균 세액 302만원…8% 올라</p>
                                    <p class="item-intro text-muted">장기보유·고령자 공제땐 稅 최대 70% 줄어</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/portfolio/05-full.jpg" alt="" />
                                    <p>공시가 상승 등으로 강남 3구 등에서 작년의 2배 넘는 종합부동산세(종부세) 고지서가 쏟아졌지만 같은 가격의 아파트라도 1세대 1주택자는 보유기간과 연령에 따라 종부세 부담이 70%까지 낮아진다. 국세청이 25일 올해 종부세 고지 내역을 발표하면서 내놓은 사례들을 보면 올해 초 ‘영혼까지 끌어모은’ 대출로 공시가격 16억5,000만원 아파트를 취득한 39세 A씨의 종부세는 271만원이다. 이에 비해 같은 가격의 아파트를 15년 보유한 75세 B씨의 종부세는 81만원이다. 장기보유 공제와 고령자 공제를 합쳐 70% 세액공제를 받았기 때문이다. 공시가격이 38억4,000만원으로 같은 주택을 가진 C씨(49)와 D씨(85)도 종부세가 각각 2,058만원과 705만원으로 고지됐다. C씨는 보유기간이 5년 미만이어서 아무런 공제를 받지 못했지만 D씨는 B처럼 70% 세액공제를 적용받았다.
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.26</li>
                                        <li>URL: <a href="https://www.sedaily.com/NewsVIew/1ZAK2AJS04">https://www.sedaily.com/NewsVIew/1ZAK2AJS04</a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 6-->
        <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="${root }/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">'호텔 개조 임대' 11·19 전세대책…국민 절반 이상 "효과 없을 것"</h2>
                                    <p class="item-intro text-muted">리얼미터 여론조사…긍정 39.4% vs 부정 54.1%</p>
                                    <img class="img-fluid d-block mx-auto" src="${root }/assets/img/portfolio/06-full.jpg" alt="" />
                                    <p>정부가 전세난 해결을 위해 '호텔 개조 임대'를 포함해 2년간 전세형 공공주택 11만4,000여 가구를 공급하겠다며 내놓은 11·19 전세대책을 두고 국민 2명 중 1명 이상은 '효과가 없을 것'이라고 전망한다는 여론조사 결과가 23일 나왔다. 여론조사 전문기관 리얼미터가 YTN 의뢰에 따라 전국 18세 이상 성인 500명(표본오차 95% 신뢰수준에서 ±4.4%포인트)을 대상으로 20일 실시해 이날 발표한 조사 결과, '효과가 없을 것'이라는 부정적인 응답이 54.1%로 집계됐다. 세부적으로는 '전혀 효과 없을 것'이 28.0%, '별로 효과 없을 것'이 26.1%로 나타났다. 반면 '효과가 있을 것'이라고 긍정적으로 응답한 이는 39.4%였다. 이 응답 중 '매우 효과 클 것'은 12.6%, '어느 정도 효과 있을 것'은 26.8%였다. '잘 모르겠다'는 답변은 6.5%로 나왔다. 지역별로 서울(긍정 47.1%·부정 46.6%)에서는 의견이 팽팽하게 갈렸고, 수도권인 인천·경기(32.2%·66.2%)에서는 부정적 여론이 긍정적 여론의 두배 이상을 기록했다. 대구·경북(22.9%·61.4%), 대전·세종·충청(41.9%·53.2%), 부산·울산·경남(39.8%·52.9%)에선 부정 답변이, 광주·전라(59.5%·30.6%)에서는 긍정 답변이 더 많았다.</p>
                                    <ul class="list-inline">
                                        <li>Date: 2020.11.23</li>
                                        <li>URL: <a href=""></a></li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button">
                                        <i class="fas fa-times mr-1"></i>
                                        Close News
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="${root }/assets/mail/jqBootstrapValidation.js"></script>
        <script src="${root }/assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="${root }/js/scripts.js"></script>
    </body>
</html>