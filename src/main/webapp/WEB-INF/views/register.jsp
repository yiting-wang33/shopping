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
    <!--[if lt IE 9]>
      <script src="${cp}/js/html5shiv.min.js"></script>
      <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
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

  
    <div >
        <h1 class="title">Register</h1>
        <br/>
        <div>
            <!-- Form -->
            <div class="form-title" >
                <div>
                    <label for="inputEmail">Username</label>
                    <div>
                        <input type="text" id="inputUserName" placeholder="No special character"/>
                    </div>
                </div>
                <div>
                    <label for="inputEmail" >Email</label>
                    <div>
                        <input type="email" id="inputEmail" placeholder="eatingw@qq.com"/>
                    </div>
                </div>
                <div>
                    <label for="inputNickname" >LastName</label>
                    <div>
                        <input type="text" id="inputNickname" placeholder="wang" />
                    </div>
                </div>
                <div>
                    <label for="inputPassword">Password</label>
                    <div>
                        <input type="password" id="inputPassword" placeholder="At least 6 characters" />
                    </div>
                </div>
                <div>
                    <label for="inputPhoneNumber" ">Cellphone</label>
                    <div>
                        <input type="text"  id="inputPhoneNumber" placeholder="6173730998" />
                    </div>
                </div>
                <div>
                    <label for="man">Gender</label>
                    <div>
                        <label>
                            <input type="radio" name="Gender" id="man" value="option1">Male
                            <input type="radio" name="Gender" id="woman" value="option2">Female
                        </label>
                    </div>
                </div>
                <div >
                    <label for="birthday" >Birthday</label>
                    <div>
                        <input type="text" id="birthday" placeholder="yyyy-mm-dd" />
                    </div>
                </div>
                <div>
                    <label for="postcodes">Zipcode</label>
                    <div>
                        <input type="text" id="postcodes" placeholder="02446" />
                    </div>
                </div>
                <div>
                    <label for="address">Address</label>
                    <div>
                        <input type="text" id="address" placeholder="Your current address" />
                    </div>
                </div>
                <div>
                    <div >
                        <button  type="submit" onclick="startRegister()">Register</button>
                    </div>
                </div>
            </div>
            <br/>
        </div>
    </div>

    <jsp:include page="include/foot.jsp"/>
    
    <script type="text/javascript">
        function startRegister() {
            var loading = layer.load(0);
            var user = {};
            user.userName = document.getElementById("inputUserName").value;
            user.email = document.getElementById("inputEmail").value;
            user.nickName = document.getElementById("inputNickname").value;
            user.password = document.getElementById("inputPassword").value;
            user.phoneNumber = document.getElementById("inputPhoneNumber").value;
            user.birthday = document.getElementById("birthday").value;
            user.postNumber = document.getElementById("postcodes").value;
            user.address = document.getElementById("address").value;
            user.sex = 0;
            if(document.getElementById("woman").checked)
                user.sex = 1;
            if(user.userName == ''){
                layer.msg('Username cannot be null',{icon:2});
                return;
            }
            else if(user.userName.length >= 12){
                layer.msg('No more than 12 characters',{icon:2});
                return;
            }
            if(user.nickName == ''){
                layer.msg('LastName cannot be null',{icon:2});
                return;
            }
            else if(user.nickName.length >= 12){
                layer.msg('Lastname must be less than 12 characters',{icon:2});
                return;
            }
            else if(user.password == ''){
                layer.msg('Password can not be null',{icon:2});
                return;
            }
            else if(user.password.length>=15){
                layer.msg('Password <=15 characters',{icon:2});
                return;
            }
            var registerResult = null;
            $.ajax({
                async : false, 
                type : 'POST',
                url : '${cp}/doRegister',
                data : user,
                dataType : 'json',
                success : function(result) {
                    registerResult = result.result;
                },
                error : function(result) {
                    layer.alert('Search user error');
                }
            });
            if(registerResult == 'success'){
                layer.close(loading);
                layer.msg('Register successful!',{icon:1});
                window.location.href="${cp}/login";
            }
            else if(registerResult == 'nameExist'){
                layer.close(loading);
                layer.msg('The username is already exist',{icon:2});
            }
            else if(registerResult == 'emailExist'){
                layer.close(loading);
                layer.msg('The email is already exist',{icon:2});
            }
            else if(registerResult == 'fail'){
                layer.close(loading);
                layer.msg('Server error!',{icon:2});
            }
        }
    </script>
  </body>
</html>