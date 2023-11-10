package com.example.notes.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class ApiErrorDTO {

    @JsonProperty(value = "path")
    private String path;

    @JsonProperty(value = "message")
    private String message;

    @JsonProperty(value = "status_code")
    private Integer statusCode;

    @JsonProperty(value = "local_date_time")
    private LocalDateTime localDateTime;

}
