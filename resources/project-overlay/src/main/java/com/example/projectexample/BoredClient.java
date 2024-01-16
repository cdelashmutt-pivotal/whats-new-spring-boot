package com.example.projectexample;

import org.springframework.web.service.annotation.GetExchange;

public interface BoredClient {
  
  @GetExchange("/activity")
  Activity suggestSomethingToDo();

  record Activity(String activity, int participants) {
    
  }

}
