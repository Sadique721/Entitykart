<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5>Subcategory Details</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 30%">Subcategory ID</th>
                            <td>${subCategory.subCategoryId}</td>
                        </tr>
                        <tr>
                            <th>Subcategory Name</th>
                            <td>${subCategory.childCategory}</td>
                        </tr>
                        <tr>
                            <th>Parent Category</th>
                            <td>${category.categoryName}</td>
                        </tr>
                        <tr>
                            <th>Description</th>
                            <td>${subCategory.description}</td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td>
                                <span class="badge ${subCategory.active ? 'bg-success' : 'bg-danger'}">
                                    ${subCategory.active ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Created At</th>
                            <td>${subCategory.createdAt}</td>
                        </tr>
                    </table>
                </div>
                <div class="card-footer">
                    <a href="/listSubCategory" class="btn btn-secondary">Back to List</a>
                    <a href="/editSubCategory?id=${subCategory.subCategoryId}" class="btn btn-warning">Edit</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>