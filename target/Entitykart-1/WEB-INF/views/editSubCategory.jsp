<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5>Edit Subcategory</h5>
                </div>
                <div class="card-body">
                    <form action="/updateSubCategory" method="post">
                        <input type="hidden" name="subCategoryId" value="${subCategoryEntity.subCategoryId}">
                        
                        <div class="mb-3">
                            <label for="childCategory" class="form-label">Subcategory Name</label>
                            <input type="text" class="form-control" id="childCategory" name="childCategory" 
                                   value="${subCategoryEntity.childCategory}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Parent Category</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">Select Category</option>
                                <c:forEach var="cat" items="${categoryList}">
                                    <option value="${cat.categoryId}" 
                                        ${cat.categoryId == subCategoryEntity.categoryId ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3">${subCategoryEntity.description}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="active" value="true" 
                                       ${subCategoryEntity.active ? 'checked' : ''} id="activeTrue">
                                <label class="form-check-label" for="activeTrue">Active</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="active" value="false" 
                                       ${!subCategoryEntity.active ? 'checked' : ''} id="activeFalse">
                                <label class="form-check-label" for="activeFalse">Inactive</label>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Update Subcategory</button>
                        <a href="/listSubCategory" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>