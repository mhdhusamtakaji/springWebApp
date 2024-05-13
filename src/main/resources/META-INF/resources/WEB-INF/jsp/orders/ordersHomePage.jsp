<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Home Page</title>
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
        .order-card {
            margin-bottom: 20px;
        }
        .order-card .card-body {
            padding: 15px;
        }
        .order-card .card-title {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .order-card .card-text {
            color: #6c757d;
        }
        .add-order-btn {
            margin-top: 20px;
        }
        .add-order-btn-row {
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
        .update-order-btn {
            background: none;
            border: none;
            color: blue;
            font-size: 20px;
            cursor: pointer;
            display: flex;
            margin: auto;
            justify-content: center;
        }
        .delete-order-btn {
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
        <div class="row add-order-btn-row">
            <div class="col-md-11">
                <h2 class="card-title">Orders</h2>
            </div>
            <div class="col-md-1 text-md-end">
                <a href="${pageContext.request.contextPath}/orders/add" class="btn btn-primary add-order-btn">Create</a>
            </div>
        </div>
        <div class="row">
            <c:forEach var="order" items="${orders}">
                <div class="col-md-4">
                    <div class="card order-card">
                        <div class="card-body">
                            <h5 class="card-title">${order.date}</h5>
                            <p class="card-text">Total: ${order.total}</p>
                            <div class="row card-btn-row">
                                <div class="col">
                                    <button class="delete-order-btn" onclick="deleteOrder(${order.id})"><i class="bi bi-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script>
        function redirectToUpdate(orderId) {
            window.location.href = "${pageContext.request.contextPath}/orders/update/" + orderId;
        }
    </script>
    <!-- Bootstrap Icons -->
    <script src="https://unpkg.com/bootstrap-icons@1.8.1/dist/bootstrap-icons.js"></script>
    <script>
        function deleteOrder(orderId) {
            if (confirm("Are you sure you want to delete this order?")) {
                //AJAX request to the server to delete the order
                fetch('orders/' + orderId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        alert('Failed to delete order');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to delete order');
                });
            }
        }
    </script>
</body>
</html>
