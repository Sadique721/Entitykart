<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5>Product List</h5>
                    <a href="/product" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Product
                    </a>
                </div>
                
                <table class="table table-hover dataTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${productList}">
                            <tr>
                                <td>${product.productId}</td>
                                <td>
                                    <img src="${product.mainImageURL != null ? product.mainImageURL : 'https://via.placeholder.com/50'}" 
                                         width="50" height="50" class="rounded" alt="Product">
                                </td>
                                <td>${product.productName}</td>
                                <td>
                                    <c:forEach var="cat" items="${categoryList}">
                                        <c:if test="${cat.categoryId == product.categoryId}">
                                            ${cat.categoryName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${product.price}</td>
                                <td>${product.stockQuantity}</td>
                                <td>
                                    <span class="badge ${product.status == 'Available' ? 'bg-success' : 'bg-warning'}">
                                        ${product.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="/viewProduct?productId=${product.productId}" class="btn btn-sm btn-info" title="View">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="#" class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="/deleteProduct?productId=${product.productId}" 
                                       class="btn btn-sm btn-danger" 
                                       onclick="return confirmDelete(event, 'product')"
                                       title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>