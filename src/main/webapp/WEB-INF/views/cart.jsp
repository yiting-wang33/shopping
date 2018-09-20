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
   

	
	<div class="container-fluid bigHead">
		<div class="row">
			<div class="col-sm-10  col-md-10 col-sm-offset-1 col-md-offset-1">
				<div >
					<h2>Cart</h2>
				</div>
			</div>
			<div class="col-sm-10  col-md-10 col-sm-offset-1 col-md-offset-1">
				<table class="table table-hover center" id="shoppingCarTable">
				</table>

				<hr/>
				<div class="row">
					<div></div>
					<button type="button" onclick="confirmPre()">Buy</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/foot.jsp"/>

	<script type="text/javascript">
		updateShoppingCars();

		function updateShoppingCars() {
			var shoppingCarTable = document.getElementById("shoppingCarTable");
			var allShoppingCars = getShoppingCars();
			shoppingCarTable.innerHTML = "";
			var html = '<tr>'+
							'<th>Select</th>'+
							'<th>Name</th>'+
							'<th>Price</th>'+
							'<th>Amount</th>'+
						'</tr>';
			for(var i=0;i<allShoppingCars.length;i++){
				var product = getProductById(allShoppingCars[i].productId);
				html  += '<tr>'+
						'<td>'+
						'<div class="checkbox">'+
						'<label>'+
						'<input type="checkbox"class="title" id="checkbox'+allShoppingCars[i].productId+'" value="option1">'+
						'</label>'+
						'</div>'+
						'</td>'+
						'<td>'+product.name+'</td>'+
						'<td>'+product.price+'</td>'+
						'<td>'+allShoppingCars[i].counts+'</td>'+
						'</tr>';
			}
			shoppingCarTable.innerHTML += html;

		}

		function getShoppingCars() {
			judgeIsLogin();
			var shoppingCarProducts = "";
			var user = {};
			user.userId = ${currentUser.id};
			$.ajax({
				async : false,
				type : 'POST',
				url : '${cp}/getShoppingCars',
				data : user,
				dataType : 'json',
				success : function(result) {
					shoppingCarProducts = result.result;
				},
				error : function(result) {
					layer.alert('Search Error');
				}
			});
			shoppingCarProducts = eval("("+shoppingCarProducts+")");
			return shoppingCarProducts;
		}

		function confirmPre() {
			var allShoppingCars = getShoppingCars();
			var buyProducts = new Array;
			var buyProductsCounts = new Array;
			var buyCounts = 0;
			for(var i=0;i<allShoppingCars.length;i++){
				var checkBox = document.getElementById("checkbox"+allShoppingCars[i].productId);
				if(checkBox.checked){
					buyProducts[buyCounts] = allShoppingCars[i].productId;
					buyProductsCounts[buyCounts] = allShoppingCars[i].counts;
					buyCounts++;
				}
			}
			if(buyCounts == 0){
				layer.msg("Nothing selected",{icon:2});
			}
			else{
				buyConfirm(buyProducts,buyProductsCounts);
			}
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

        function judgeIsLogin() {
            if("${currentUser.id}" == null || "${currentUser.id}" == undefined || "${currentUser.id}" ==""){
                window.location.href = "${cp}/login";
            }
        }

		function buyConfirm(productsId,productsCounts) {
			var address = getUserAddress(${currentUser.id});
			var phoneNumber = getUserPhoneNumber(${currentUser.id});
			var totalPrice = 0;

			var html = '<div class="col-sm-1 col-md-1 col-lg-1"></div>'+
					'<div class="col-sm-10 col-md-10 col-lg-10">'+
					'<table class="table confirm-margin">';
			for(var i=0;i<productsId.length;i++){
				var product = getProductById(productsId[i]);
				html +=	'<tr>'+
					'<th>'+(i+1)+'Name:</th>'+
					'<td>'+product.name+'</td>'+
					'</tr>'+
					'<tr>'+
					'<th>Price</th>'+
					'<td>'+product.price+'</td>'+
					'</tr>'+
					'<tr>'+
					'<th>Amount</th>'+
					'<td>'+productsCounts[i]+'</td>'+
					'</tr>'+
					'<tr>';
				totalPrice+=product.price*productsCounts[i];
			}
			html +='<th>Total price:</th>'+
					'<td>'+totalPrice+'</td>'+
					'</tr>'+
					'<tr>'+
					'<th>Address:</th>'+
					'<td>'+address+'</td>'+
					'</tr>'+
					'<tr>'+
					'<th>Cellphone:</th>'+
					'<td>'+phoneNumber+'</td>'+
					'</tr>'+
					'</table>'+
					'<div class="row">'+
					'<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
					'<button onclick="addToShoppingRecordsPre(['+productsId+'],['+productsCounts+'])">check out?</button>'+
					'</div>'+
					'</div>';
			layer.open({
				type:1,
				title:'Check out?',
				content:html,
				area:['650px','350px'],
			});
		}


		function getUserAddress(id) {
			var address = "";
			var user = {};
			user.id = id;
			$.ajax({
				async : false, 
				type : 'POST',
				url : '${cp}/getUserAddressAndPhoneNumber',
				data : user,
				dataType : 'json',
				success : function(result) {
					address = result.address;
				},
				error : function(result) {
					layer.alert('Search error');
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
					layer.alert('Search error');
				}
			});
			return phoneNumber;
		}

		function addToShoppingRecordsPre(productsId,productsCounts) {
			for(var i=0;i<productsId.length;i++){
				addToShoppingRecords(productsId[i],productsCounts[i]);
			}
			layer.confirm('Go to order？', {icon: 1, title:'purchase successful',btn:['Go to cart','Go on view']},
					function(){
						window.location.href = "${cp}/shopping_record";
					},
					function(index){
                        window.location.href = "${cp}/shopping_car";
					}
			);
		}

		function addToShoppingRecords(productId,productCounts) {
			judgeIsLogin();
			var shoppingRecord = {};
			shoppingRecord.userId = ${currentUser.id};
			shoppingRecord.productId = productId;
			shoppingRecord.counts = productCounts;
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
					layer.alert('Error');
				}
			});
			var product = getProductById(productId);
			if(buyResult == "success") {
                deleteShoppingCar(productId);
				layer.msg(""+product.name+"perchase successful",{icon:1});
			}
			else if(buyResult == "unEnough"){
				layer.alert(" "+product.name+"not in stock")
			}
		}

		function deleteShoppingCar(productId) {
            var shoppingCar = {};
            shoppingCar.userId = ${currentUser.id};
            shoppingCar.productId = productId;
            var deleteResult = "";
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/deleteShoppingCar',
                data : shoppingCar,
                dataType : 'json',
                success : function(result) {
                    deleteResult = result.result;
                },
                error : function(result) {
                    layer.alert('Search error');
                }
            });
        }
	</script>
  </body>
</html>