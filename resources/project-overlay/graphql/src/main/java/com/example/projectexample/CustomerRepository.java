package com.example.projectexample;

import java.util.Collection;

import org.springframework.data.repository.CrudRepository;

public interface CustomerRepository 
extends CrudRepository<Customer, Integer>{
  Collection<Customer> findByName(String name);
}
