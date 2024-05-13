<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Home Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            margin-top: 50px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        .card-body {
            padding: 30px;
        }
        .card-title {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .product-card {
            margin-bottom: 20px;
        }
        .product-card img {
            max-width: 100%;
            border-radius: 10px;
        }
        .product-card .card-body {
            padding: 15px;
        }
        .product-card .card-title {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .product-card .card-text {
            color: #6c757d;
        }
        .add-product-btn {
            margin-top: 20px;
        }
        .add-product-btn-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .order-btn-row {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
        }
        .card-btn-row {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            margin: 10px;
        }
        .update-product-btn {
            background: none;
            border: none;
            color: blue;
            font-size: 20px;
            cursor: pointer;
            display: flex;
            margin: auto;
            justify-content: center;
        }
        .delete-product-btn {
            background: none;
            border: none;
            color: red;
            font-size: 20px;
            cursor: pointer;
            display: flex;
            margin: auto;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row add-product-btn-row">
            <div class="col-md-11">
                <h2 class="card-title">Products</h2>
            </div>
            <div class="col-md-1 text-md-end">
                <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary add-product-btn">Add</a>
            </div>
        </div>
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4">
                    <div class="card product-card">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.description}</p>
                            <p class="card-text">Price: ${product.price}</p>
                            <div class="row card-btn-row">
                                <div class="col">
                                    <button class="delete-product-btn" onclick="deleteProduct(${product.id})"><i class="bi bi-trash"></i></button>
                                </div>
                                <div class="col">
                                    <button class="update-product-btn" onclick="redirectToUpdate(${product.id})"><i class="bi bi-pencil"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
    <script>
        function redirectToUpdate(productId) {
            window.location.href = "${pageContext.request.contextPath}/products/update/" + productId;
        }
    </script>
    <!-- Bootstrap Icons -->
    <script src="https://unpkg.com/bootstrap-icons@1.8.1/dist/bootstrap-icons.js"></script>
    <script>
        function deleteProduct(productId) {
            if (confirm("Are you sure you want to delete this product?")) {
                //AJAX request to the server to delete the product
                fetch('products/' + productId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        alert('Failed to delete product');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to delete product');
                });
            }
        }
    </script>

    <div class="row order-btn-row">
            <div class="col-2">
                <a href="${pageContext.request.contextPath}/orders/add" class="btn btn-success add-product-btn">Create Order</a>
            </div>
            <div class="col-2">
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-success add-product-btn">Show Orders</a>
            </div>
        </div>
</body>
</html>
