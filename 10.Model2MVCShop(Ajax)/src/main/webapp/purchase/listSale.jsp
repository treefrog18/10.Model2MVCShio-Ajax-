<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--EL/JSTL ������� �ּ�ó��
<%@ page import="java.util.List"  %>
<%@ page import="com.model2.mvc.service.domain.User" %>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.service.domain.Purchase" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>

<%
List<Purchase> list= (List<Purchase>)request.getAttribute("list");
Search search=(Search)request.getAttribute("search");
Page resultPage=(Page)request.getAttribute("resultPage");
//==> null �� ""(nullString)���� ����
String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
 --%>    

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listSale.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">�Ǹ� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
		<%--EL/JSTL
		��ü <%= resultPage.getTotalCount() %> �Ǽ�,	���� <%= resultPage.getCurrentPage() %> ������</td>
		 --%>
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
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<%--EL/JSTL ��� 
	<% 	
		for(int i=0; i<list.size(); i++) {
			Purchase purchase = list.get(i);
			<tr class="ct_list_pop">
		<td align="center">
		<a href="/getPurchase.do?tranNo=<%=purchase.getTranNo()%>"><%=i + 1%></a>
		</td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=<%=purchase.getBuyer().getUserId()%>"><%=purchase.getBuyer().getUserId()%></a>
		</td>
		<td></td>
		<td align="left"><%=purchase.getReceiverName()%></td>
		<td></td>
		<td align="left"><%=purchase.getReceiverPhone()%></td>
		<td></td>
		<td align="left">
			���� 
			<%System.out.println("Ʈ���ڵ尪:"+purchase.getTranCode()); 
			%>
			<%String trancode = "1"; 
				if(trancode.equals("1")){
					System.out.println("trancode�� ����="+trancode);
				}
			%>
			<%if((purchase.getTranCode()).equals("1")) {%>
			<%System.out.println("���ſϷ�"); %> 
			���ſϷ�
			<%} %>
			
			<%if((purchase.getTranCode()).equals("2")) {%> 
			�����
			<%} %>
			
			<%if((purchase.getTranCode()).equals("3")) {%> 
			��ۿϷ�
			<%} %>
			���� �Դϴ�.</td>
		<td></td>
		<td align="left">		
			<%if((purchase.getTranCode()).equals("2")) {%>
			<a href="/updateTranCode.do?tranNo=<%=purchase.getTranNo()%>&tranCode=<%=purchase.getTranCode()%>">���ǵ���</a>
			<%} %>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
</table>
	%>
	--%>
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list }">
		<c:set var="i" value="${i+1 }" />
		<tr class="ct_list_pop">
		<td align="center">
		<c:if test="${purchase.tranCode.equals('1')}">
		<a href="/getPurchase.do?tranNo=${purchase.tranNo}">${i}</a>
		</c:if>
		<c:if test="${purchase.tranCode.equals('2') || purchase.tranCode.equals('3')}">
		${i}
		</c:if>
		<%--<a href="/getPurchase.do?tranNo=${purchase.tranNo}">${i}</a> --%>
		</td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
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
			���� �Դϴ�.</td>
		<td></td>
		<td align="left">		
		<c:if test= "${purchase.tranCode.equals('1')}">
		<a href="/updateTranCode.do?tranNo=${purchase.tranNo}&tranCode=${purchase.tranCode}&menu=listSale">����ϱ�</a>
		</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
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