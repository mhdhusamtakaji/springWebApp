<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
            cursor: pointer;
        }
        .product-card:hover {
            box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.1);
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
        .selected-product {
            background-color: #cce5ff;
        }
        .total-label {
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-submit {
            margin-top: 20px;
        }
        .total-label {
            font-weight: bold;
        }

        .total-value {
            display: inline-block;
            padding: 0.375rem 0.75rem;
            margin-bottom: 0;
            font-size: 1rem;
            line-height: 1.5;
            color: #4d7365;
            background-color: #e9ecef;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

    </style>
</head>
<body>
    <div class="container">
    <h2 class="card-title">Select Products</h2>
    <div class="row">
        <c:forEach var="product" items="${products}">
            <div class="col-md-4">
                <div class="card product-card" data-id="${product.id}" data-price="${product.price}">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <p class="card-text">${product.description}</p>
                        <p class="card-text">Price: ${product.price}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <form id="orderForm" action="${pageContext.request.contextPath}/orders/add" method="post">
        <div class="form-group">
            <label class="total-label" for="total">Total:</label>
            <div class="total-value" id="total">$0.00</div>
            
        </div>

        <button type="submit" class="btn btn-primary btn-submit justify-content-center d-flex m-auto mt-5">Submit Order</button>
    </form>
</div>
<script>
    // Function to update total based on selected products
    function updateTotal() {
        let total = 0;
        document.querySelectorAll('.product-card.selected-product').forEach(function(card) {
            total += parseFloat(card.dataset.price);
        });
        document.getElementById('total').textContent = '$' + total.toFixed(2);
    }

    // Add click event listener to product cards
    document.querySelectorAll('.product-card').forEach(function(card) {
        card.addEventListener('click', function() {
            // Toggle selected class
            card.classList.toggle('selected-product');
            // Update total
            updateTotal();
        });
    });

    // Function to handle form submission
    document.getElementById('orderForm').addEventListener('submit', function(event) {
        // Get selected product IDs
        const selectedProductIds = [];
        document.querySelectorAll('.product-card.selected-product').forEach(function(card) {
            selectedProductIds.push(card.dataset.id);
        });
        // Set hidden input value for selected product IDs
        const hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'productIds');
        hiddenInput.setAttribute('value', selectedProductIds.join(','));
        document.getElementById('orderForm').appendChild(hiddenInput);
    });
</script>


</body>
</html>
