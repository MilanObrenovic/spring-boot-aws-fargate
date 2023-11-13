package com.example.notes.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping(value = "/api/v1/ping")
public class PingPongController {

    @GetMapping("/pong")
    public ResponseEntity<String> findPong() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body("Pong!");
    }

}
