package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.UserEntity;

import java.time.LocalDate;
import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {

	Optional<UserEntity>  findByEmail(String email);
	List<UserEntity> findByRole(String role);
	// UserRepository.java
	long countByRole(String role);
	
	@Query("SELECT COUNT(u) FROM UserEntity u WHERE u.createdAt BETWEEN :start AND :end")
	long countByCreatedAtBetween(@Param("start") LocalDate start, @Param("end") LocalDate end);
}
