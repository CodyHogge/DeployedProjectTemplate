<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:if test="${role ne 'ADMIN' && role ne 'DBA'}">
<c:redirect url="/accessdenied"/>
</c:if>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- font awesome -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

</head>
<body>
	<jsp:include page="components/header.jsp" />
	<br>
	<div class="container mt-5">
		<div class="col-lg-10 text-center ">
			<h3>${welcomeMessage}</h3>
			<h3>${msg}</h3>
			<p>Users</p>
			
		<form class="form-inline" action="customSearchUser" method="post" class="col-md-5">
			<input id="searchnow" class="form-control mr-sm-2" type="text" name="name" placeholder="Name">
			<input class="form-control mr-sm-2" type="email" name="email" placeholder="E-Mail">
			<button class="btn btn-success" type="submit">Search</button>
		</form>
			
			
			
			<table class="table">
				<tr class="text-info">
					<th>#</th>
					<th>Name</th>
					<th>Email</th>
					<th>Roles</th>
					<th>Action</th>
				</tr>
				<c:forEach var="item" items="${list}">
					<tr class="text-body">
						<td>${list.indexOf(item)+1}.</td>
						<td>${item.firstName} ${item.lastName}</td>
						<td>${item.email}</td>
						<td>
							<form method="POST" action="editrole">
								<input type="hidden" name="id" value="${item.id}" /> <select
									onchange="this.form.submit()" name="role" class="form-control">
									<option value="${item.role}">${item.role}</option>
									<option value="USER">USER</option>
									<option value="DBA">DBA</option>
									<option value="ADMIN">ADMIN</option>
								</select>
							</form>
						</td>
						<td>
						<a href="removeuser?id=${item.id}"
							onclick="confirmed(); return false;"
							title="Delete member ${item.firstName} ${item.lastName}"
							class="btn btn-danger"> <i class="fa fa-trash"></i>
						</a>
						 <a href="#" data-toggle="modal" data-target="#edits${item.id}" class="btn btn-secondary"><i class="fa fa-pencil"></i>
						 </a>
						</td>
						
					</tr>
				</c:forEach>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	
	
	
	
	
	<div class="modal fade" id="edits">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-">Update Info</h5>
					<button type="button" data-dismiss="modal" aria-label="Close"
						class="close">
						<span aria- hidden="true">×</span>
					</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form:form action="updatemyinfo" modelAttribute="user"
						method="post">
						<div class="form-group">
							<label for="firstName">First Name</label>
							<form:input path="firstName" value="${user_account.firstName}"
								class="form-control" placeholder="First Name" />
							<form:input type="hidden" path="id" value="${user_account.id}" class="form-control" />
						</div>
						
						<div class="form-group">
							<label for="lastName">Last Name</label>
							<form:input path="lastName" value="${user_account.lastName}"
								class="form-control" placeholder="Last Name" />
						</div>
						<div>
							<button type="submit" class="btn btn-primary">
								<i class="fa fa-user"></i> Save
							</button>
							<button type="button" data-dismiss="modal" aria-label="Close"
								class="btn btn-danger">Close</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<script>
	    function confirmed(){
            if (confirm('You are about to delete, Do you want to proceed?')) {
                  document.getElementById("del").submit();
                  return true;
	            } else {
	               return false;
	            }
	         }
        	    
	    $("#searchnow").keyup(function () {
	        var value = this.value.toLowerCase().trim();

	        $("table tr").each(function (index) {
	            if (!index) return;
	            $(this).find("td").each(function () {
	                var id = $(this).text().toLowerCase().trim();
	                var not_found = (id.indexOf(value) == -1);
	                $(this).closest('tr').toggle(!not_found);
	                return not_found;
	            });
	        });
	    });	   
	    </script>
</body>
</html>
