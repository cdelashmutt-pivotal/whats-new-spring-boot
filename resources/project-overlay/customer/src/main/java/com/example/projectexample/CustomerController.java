package com.example.projectexample;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomerController {
  
  private final CustomerRepository repository;

  public CustomerController(CustomerRepository repository) {
    this.repository = repository;
  }

  @ResponseBody
  @GetMapping("/customers")
  public Iterable<Customer> customers() {
      return this.repository.findAll();
  }
  
}
