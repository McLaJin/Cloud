<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "org.w3c.dom.Document,javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilder,
javax.xml.parsers.DocumentBuilderFactory,
org.w3c.dom.Document,
org.w3c.dom.Element,
org.w3c.dom.Node,
org.w3c.dom.NodeList"
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<% 
String ip = request.getHeader("X-FORWARDED-FOR"); 

//proxy 환경일 경우
if (ip == null || ip.length() == 0) {
    ip = request.getHeader("Proxy-Client-IP");
}

//웹로직 서버일 경우
if (ip == null || ip.length() == 0) {
    ip = request.getHeader("WL-Proxy-Client-IP");
}

if (ip == null || ip.length() == 0) {
    ip = request.getRemoteAddr() ;
}
String[] array = ip.split(":");

%>

    <title>주소로 장소 표시하기</title>
   <b><% out.println("접속 IP:" + array[0]); %></b><br> 
   <b><% out.println("검색한 IP:" + request.getParameter("ip")); %></b><br>
</head>
<body>
<%! private String ip ; %>



<%! private String addr; %>
<%
//String addr;
	String[] array2 = request.getParameter("ip").split(":");
			// 페이지 초기값 
		try{
			while(true){
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://whois.kisa.or.kr/openapi/whois.jsp?query="+array2[0]+"&key=[APIkey]&answer=xml"+page;
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				// root tag 
				doc.getDocumentElement().normalize();
				out.println("Root element :" + doc.getDocumentElement().getNodeName() + "<br>");
				
				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("netInfo");
				//System.out.println("파싱할 리스트 수 : "+ nList.getLength());
				
				
					Node nNode = nList.item(1);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;
						out.println("############################################<br>");
						//System.out.println(eElement.getTextContent());
							NodeList nlList = eElement.getElementsByTagName("orgName").item(0).getChildNodes();
	    					Node nValue = (Node) nlList.item(0);
	    					String getTagValue = nValue.getNodeValue();
							out.println("관리자  : " + getTagValue + "<br>");
							nlList = eElement.getElementsByTagName("addr").item(0).getChildNodes();
						    nValue = (Node) nlList.item(0);
						    getTagValue = nValue.getNodeValue();						    
							out.println("주소  : " + getTagValue + "<br>");
							addr = getTagValue;
						
					}	// for end
				
					
				
				nList = doc.getElementsByTagName("techContact");
				
				
					 nNode = nList.item(1);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;						
						//System.out.println(eElement.getTextContent());
							NodeList nlList = eElement.getElementsByTagName("email").item(0).getChildNodes();
	    					Node nValue = (Node) nlList.item(0);
	    					String getTagValue = nValue.getNodeValue();
	    					out.println("메일  : " + getTagValue + "<br>");
							nlList = eElement.getElementsByTagName("phone").item(0).getChildNodes();
						    nValue = (Node) nlList.item(0);
						    getTagValue = nValue.getNodeValue();
							out.println("연락처  : " + getTagValue + "<br>");
						
					}	// for end
				
	
					out.println("############################################<br>");
				
					break;
				
			}	// while end
			
		} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end

%>

<p style="margin-top:-12px">
    <em class="link">
        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
       
        </a>
    </em>
</p>
<div id="map" align="center" style="width:70%;height:450px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aa338f33091407ee52643dcb319d9ca2&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
<%--
var addr1 = "<%= addr %>";
--%>
var addr1 = "<% out.print(addr); %>";

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch( addr1, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">ip 위치</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<div>
		
		<form method="POST" action="search.do">
			<input type="text" name="ip" size="16" >

			 <input type="submit" value="확인">
		</form> 
	</div>
</body>
</html>
