<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
  </head>
  <body>
  
    <jsp:include page="include/header.jsp"/>


    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-10 col-md-10">
                <h1>${productDetail.name}</h1>
                <hr/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-5 col-md-5">
                <img height="200" width="200" src="${cp}/img/${productDetail.id}.jpg">
            </div>
            <div class="col-sm-5 col-md-5 detail-x">
                <table >
                    <tr>
                        <th>Name</th>
                        <td>${productDetail.name}</td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td>${productDetail.price}</td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td>${productDetail.description}</td>
                    </tr>
                    <tr>
                        <th>Category</th>
                        <td>${productDetail.type}</td>
                    </tr>
                    <tr>
                        <th>In Stock</th>
                        <td>${productDetail.counts}</td>
                    </tr>
                    <tr>
                        <th>Amount</th>
                        <td>
                            <div role="group">
                                <button type="button" onclick="subCounts()">-</button>
                                <button id="productCounts" type="button">1</button>
                                <button type="button"onclick="addCounts(1)">+</button>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="row">
                    <div></div>
                    <button onclick="addToShoppingCar(${productDetail.id})">Add to cart</button>
                    <button onclick="buyConfirm(${productDetail.id})">Buy</button>

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1 col-md-1 col-lg-1"></div>
            <div class="col-sm-10 col-md-10 col-lg-10">
                <hr class="division"/>
                <table class="table evaluationTable" border="0" id="evaluation">
                </table>
                <hr/>
                <div id="inputArea"></div>
            </div>
        </div>
    </div>

    <jsp:include page="include/foot.jsp"/>
  <script type="text/javascript">
      listEvaluations();

      function addToShoppingCar(productId) {
          judgeIsLogin();
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingCar = {};
          shoppingCar.userId = ${currentUser.id};
          shoppingCar.productId = productId;
          shoppingCar.counts = counts;
          var addResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingCar',
              data : shoppingCar,
              dataType : 'json',
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Search user error');
              }
          });
          if(addResult == "success") {
              layer.confirm('Go to cart?', {icon: 1, title:'Add successful',btn:['Go to cart','go on view']},
                      function(){
                          window.location.href = "${cp}/shopping_car";
                      },
                      function(index){
                        layer.close(index);}
              );
          }
      }

      function judgeIsLogin() {
          if("${currentUser.id}" == null || "${currentUser.id}" == undefined || "${currentUser.id}" ==""){
              window.location.href = "${cp}/login";
          }
      }

      function subCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts>=2)
              counts--;
          productCounts.innerHTML = counts;
      }

      function addCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts${productDetail.counts})
              counts++;
          productCounts.innerHTML = counts;
      }

      function buyConfirm(productId) {
          var address = getUserAddress(${currentUser.id});
          var phoneNumber = getUserPhoneNumber(${currentUser.id});
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var product = getProductById(productId);
          var html = '<div class="col-sm-1 col-md-1 col-lg-1"></div>'+
                  '<div class="col-sm-10 col-md-10 col-lg-10">'+
                  '<table class="table confirm-margin">'+
                  '<tr>'+
                  '<th>Name</th>'+
                  '<td>'+product.name+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Price:</th>'+
                  '<td>'+product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Amount</th>'+
                  '<td>'+counts+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Total price:</th>'+
                  '<td>'+counts*product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Post Address</th>'+
                  '<td>'+address+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Cellphone</th>'+
                  '<td>'+phoneNumber+'</td>'+
                  '</tr>'+
                  '</table>'+
                  '<div class="row">'+
                  '<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
                  '<button  onclick="addToShoppingRecords('+productId+')">Check out</button>'+
                  '</div>'+
                  '</div>';
          layer.open({
              type:1,
              title:'submit?',
              content:html,
              area:['650px','350px'],
          });
      }

      function getProductById(id) {
          var productResult = "";
          var product = {};
          product.id = id;
          $.ajax({
              async : false, 
              type : 'POST',
              url : '${cp}/getProductById',
              data : product,
              dataType : 'json',
              success : function(result) {
                  productResult = result.result;
              },
              error : function(result) {
                  layer.alert('Search Error');
              }
          });
          productResult = JSON.parse(productResult);
          return productResult;
      }

      function getUserAddress(id) {
          var address = "";
          var user = {};
          user.id = id;
          $.ajax({
              type : 'POST',
              url : '${cp}/getUserAddressAndPhoneNumber',
              data : user,
              dataType : 'json',
              success : function(result) {
                  address = result.address;
              },
              error : function(result) {
                  layer.alert('Search Error');
              }
          });
          return address;
      }

      function getUserPhoneNumber(id) {
          var phoneNumber = "";
          var user = {};
          user.id = id;
          $.ajax({
              async : false, 
              type : 'POST',
              url : '${cp}/getUserAddressAndPhoneNumber',
              data : user,
              dataType : 'json',
              success : function(result) {
                  phoneNumber = result.phoneNumber;
              },
              error : function(result) {
                  layer.alert('Search Error');
              }
          });
          return phoneNumber;
      }

      function addToShoppingRecords(productId) {
          judgeIsLogin();
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingRecord = {};
          shoppingRecord.userId = ${currentUser.id};
          shoppingRecord.productId = productId;
          shoppingRecord.counts = counts;
          var buyResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingRecord',
              data : shoppingRecord,
              dataType : 'json',
              success : function(result) {
                  buyResult = result.result;
              },
              error : function(result) {
                  layer.alert('perchase error');
              }
          });
          if(buyResult == "success") {
              layer.confirm('Go to order?', {icon: 1, title:'Success!',btn:['Go to order','Stay']},
                      function(){
                          window.location.href = "${cp}/shopping_car";
                      },
                      function(index){
                          layer.close(index);}
              );
          }
          else if(buyResult == "unEnough"){
              layer.alert("not in stock")
          }
      }

      function listEvaluations() {
          var evaluations = getEvaluations();
          var evaluationTable = document.getElementById("evaluation");
          var html = "";
          for(var i=0;i<evaluations.length;i++){
              var user = getUserById(evaluations[i].userId);
              html+='<tr>'+
                      '<th>'+user.nickName+'</th>'+
                      '<td>'+evaluations[i].content+'</td>'+
                      '</tr>';
          }
          evaluationTable.innerHTML += html;

          if(getUserProductRecord() == "true"){
              var inputArea = document.getElementById("inputArea");
              html= '<div class="col-sm-12 col-md-12 col-lg-12">'+
                      '<textarea class="form-control" rows="4" id="evaluationText"></textarea>'+
                      '</div>'+
                      '<div class="col-sm-12 col-md-12 col-lg-12">'+
                      '<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
                      '<button  onclick="addToEvaluation()">Review</button>'+
                      '</div>';
              inputArea.innerHTML +=html;
          }

      }

      function getUserProductRecord() {
          var results = "";
          var product = {};
          product.userId = ${currentUser.id};
          product.productId = ${productDetail.id};
          $.ajax({
              async : false, 
              type : 'POST',
              url : '${cp}/getUserProductRecord',
              data : product,
              dataType : 'json',
              success : function(result) {
                  results = result.result;
              },
              error : function(result) {
                  layer.alert('Search Error');
              }
          });
          return results;
      }

      function getEvaluations() {
          var evaluations = "";
          var product = {};
          product.productId = ${productDetail.id};
          $.ajax({
              async : false, 
              type : 'POST',
              url : '${cp}/getShoppingEvaluations',
              data : product,
              dataType : 'json',
              success : function(result) {
                  evaluations = result.result;
              },
              error : function(result) {
                  layer.alert('Search Error');
              }
          });
          evaluations = eval("("+evaluations+")");
          return evaluations;
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
                  layer.alert('Search Error');
              }
          });
          userResult = JSON.parse(userResult);
          return userResult;
      }

      function addToEvaluation() {
          var inputText = document.getElementById("evaluationText").value;
          var evaluation = {};
          evaluation.userId = ${currentUser.id};
          evaluation.productId = ${productDetail.id};
          evaluation.content = inputText;
          var addResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingEvaluation',
              data : evaluation,
              dataType : 'json',
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Search user error');
              }
          });
          if(addResult = "success"){
              layer.msg("Review submitted",{icon:1});
              window.location.href = "${cp}/product_detail";
          }
      }

  </script>
  </body>
</html>