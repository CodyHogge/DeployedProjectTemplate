package com.ex.LaunchTest.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ex.LaunchTest.models.Users;

public interface UsersRepository extends JpaRepository<Users, Long>{
	@Query("FROM Users WHERE email=?1 OR firstName=?1 OR lastName=?1")
	List<Users> searchUser(String keyword);
	
	@Query("SELECT u FROM Users u WHERE u.email=:email AND " + 
	"u.firstName LIKE (CONCAT('%',:name,'%')) OR u.lastName =:name")
	List<Users> customSearchUser(@Param("name") String name, @Param("email") String email);
	
	@Query("FROM Users WHERE email=?1 AND password=?2 ")
	Optional<Users> login(String email, String password);
	//find user by email	
	Optional<Users> findUserByEmail(String email);


}
