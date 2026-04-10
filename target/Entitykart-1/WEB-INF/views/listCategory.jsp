<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5>Category List</h5>
                    <a href="/category" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Category
                    </a>
                </div>

                <table class="table table-hover dataTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Subcategories</th>
                            <th>Status</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categoryList}">
                            <tr>
                                <td>${category.categoryId}</td>
                                <td>${category.categoryName}</td>
                                <td>${subCategoryCountMap[category.categoryId]}</td>
                                <td>
                                    <span class="badge ${category.active ? 'bg-success' : 'bg-danger'}">
                                        ${category.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td><fmt:formatDate value="${category.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                <td class="action-buttons">
                                    <a href="/viewCategory?categoryId=${category.categoryId}"
                                       class="btn btn-sm btn-info" title="View">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="/editCategory?categoryId=${category.categoryId}"
                                       class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="/toggleCategoryActive?categoryId=${category.categoryId}"
                                       class="btn btn-sm ${category.active ? 'btn-secondary' : 'btn-success'}"
                                       title="${category.active ? 'Deactivate' : 'Activate'}">
                                        <i class="fas ${category.active ? 'fa-ban' : 'fa-check-circle'}"></i>
                                    </a>
                                    <a href="/deleteCategory?categoryId=${category.categoryId}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirmDelete(event, 'category')"
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