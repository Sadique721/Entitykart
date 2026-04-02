<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5>Edit Category</h5>
                </div>
                <div class="card-body">
                    <form action="/updateCategory" method="post">
                        <input type="hidden" name="categoryId" value="${categoryEntity.categoryId}">
                        
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" 
                                   value="${categoryEntity.categoryName}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="active" value="true" 
                                       ${categoryEntity.active ? 'checked' : ''} id="activeTrue">
                                <label class="form-check-label" for="activeTrue">Active</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="active" value="false" 
                                       ${!categoryEntity.active ? 'checked' : ''} id="activeFalse">
                                <label class="form-check-label" for="activeFalse">Inactive</label>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Associated Subcategories</label>
                            <ul class="list-group">
                                <c:forEach var="sub" items="${subCategories}">
                                    <li class="list-group-item">${sub.childCategory}</li>
                                </c:forEach>
                            </ul>
                            <small class="text-muted">Subcategories can be managed separately.</small>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Update Category</button>
                        <a href="/listCategory" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>