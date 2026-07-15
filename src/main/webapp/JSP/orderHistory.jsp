<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Order"%>
<%@ page import="com.tap.model.User"%>

<%
User user = (User)session.getAttribute("loggedInUser");

if(user==null){
    response.sendRedirect(request.getContextPath()+"/JSP/login.jsp");
    return;
}

List<Order> orders=(List<Order>)request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Orders | CraveCart</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/common.css">

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/admin.css">



</head>

<body>

<header class="navbar">

    <div class="logo">
        CraveCart
    </div>

    <nav>

        <a href="<%=request.getContextPath()%>/home">Home</a>

        <a href="<%=request.getContextPath()%>/restaurants">Restaurants</a>

        <a href="<%=request.getContextPath()%>/categories">Categories</a>

        <a class="active"
        href="<%=request.getContextPath()%>/orderHistory">
        My Orders
        </a>

        <a href="<%=request.getContextPath()%>/cart">
        Cart
        </a>

    </nav>

</header>


<section class="main-content">

    <h1>My <span>Orders</span></h1>

    <p class="subtitle">
        Track all your previous food orders.
    </p>

    <div class="table-container">

        <table>

            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Restaurant</th>
                    <th>Amount</th>
                    <th>Payment</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
            </thead>

            <tbody>

            <%
            if(orders!=null && !orders.isEmpty()){

                for(Order order : orders){
            %>

                <tr>

                    <td>#<%=order.getOrderId()%></td>

                    <td>
                        Restaurant
                        <%=order.getRestaurantId()%>
                    </td>

                    <td>
                        ₹<%=order.getTotalAmount()%>
                    </td>

                    <td>
                        <%=order.getPaymentMode()%>
                    </td>

                    <td>

                        <span class="status active">

                            <%=order.getOrderStatus()%>

                        </span>

                    </td>

                    <td>

                        <%=order.getOrderDate()%>

                    </td>

                </tr>

            <%
                }
            }
            else{
            %>

                <tr>

                    <td colspan="6"
                        style="text-align:center;font-weight:bold;padding:30px;">

                        No Orders Found

                    </td>

                </tr>

            <%
            }
            %>

            </tbody>

        </table>

    </div>

</section>

</body>
</html>