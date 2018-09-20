<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shopping Online</title>
  
      <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
      <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
      <script src="${cp}/js/layer.js" type="text/javascript"></script>
   
    <style>
    .title{
    text-align:center;
    font-family: sans-serif;
    }
    .form-title{
    text-align:center;
    font-family: sans-serif;
    }
    .form-box{
     text-align:center;
     font-family: sans-serif;
    }
    </style>
  </head>
  
  
  <body>
   
    <jsp:include page="include/header.jsp"/>

    <div style="padding-top: 80px;padding-bottom: 80px" >

        <h2 class="title">Login Here</h2>
        <br/>
        <div>
            <!-- Form -->
            <div class="form-title">
                <div>
                    <label for="inputEmail" >Email</label>
                    <div>
                        <input type="text" id="inputEmail" placeholder="Enter your Email"/>
                    </div>
                </div>
                <div>
                    <label for="inputPassword">Password</label>
                    <div>
                        <input type="password" id="inputPassword" placeholder="At least 6 character" />
                    </div>
                </div>
                <div>
                    <div>
                        <button  type="submit" onclick="startLogin()">Login</button>
                    </div>
                </div>
            </div>
            <br/>
        </div>
    </div>

    <jsp:include page="include/foot.jsp"/>

    <script type="text/javascript">
        function startLogin() {
            var loading = layer.load(0);
            var user = {};
            var loginResult = "";
            user.userNameOrEmail = document.getElementById("inputEmail").value;
            user.password = document.getElementById("inputPassword").value;
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/doLogin',
                data : user,
                dataType : 'json',
                success : function(result) {
                    loginResult = result.result;
                    layer.close(loading);
                },
                error : function(result) {
                    layer.alert('Search Error');
                }
            });

            if(loginResult == 'success'){
                layer.msg('Succeed',{icon:1});
                window.location.href = "${cp}/main";
            }
            else if(loginResult == 'unexist'){
                layer.msg('Error username',{icon:2});
            }
            else if(loginResult == 'wrong'){
                layer.msg('wrong password',{icon:2});
            }
            else if(loginResult == 'fail'){
                layer.msg('Error',{icon:2});
            }

        }
    </script>

  </body>
</html>