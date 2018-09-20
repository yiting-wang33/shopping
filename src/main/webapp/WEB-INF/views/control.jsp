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
      <script src="${cp}/js/ajaxfileupload.js" type="text/javascript"></script>
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


    <div class="container-fluid">
        <div class="row">
            
            <div>
                <div>
                    <h3>User details</h3>
                    <hr/>
                    <table class="form-title" id="userTable">
                    </table>
                </div>

                <div>
                    <hr/>
                    <h3>Product Details</h3>
                    <hr/>
                    <div  id="productArea"></div>
                    <br/>
                </div>
                
                <div class="title">
   
                    <div>
                        <!-- Form -->
                        <div  >
                            <div>
                            <h1 class="row" ></h1>
                                <label for="productName" >Name</label>
                                <div >
                                    <input type="text"  id="productName" placeholder="" />
                                </div>
                            </div>
                            <div >
                                <label for="productDescribe" >Description</label>
                                <div >
                                    <textarea type="text"  id="productDescribe" placeholder=""></textarea>
                                </div>
                            </div>
                            <div >
                                <label for="keyWord" >Keyword</label>
                                <div >
                                    <textarea type="text" id="keyWord" placeholder=""></textarea>
                                </div>
                            </div>
                            <div>
                                <label for="productPrice" >Price</label>
                                <div>
                                    <input type="text"  id="productPrice" placeholder="" />
                                </div>
                            </div>
                            <div>
                                <label for="productCount" >In stock</label>
                                <div>
                                    <input type="text" id="productCount" placeholder="" />
                                </div>
                            </div>
                            <div >
                                <label for="productType">Category</label>
                                <div >
                                    <select name="productType" id="productType">
                                        <option value="1">Cloths</option>
                                        <option value="2">Book</option>
                                        <option value="3">Sprot</option>
                              
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label for="productImgUpload" accept="image/jpg">Picture</label>
                                <div>
                                    <input name="productImgUpload" type="file"  id="productImgUpload"/>
                                    <p>200*200</p>
                                </div>
                            </div>
                            <div>
                                <div  id="imgPreSee">
                                </div>
                            </div>
                            <div>
                                <div >
                                    <button type="submit" onclick="addProduct()">Add</button>
                                </div>
                            </div>
                        </div>
                        <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>


 
    <jsp:include page="include/foot.jsp"/>
  <script type="text/javascript">

      var loading = layer.load(0);
      listAllUser();
      listAllProduct();
      layer.close(loading);
     
      function listAllUser() {
          var userTable = document.getElementById("userTable");
          var allUser = getAllUsers();
          userTable.innerHTML = '<tr>'+
                                  '<th> UserId &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'+
                                  '<th> UserName &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'+
                                  '<th> LastName &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'+
                                  '<th> Email &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'+
                                  '<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Delete &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'+
                                '</tr>';
          var html = "";
          for(var i=0;i<allUser.length;i++){
              html += '<tr>'+
                      '<td>'+allUser[i].id+'</td>'+
                      '<td>'+allUser[i].name+'</td>'+
                      '<td>'+allUser[i].nickName+'</td>'+
                      '<td>'+allUser[i].email+'</td>'+
                      '<td>'+
                      '<button  type="submit" onclick="deleteUser('+allUser[i].id+')">Delete</button>'+
                      '</td>'+
                      '</tr>';
          }
          userTable.innerHTML += html;
      }

      function getAllUsers() {
          var allUsers = "";
          var nothing = {};
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getAllUser',
              data : nothing,
              dataType : 'json',
              success : function(result) {
                  if (result!=null) {
                      allUsers = result.allUsers;
                  }
                  else{
                      layer.alert('Search all users error');
                  }
              },
              error : function(resoult) {
                  layer.alert('Search all users error');
              }
          });
          allUsers = eval("("+allUsers+")");
          return allUsers;
      }


      function listAllProduct() {
          var productArea = document.getElementById("productArea");
          var allProduct = getAllProducts();
          var html="";
          productArea.innerHTML = '';
          for(var i=0;i<allProduct.length;i++){
              var imgURL = "${cp}/img/"+allProduct[i].id+".jpg";
              html+='<div class="col-sm-4 col-md-4">'+
                      '<div>'+
                      '<div>'+
                      '<img height="200" width="200" src="'+imgURL+'">'+
                      '</div>'+
                      '<p>'+allProduct[i].name+'</p>'+
                      '<p>Price:$'+allProduct[i].price+'</p>'+
                      '<p>In Stock:'+allProduct[i].counts+'</p>'+
                      '<div>'+
                      '<button type="submit" onclick="deleteProduct('+allProduct[i].id+')">Delete</button>'+
                      '</div>'+
                      '</div>'+
                      '</div>';
          }
          productArea.innerHTML+=html;
      }

      function getAllProducts() {
          var allProducts = null;
          var nothing = {};
          $.ajax({
              async : false, 
              type : 'POST',
              url : '${cp}/getAllProducts',
              data : nothing,
              dataType : 'json',
              success : function(result) {
                  if (result!=null) {
                      allProducts = result.allProducts;
                  }
                  else{
                      layer.alert('Search all users error');
                  }
              },
              error : function(resoult) {
                  layer.alert('Search all users error');
              }
          });
          allProducts = eval("("+allProducts+")");
          return allProducts;
      }

      function deleteUser(id) {
          var user = {};
          user.id = id;
          var deleteResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/deleteUser',
              data : user,
              dataType : 'json',
              success : function(result) {
                  deleteResult = result;
              },
              error : function(result) {
                  layer.alert('Search user error');
              }
          });
          //layer.msg(deleteResult.message);
          listAllUser()
      }

      function deleteProduct(id) {
          var product = {};
          product.id = id;
          var deleteResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/deleteProduct',
              data : product,
              dataType : 'json',
              success : function(result) {
                  deleteResult = result;
              },
              error : function(result) {
                  layer.alert('Delete product error');
              }
          });
          //layer.msg(deleteResult.message);
          listAllProduct();
      }
      
      function addProduct() {
          var loadings = layer.load(0);
          var product = {};
          product.name = document.getElementById("productName").value;
          product.description = document.getElementById("productDescribe").value;
          product.keyWord = document.getElementById("keyWord").value;
          product.price = document.getElementById("productPrice").value;
          product.counts = document.getElementById("productCount").value;
          product.type = document.getElementById("productType").value;
          var addResult="";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addProduct',
              data : product,
              dataType : 'json',
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Delete product error!');
              }
          });
          if(addResult == "success") {
              fileUpload();
              layer.msg('Add product successful', {icon: 1, time: 1000});
              layer.close(loadings)
          }
          listAllProduct();
      }
      
      function fileUpload() {
          var results = "";
          var name = document.getElementById("productName").value;
          $.ajaxFileUpload({
              url:'${cp}/uploadFile?name='+name,
              secureuri:false ,
              fileElementId:'productImgUpload',
              type:'POST',
              dataType : 'text',
              success: function (result){
                  result = result.replace(/<pre.*?>/g, '');  
                  result = result.replace(/<PRE.*?>/g, '');
                  result = result.replace("<PRE>", '');
                  result = result.replace("</PRE>", '');
                  result = result.replace("<pre>", '');
                  result = result.replace("</pre>", '');
                  result = JSON.parse(result);
                  results = result.result;
                  if(results == "success") {
                      layer.msg("Upload Sccessful!", {icon: 1});
                      window.location.href = "${cp}/control";
                     
                  }
                  else {
                      layer.msg("Upload picture fail", {icon: 0});
                  }

              },
              error: function ()
              {
                  layer.alert("upload error");
              }}
          );
      }
  </script>
  </body>
</html>