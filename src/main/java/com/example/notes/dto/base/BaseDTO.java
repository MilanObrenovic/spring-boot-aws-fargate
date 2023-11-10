package com.example.notes.dto.base;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.MappedSuperclass;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@SuperBuilder
@MappedSuperclass
@NoArgsConstructor
@AllArgsConstructor
public abstract class BaseDTO {

    @JsonProperty(value = "id")
    protected Long id;

    @JsonProperty(value = "created_at")
    protected LocalDateTime createdAt;

    @JsonProperty(value = "updated_at")
    protected LocalDateTime updatedAt;

}
