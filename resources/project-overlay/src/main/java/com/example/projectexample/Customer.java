package com.example.projectexample;

import org.springframework.data.annotation.Id;

public record Customer(@Id Integer id, String Name) {
  
}
