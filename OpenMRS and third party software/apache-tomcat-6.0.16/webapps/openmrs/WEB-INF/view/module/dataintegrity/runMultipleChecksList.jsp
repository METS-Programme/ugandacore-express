<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Run Integrity Checks" otherwise="/login.htm" redirect="/module/dataintegrity/runMultipleChecks.list" />

<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>

<h2><spring:message code="dataintegrity.runMultipleChecks.link"/></h2>
<br />

<script type="text/javascript">
	function checkAll(field)
	{
		for (i = 0; i < field.length; i++) {
			field[i].checked = true ;
		}
	}
	
	function uncheckAll(field)
	{
		for (i = 0; i < field.length; i++) {
			field[i].checked = false ;
		}
	}

	function validateForm(field)
	{
		var errorDivPElement = document.getElementById("errorDivParameter");
		
		errorDivPElement.style.display = 'none';
		for (i = 0; i < field.length; i++) {
			if (field[i].checked == true) {
				var paramId = "checkParameterTxt" + i;
				if (document.getElementById(paramId) != null) {
					var parameterTxt = document.getElementById(paramId).textContent
					if (parameterTxt != '') {
						var tbId = "checkParameterValueTxt" + i;
						var parameterValue = document.getElementById(tbId).value;
						if (parameterValue == '') {
							errorDivPElement.style.display = '';
							return false;
						}
					}
				} else {
					continue;
				}
			}
		}
		return true;
	}

</script>

<div class="error" id="errorDivParameter" style="display: none"><spring:message code="dataintegrity.runSingleCheck.parameter.blank"/></div>
<b class="boxHeader"><spring:message code="dataintegrity.runMultipleChecks.title"/></b>
<form class="box" method="post" name="multipleCheckForm" onsubmit="return validateForm(document.multipleCheckForm.integrityCheckId)">
	<c:if test="${not empty runMultipleChecksList}">
	<table>
		<tr>
			<th></th>
			<th align="left"> <spring:message code="dataintegrity.checksList.columns.name"/> </th>
		</tr>
		<%int checkCount = 0; %>
		<c:forEach items="${runMultipleChecksList}" var="check">
			<tr>
				<td valign="top"><input type="checkbox" name="integrityCheckId" value="${check.id}"></td>
				<td align="left">${check.name}
					<c:if test="${check.checkParameters == null || check.checkParameters != ''}">
						<blockquote>
							<spring:message code="dataintegrity.runSingleCheck.parameters"/>
							<label id="<%="checkParameterTxt" + checkCount%>">${check.checkParameters}</label>
							<br />
							<br />
							<spring:message code="dataintegrity.runSingleCheck.parameterValues"/>
							<input type="text" value="" name="checkParameter${check.id}" id="<%="checkParameterValueTxt" + checkCount%>"/>
						</blockquote>
					</c:if>
				</td>
			</tr>
			<%checkCount++; %>
			</c:forEach>
		<tr>
			<td colspan="2">
				<table><tr>
					<td>
						<a href="#" onclick="checkAll(document.multipleCheckForm.integrityCheckId)"><spring:message code="dataintegrity.runMultipleChecks.selectAll"/></a>
					</td>
					<td>
						<a href="#" onclick="uncheckAll(document.multipleCheckForm.integrityCheckId)"><spring:message code="dataintegrity.runMultipleChecks.selectNone"/></a>
					</td>
				</tr></table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br />
				<input type="submit" value="<spring:message code="dataintegrity.runMultipleChecks.run"/>"/> 
			</td>
		</tr>
	</table>
	</c:if>
	
	<c:if test="${empty runMultipleChecksList}"><spring:message code="dataintegrity.checksList.empty"/></c:if>
</form>

<%@ include file="/WEB-INF/template/footer.jsp" %>