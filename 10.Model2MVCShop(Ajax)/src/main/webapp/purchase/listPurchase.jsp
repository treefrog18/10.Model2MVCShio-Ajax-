<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function(){
	
		$( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			//alert( $( this ).html().trim() );
			var tran = $( this ).html().trim().split('"');
			var tranNo = tran[1];
			alert(tranNo);	
			self.location ="/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			//alert( $( this ).html().trim() );
			var user = $( this ).html().trim().split('"');
			var userId = user[1];
			//alert(userId);	
			self.location ="/user/getUser?userId="+userId;
		});
		
		$( ".ct_list_pop td:nth-child(11)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			alert( $( this ).html().trim() );
			var tran = $( this ).html().trim().split('"');
			var tranNo = tran[1];
			alert(tranNo);	
			self.location ="/purchase/updateTranCode?tranNo="+tranNo;
		});
		
		
		$("td.getProduct").on("click", function(){
			//alert( $(this).html().trim() );		
			var prod = $(this).html().trim().split('"');
			var prodNo = prod[1];
			var menu = "search";
			//alert(prodNo);
			////////////�����񽺽���///////////
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
											+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"						
											+"��ǰ�� : "+JSONData.prodName+"<br/>"
											+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
											+"�������� : "+JSONData.manuDate+"<br/>"
											+"���� : "+JSONData.price+"<br/>"
											+"������� : "+JSONData.regDate+"<br/>"
											+"��ǰ�̹��� : "+JSONData.fileName+"<br/>"
											+"</h3>";
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$( "#"+prodNo+"k").html(displayValue);
						}
				});//////////����������

		});// �����δ�Ʈ��Ŭ�� ����

	});//$(fuction(){})����
	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
		��ü ${resultPage.totalCount } �Ǽ�,	���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list }">
		<c:set var="i" value="${i+1 }" />
		<tr class="ct_list_pop">
		<td align="center">
		<c:if test="${purchase.tranCode.equals('1')}">
		<a id="${purchase.tranNo}">${i}</a>
		</c:if>
		<c:if test="${purchase.tranCode.equals('2') || purchase.tranCode.equals('3')}">
		${i}
		</c:if>
		</td>
		<td></td>
		<td align="left">
			<a id="${purchase.buyer.userId}">${purchase.buyer.userId}</a>
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left" class="getProduct">
			<a id="${purchase.prodNo}">
			���� 
			<c:if test= "${purchase.tranCode.equals('1')}">
			���ſϷ�
			</c:if>
			<c:if test= "${purchase.tranCode.equals('2')}">
			�����
			</c:if>
			<c:if test= "${purchase.tranCode.equals('3')}">
			��ۿϷ�
			</c:if>
			���� �Դϴ�.
			</a>
			</td>
		<td></td>
		<td align="left">		
		<c:if test= "${purchase.tranCode.equals('2')}">
		<a id="${purchase.tranNo}">���ǵ���</a>
		</c:if>
		</td>
	</tr>
	<tr>
		<td id="${purchase.prodNo}k" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
</table>
<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<%--EL/JSTL
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetPurchaseList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetPurchaseList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetPurchaseList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %>
			 --%>
			 <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->
</form>

</div>

</body>
</html>