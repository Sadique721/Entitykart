<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5>Sub Category List</h5>
                    <a href="/subCategory" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Sub Category
                    </a>
                </div>

                <table class="table table-hover dataTable">
                    <thead>
                          <tr>
                            <th>ID</th>
                            <th>Subcategory Name</th>
                            <th>Category</th>
                            <th>Products</th>
                            <th>Status</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sub" items="${subCategories}">
                            <tr>
                                <td>${sub.subCategoryId}</td>
                                <td>${sub.childCategory}</td>
                                <td>
                                    <c:forEach var="cat" items="${categoryList}">
                                        <c:if test="${cat.categoryId == sub.categoryId}">
                                            ${cat.categoryName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${productCountMap[sub.subCategoryId]}</td>
                                <td>
                                    <span class="badge ${sub.active ? 'bg-success' : 'bg-danger'}">
                                        ${sub.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td><fmt:formatDate value="${sub.createdAtAsDate}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                <td class="action-buttons">
                                    <a href="/viewSubCategory?id=${sub.subCategoryId}"
                                       class="btn btn-sm btn-info" title="View">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="/editSubCategory?id=${sub.subCategoryId}"
                                       class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="/toggleSubCategoryActive?id=${sub.subCategoryId}"
                                       class="btn btn-sm ${sub.active ? 'btn-secondary' : 'btn-success'}"
                                       title="${sub.active ? 'Deactivate' : 'Activate'}">
                                        <i class="fas ${sub.active ? 'fa-ban' : 'fa-check-circle'}"></i>
                                    </a>
                                    <a href="/deleteSubCategory?id=${sub.subCategoryId}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirmDelete(event, 'sub category')"
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