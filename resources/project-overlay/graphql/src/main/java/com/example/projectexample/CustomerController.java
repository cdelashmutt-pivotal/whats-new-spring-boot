package com.example.projectexample;

import java.util.Collection;

import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomerController {
  
  private final CustomerRepository repository;

  public CustomerController(CustomerRepository repository) {
    this.repository = repository;
  }

  @QueryMapping
  public Collection<Customer> customersByName(@Argument String name) {
    return this.repository.findByName(name);
  }

  @ResponseBody
  @GetMapping("/customers")
  public Iterable<Customer> customers() {
      return this.repository.findAll();
  }
  
}
