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



<div class="title">
    <h2>Edit profile</h2>
    <div >
        <!-- Form -->
        <div  class="form-horizontal">
            <div>
                <label for="inputEmail" >Username</label>
                <div>
                    <input type="text"  id="inputUserName" placeholder="" readonly>
                </div>
            </div>
            <div>
                <label for="inputEmail">Email</label>
                <div>
                    <input type="email"  id="inputEmail" placeholder="" readonly>
                </div>
            </div>
            <div>
                <label for="inputNickname" >LastName</label>
                <div>
                    <input type="text" id="inputNickname" placeholder="" />
                </div>
            </div>
            <div>
                <label for="inputPassword" >Password</label>
                <div >
                    <input type="password"  id="inputPassword" placeholder="" />
                </div>
            </div>
            <div >
                <label for="inputPhoneNumber" >Cellphone</label>
                <div>
                    <input type="text"  id="inputPhoneNumber" placeholder="" />
                </div>
            </div>
            <div>
                <label for="man">Gender</label>
                <div >
                    <label>
                        <input type="radio" name="Gender" id="man" value="option1"> Male
                  
                        <input type="radio" name="Gender"  id="woman" value="option2"> Female
                    </label>
                </div>
            </div>
            <div >
                <label for="birthday" >Birthday</label>
                <div >
                    <input type="text"  id="birthday" placeholder="" />
                </div>
            </div>
            <div>
                <label for="postcodes" >Zipcode</label>
                <div>
                    <input type="text" id="postcodes" placeholder="" />
                </div>
            </div>
            <div>
                <label for="address" >Address</label>
                <div>
                    <input type="text"  id="address" placeholder="" />
                </div>
            </div>
            <div >
                <div>
                    <button type="submit" onclick="startUpdate()">Submit</button>
                </div>
            </div>
        </div>
        <br/>
    </div>
</div>

<!--尾部-->
<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">
    initData();
    function initData() {
        var userId = ${currentUser.id};
        var user = getUserById(userId);
        var userDetail = getUserDetailById(userId);
        document.getElementById("inputUserName").value = user.name;
        document.getElementById("inputEmail").value = user.email;
        document.getElementById("inputNickname").value = user.nickName;
        document.getElementById("inputPassword").value = userDetail.password;
        document.getElementById("inputPhoneNumber").value = userDetail.phoneNumber;
        document.getElementById("birthday").value = userDetail.birthday;
        document.getElementById("postcodes").value = userDetail.postNumber;
        document.getElementById("address").value = userDetail.address;
        if(userDetail.sex == 0)
            document.getElementById("man").checked = true;
        else
            document.getElementById("woman").checked = true;
    }
    function startUpdate() {
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
            layer.msg('Error',{icon:2});
            return;
        }
        else if(user.userName.length >= 12){
            layer.msg('Error',{icon:2});
            return;
        }
        if(user.nickName == ''){
            layer.msg('Error',{icon:2});
            return;
        }
        else if(user.nickName.length >= 15){
            layer.msg('Error',{icon:2});
            return;
        }
        else if(user.password == ''){
            layer.msg('Error',{icon:2});
            return;
        }
        else if(user.password.length>= 20){
            layer.msg('Error',{icon:2});
            return;
        }
        var registerResult = null;
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/doUpdate',
            data : user,
            dataType : 'json',
            success : function(result) {
                registerResult = result.result;
            },
            error : function(result) {
                layer.alert('Error');
            }
        });
        if(registerResult == 'success'){
            layer.close(loading);
            layer.msg('Change saved',{icon:1});
            window.location.href="${cp}/main";
        }
        else if(registerResult == 'fail'){
            layer.msg('error',{icon:2});
        }
    }

    function getUserById(id) {
        var userResult = "";
        var user = {};
        user.id = id;
        $.ajax({
            async : false, 
            type : 'POST',
            url : '${cp}/getUserById',
            data : user,
            dataType : 'json',
            success : function(result) {
                userResult = result.result;
            },
            error : function(result) {
                layer.alert('Search error');
            }
        });
        userResult = JSON.parse(userResult);
        return userResult;
    }

    function getUserDetailById(id) {
        var userDetailResult = "";
        var user = {};
        user.id = id;
        $.ajax({
            async : false, 
            type : 'POST',
            url : '${cp}/getUserDetailById',
            data : user,
            dataType : 'json',
            success : function(result) {
                userDetailResult = result.result;
            },
            error : function(result) {
                layer.alert('Search error');
            }
        });
        userDetailResult = JSON.parse(userDetailResult);
        return userDetailResult;
    }
</script>
</body>
</html>