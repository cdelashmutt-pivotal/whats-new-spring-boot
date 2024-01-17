package com.example.projectexample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@SpringBootApplication
public class ProjectExampleApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectExampleApplication.class, args);
	}

	@Bean
	BoredClient boredClient(WebClient.Builder builder) {
		var wc = builder
				.baseUrl("https://www.boredapi.com/api/").build();
		var wca = WebClientAdapter.create(wc);
		return HttpServiceProxyFactory
				.builderFor(wca)
				.build()
				.createClient(BoredClient.class);
	}
}
