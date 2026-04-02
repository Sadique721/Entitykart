package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.AddressEntity;

@Repository
public interface AddressRepository extends JpaRepository<AddressEntity, Integer> {

    // Find all addresses for a user (returns List for multiple addresses)
    List<AddressEntity> findByUserId(Integer userId);
    
    // Optional: Find default address for a user
    Optional<AddressEntity> findByUserIdAndIsDefaultTrue(Integer userId);
}