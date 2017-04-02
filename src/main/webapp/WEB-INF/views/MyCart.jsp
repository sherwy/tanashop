
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>ตะกร้าสินค้า</b>
<br />

<c:choose>
	<c:when test="${order!=null}">

		<form:form action="/confirmCart" method="POST"
			modelAttribute="orderList">


			<table class="table table-striped">
				<tr>
					<td>รหัสสินค้า</td>
					<td>รูปภาพ</td>
					<td>ชื่อสินค้า</td>
					<td>ราคา</td>
					<td>รายละเอียด</td>
					<td>จำนวน</td>
					<td></td>
				</tr>
				<form:hidden path="orderId" value="${order.orderId }" />
				<c:forEach items="${order.listProduct}" var="orderLine"
					varStatus="status">

					<tr>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productId">${orderLine.pk.product.productId }</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productId"
								value="${orderLine.pk.product.productId }" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.imgUrl"
								value="${orderLine.pk.product.imgUrl}">
								<img src="/Images/Products/${orderLine.pk.product.imgUrl}"
									width="100px" height="100px" />
								<form:hidden
									path="listProduct[${status.index }].pk.product.imgUrl"
									value="${orderLine.pk.product.imgUrl}" />
							</form:label></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productName">${orderLine.pk.product.productName}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.price">${orderLine.pk.product.price}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productDetail">${orderLine.pk.product.productDetail}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productDetail"
								value="${orderLine.pk.product.productDetail}" /></td>
						<td>
							<div class="row">
								<div class="col-md-8">
										${orderLine.pk.product.price} x
								</div>
								<div class="col-md-4">
									<form:input type="number" path="listProduct[${status.index }].amount"
										 min="1" max="${ orderLine.pk.product.amount}" value="1"  class="form-control"/>
								</div>
							</div>
						</td>
						<td><a
							href="<c:url value='/RemoveOutOfCart/${orderLine.pk.product.productId}' />"
							class="btn btn-danger" role="button">Delete</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">
						ราคารวม
					</td>
					<td><input type="text" disabled id="testAmount" value="0"/></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="7"><c:choose>
							<c:when test="${haveConfirmOrder == true }">
								<a href="<c:url value='#' />" class="btn btn-danger" disabled
									role="button">มีรายการค้างชำระเงินอยู่</a>

								<a href="<c:url value='/confirmPayment' />"
									class="btn btn-primary" role="button">ไปยังรายการแจ้งชำระเงิน</a>
							</c:when>
							<c:otherwise>
								<input type="submit" class="btn btn-primary"
									value="ยืนยันตะกร้า" />
							</c:otherwise>
						</c:choose></td>
				</tr>
			</table>
			
		</form:form>
	</c:when>
	<c:otherwise>
ไม่มีสินค้าในตะกร้า
</c:otherwise>
</c:choose>
<script>
$(document).ready(function(){
	$('input').change(function(){
		var totalAmount = 0;
		
		<c:forEach items="${order.listProduct}" var="orderLine" varStatus="status">
			var amount${status.index} = $('input#listProduct${status.index}\\.amount').val();
			var total${status.index} = (parseInt(${orderLine.pk.product.price}) *  parseInt(amount${status.index}));
			totalAmount += parseInt(total${status.index});
		</c:forEach>
		
		$('input#testAmount').val(totalAmount);
	});
});


</script>
<jsp:include page="../componant/footer.jsp" flush="true" />