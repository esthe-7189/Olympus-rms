
CASTLE - JSP 버전 
------------

1. CASTLE을 적용하려면 아래와 같이 하십시오.

   각 페이지 첫줄에 

<%  String castleJSPVersionBaseDir = "CASTLE 설치 경로"; %>
<%@ include file = "/CASTLE 설치 경로/castle_policy.jsp" %>
<%@ include file = "/CASTLE 설치 경로/castle_referee.jsp" %>

   위의 세줄을 추가하시면 됩니다.

   특히 주의해야할 것은 DocumentRoot 이후의 경로를 적으셔야 합니다.
   ex) 톰캣 및 레진의 ROOT 디렉터리가 "/var/www/html"이고 
       /var/www/html/castle-jsp/ 에 CASTLE을 설치할 경우

<%  String castleJSPVersionBaseDir = "/castle-jsp"; %>
<%@ include file = "/castle-jsp/castle_policy.jsp" %>
<%@ include file = "/castle-jsp/castle_referee.jsp" %>

   위와 같이 추가하시면 됩니다.

   위에 대한 자세한 설명은 http://www.krcert.or.kr 홈페이지에서 확인하실 수
있습니다.
   
   감사합니다.

   - CASTLE 운영팀 - 

