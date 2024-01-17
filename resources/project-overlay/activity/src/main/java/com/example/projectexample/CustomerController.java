package com.example.projectexample;

import java.util.Collection;

import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.graphql.data.method.annotation.SchemaMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.projectexample.BoredClient.Activity;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomerController {
  
  private final CustomerRepository repository;

  private final BoredClient boredClient;

  public CustomerController(CustomerRepository repository, BoredClient boredClient) {
    this.repository = repository;
    this.boredClient = boredClient;
  }

  @SchemaMapping(typeName="Customer")
  public Activity suggestedActivity(Customer customer) {
    return this.boredClient.suggestSomethingToDo();
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
