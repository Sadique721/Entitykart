<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4>Add New Product</h4>
                </div>
                <div class="card-body">
                    <form action="/admin/product/save" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="productName" class="form-label">Product Name *</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="brand" class="form-label">Brand</label>
                                <input type="text" class="form-control" id="brand" name="brand">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="categoryId" class="form-label">Category *</label>
                                <select class="form-control" id="categoryId" name="categoryId" required>
                                    <option value="">Select Category</option>
                                    <c:forEach var="category" items="${categoryList}">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="subCategoryId" class="form-label">Sub Category</label>
                                <select class="form-control" id="subCategoryId" name="subCategoryId">
                                    <option value="">Select Sub Category</option>
                                    <c:forEach var="sub" items="${subCategories}">
                                        <option value="${sub.subCategoryId}">${sub.childCategory}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="sku" class="form-label">SKU</label>
                                <input type="text" class="form-control" id="sku" name="sku">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="price" class="form-label">Price *</label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="mrp" class="form-label">MRP</label>
                                <input type="number" class="form-control" id="mrp" name="mrp">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="stockQuantity" class="form-label">Stock Quantity</label>
                                <input type="number" class="form-control" id="stockQuantity" name="stockQuantity">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="Available">Available</option>
                                    <option value="Out of Stock">Out of Stock</option>
                                    <option value="Discontinued">Discontinued</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="imageFile" class="form-label">Main Image</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                                <small class="text-muted">Upload product main image (JPEG, PNG)</small>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-primary">Save Product</button>
                                <a href="/listProduct" class="btn btn-secondary">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>