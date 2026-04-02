<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header">
                    <h4>Add New Category</h4>
                </div>
                <div class="card-body">
                    <form action="/saveCategory" method="post">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name *</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="active" class="form-label">Status</label>
                            <select class="form-control" id="active" name="active">
                                <option value="true">Active</option>
                                <option value="false">Inactive</option>
                            </select>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Save Category</button>
                        <a href="/listCategory" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>