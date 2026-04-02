<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5>Category Details</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 30%">Category ID</th>
                            <td>${category.categoryId}</td>
                        </tr>
                        <tr>
                            <th>Category Name</th>
                            <td>${category.categoryName}</td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td>
                                <span class="badge ${category.active ? 'bg-success' : 'bg-danger'}">
                                    ${category.active ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Created At</th>
                            <td>${category.createdAt}</td>
                        </tr>
                        <tr>
                            <th>Subcategories</th>
                            <td>
                                <ul>
                                    <c:forEach var="sub" items="${subCategories}">
                                        <li>${sub.childCategory}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="card-footer">
                    <a href="/listCategory" class="btn btn-secondary">Back to List</a>
                    <a href="/editCategory?categoryId=${category.categoryId}" class="btn btn-warning">Edit</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>