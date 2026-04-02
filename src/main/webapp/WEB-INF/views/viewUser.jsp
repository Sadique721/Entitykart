<%@ include file="header.jsp" %>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>User Details</h4>
                    <div>
                        <a href="/editUser?userId=${userEntity.userId}" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="/index" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 text-center">
                            <img src="${userEntity.profilePicURL != null ? userEntity.profilePicURL : 'https://via.placeholder.com/200'}" 
                                 class="img-fluid rounded-circle mb-3" alt="Profile" style="width: 200px; height: 200px; object-fit: cover;">
                            <h5>${userEntity.name}</h5>
                            <p class="text-muted">${userEntity.role}</p>
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th>User ID</th>
                                            <td>${userEntity.userId}</td>
                                        </tr>
                                        <tr>
                                            <th>Full Name</th>
                                            <td>${userEntity.name}</td>
                                        </tr>
                                        <tr>
                                            <th>Email</th>
                                            <td>${userEntity.email}</td>
                                        </tr>
                                        <tr>
                                            <th>Contact Number</th>
                                            <td>${userEntity.contactNum}</td>
                                        </tr>
                                        <tr>
                                            <th>Gender</th>
                                            <td>${userEntity.gender}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th>Role</th>
                                            <td>
                                                <span class="badge ${userEntity.role == 'ADMIN' ? 'bg-danger' : userEntity.role == 'PARTICIPANT' ? 'bg-info' : 'bg-secondary'}">
                                                    ${userEntity.role}
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Status</th>
                                            <td>
                                                <span class="badge ${userEntity.active ? 'bg-success' : 'bg-danger'}">
                                                    ${userEntity.active ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Created At</th>
                                            <td>${userEntity.createdAt}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            
                            <h5 class="mt-4">Address Details</h5>
                            <c:if test="${address != null}">
                                <table class="table table-bordered">
                                    <tr>
                                        <th style="width: 200px;">Address ID</th>
                                        <td>${address.addressId}</td>
                                    </tr>
                                    <tr>
                                        <th>Full Name</th>
                                        <td>${address.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Mobile Number</th>
                                        <td>${address.mobileNo}</td>
                                    </tr>
                                    <tr>
                                        <th>Address Line 1</th>
                                        <td>${address.addressLine1}</td>
                                    </tr>
                                    <tr>
                                        <th>City</th>
                                        <td>${address.city}</td>
                                    </tr>
                                    <tr>
                                        <th>State</th>
                                        <td>${address.state}</td>
                                    </tr>
                                    <tr>
                                        <th>Pincode</th>
                                        <td>${address.pincode}</td>
                                    </tr>
                                    <tr>
                                        <th>Address Type</th>
                                        <td>${address.addressType}</td>
                                    </tr>
                                    <tr>
                                        <th>Default Address</th>
                                        <td>
                                            <span class="badge ${address.isDefault ? 'bg-success' : 'bg-secondary'}">
                                                ${address.isDefault ? 'Yes' : 'No'}
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>