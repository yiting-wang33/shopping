<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shopping Online</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
   
    <style>
    .head-text{
     
     font-family: sans-serif;
     text-align:right;
     padding-top:12px;
    }
    </style>
</head>
<body>
<!--nav-->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
      
         <a class="navbar-brand" href="${cp}/main">Shopping Online</a>

        <div class="head-text" id="bs-example-navbar-collapse-1">

            <ul>
                <c:if test="${empty currentUser}">
                    <a href="${cp}/register" methods="post">Sign up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    <a href="${cp}/login" methods="post">Login</a>
                </c:if>
                <c:if test="${not empty currentUser}">
                    <c:if test="${currentUser.role == 1}">
                        <li><a href="${cp}/control" methods="post">Console</a></li>
                    </c:if>
                        <a href="#" >${currentUser.nickName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                   
                            <a href="${cp}/shopping_car">Cart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                      
                            <a href="${cp}/amend_info">Edit profile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                            <a href="${cp}/doLogout">Log out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          
                </c:if>
            </ul>
                 </div>
    </div>
</nav>


</body>
</html>