<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<meta charset="EUC-KR">
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">


function fncGetList(currentPage) {
	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
}


$(function(){
	var menu = "${menu}";
	var prod1 = 0;
	var prod2 = 0;
	var prod3 = 0;
	var prod4 = 0;
	var prod5 = 0;
	var prod6 = 0;
	var prod7 = 0;
	var prod8 = 0;
	var prodNo = 0;
	//alert(menu);
	
	$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
		//Debug..
		alert(  $( "td.ct_btn01:contains('검색')" ).html() );
		fncGetList(1);
	 });
	
	if( menu == 'search'){
		$("td.kod:nth-child(9n+3)").on("click", function(){
			//alert($(this).text().trim());
			prod1 = $(this).html().trim().charAt(7);
			prod2 = $(this).html().trim().charAt(8);
			prod3 = prod1.concat(prod2);
			prod4 = $(this).html().trim().charAt(9);
			prod5 = prod3.concat(prod4);
			prod6 = $(this).html().trim().charAt(10);
			prod7 = prod5.concat(prod6);
			prod8 = $(this).html().trim().charAt(11);
			prod9 = prod7.concat(prod8);
			var prodNo = prod9.trim();
			var prodName = $(this).text().trim();
			//alert(prodName);
			//alert(prodNo);
			//self.location ="/product/getProduct?prodNo="+prod9+"&menu=search";	
			////////////////////////////////////////////////////////
			
			$.ajax( 
				{
					url : "/product/json/getProduct/"+prodNo+"/"+menu ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {

						//Debug...
						//alert(status);
						//Debug...
						//alert("JSONData : \n"+JSONData);
						
						var displayValue = "<h3>"
												+"상품번호 : "+JSONData.prodNo+"<br/>"						
												+"상품명 : "+JSONData.prodName+"<br/>"
												+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
												+"제조일자 : "+JSONData.manuDate+"<br/>"
												+"가격 : "+JSONData.price+"<br/>"
												+"등록일자 : "+JSONData.regDate+"<br/>"
												+"상품이미지 : "+JSONData.fileName+"<br/>"
												+"</h3>";
						//Debug...									
						//alert(displayValue);
						$("h3").remove();
						$( "#"+prodName).html(displayValue);
					}
			});
			
			//////////////////////////////////////////////ajax 종료
		});
	}; ///////////menu=search 이프문 종료
	
	
	
	if( menu == 'manage'){
		$("td.kod:nth-child(9n+3)").on("click", function(){
			//alert($(this).text().trim());
			prod1 = $(this).html().trim().charAt(7);
			prod2 = $(this).html().trim().charAt(8);
			prod3 = prod1.concat(prod2);
			prod4 = $(this).html().trim().charAt(9);
			prod5 = prod3.concat(prod4);
			prod6 = $(this).html().trim().charAt(10);
			prod7 = prod5.concat(prod6);
			prod8 = $(this).html().trim().charAt(11);
			prod9 = prod7.concat(prod8);
			var prodNo = prod9.trim();
			var prodName = $(this).text().trim();
			//alert(prodName);
			//alert(prodNo);
			self.location ="/product/updateProduct?prodNo="+prodNo;	
			////////////////////////////////////////////////////////
		});
	}; ///////////menu=search 이프문 종료
	
	$( "td.addPurchase" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
		//alert( $(this).html().trim() );
		var prod = $(this).html().trim().split('"');
		var prodNo = prod[1];
		//alert(prodNo);
		self.location ="/purchase/addPurchase?prodNo="+prodNo;
	 });
	
});	



</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
					<c:if test = "${menu.equals('manage')}">
					상품관리
					</c:if>
					<c:if test = "${menu.equals('search')}">
					상품 목록 조회
					</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>	
			<option value="3"  ${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>가격높은순</option>
			<option value="4"  ${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>가격낮은순</option>
			</select>
			<input 	type="text" name="searchKeyword" 
			value="${! empty search.searchKeyword ? search.searchKeyword : "" }"  
			class="ct_input_g" style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!--<a href="javascript:fncGetList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
		<%--
		전체  <%= resultPage.getTotalCount() %> 건수,	현재 <%= resultPage.getCurrentPage() %> 페이지
		 --%>
		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${i}</td>
			<td></td>
		<td align="left" class="kod">
			<c:if test= "${menu.equals('manage')}">
			<a id="${product.prodNo}">${product.prodName}</a>
			</c:if>	
			<c:if test= "${menu.equals('search')}">
			<a id="${product.prodNo}=">${product.prodName}</a>
			</c:if>
			</td>
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
		<td align="left" class="addPurchase">
		<c:if test="${product.proTranCode.equals('0')}">
		<a id="${product.prodNo}">구매하기</a>
		</c:if>
		
		<c:if test="${menu.equals('manage') and product.proTranCode.equals('1') }">
		구매완료&nbsp;&nbsp;&nbsp;<a href="/purchase/updateTranCode?prodNo=${product.prodNo}&tranCode=${product.proTranCode}">배송하기</a>
		</c:if>
		
		<c:if test="${menu.equals('manage') and product.proTranCode.equals('2') }">
		배송중&nbsp;&nbsp;&nbsp;
		</c:if>
		
		<c:if test="${menu.equals('manage') and product.proTranCode.equals('3') }">
		배송완료&nbsp;&nbsp;&nbsp;
		</c:if>

		<c:if test="${menu.equals('search') and product.proTranCode.equals('1') }">
		재고없음&nbsp;&nbsp;&nbsp;
		</c:if>
		
		<c:if test="${menu.equals('search') and product.proTranCode.equals('2') }">
		재고없음&nbsp;&nbsp;&nbsp;
		</c:if>
		
		<c:if test="${menu.equals('search') and product.proTranCode.equals('3') }">
		재고없음&nbsp;&nbsp;&nbsp;
		</c:if>
		</td>
	</tr>
	<tr>
		<!--<td colspan="11" bgcolor="D6D7D6" height="1">  -->
		<td id="${product.prodName}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>

		    <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>

</div>
</body>
</html>