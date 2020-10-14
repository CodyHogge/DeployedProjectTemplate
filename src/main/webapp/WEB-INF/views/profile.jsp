<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Simple Template - Contact</title>
<!-- CSS only -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

<!-- font awesome -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

</head>
<body>

<!-- Header -->
<jsp:include page="components/header.jsp"></jsp:include>
<br>

<h1 class="text-success mt-5">${welcomeMessage}</h1>

	<div class="container">
		<div class="col-lg-10 text-center ">
			<h3>${msg1}${resp}</h3>
			<h4 class="text-danger text-center">${error}</h4>
			<h3 class="text-success text-center">
			${msg} Welcome back ${user_account.firstName}
			<a href="#" data-toggle="modal" data-target="#edits"> <i class="fa fa-pencil"></i></a>
			</h3>

			<table class="table">
				<tr class="text-success">
					<th>Item</th>
					<th>Detail</th>
				</tr>
				<tr class="text-success">
					<td>First name</td>
					<td>${user_account.firstName}</td>
				</tr>
				<tr class="text-success">
					<td>Last Name</td>
					<td>${user_account.lastName}</td>
				</tr>
				<tr class="text-success">
					<td>Email</td>
					<td>${user_account.email}</td>
				</tr>
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



</body>
</html>