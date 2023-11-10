package com.example.notes.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NoteUpdateRequestDTO {

    @JsonProperty(value = "title", required = true)
    private String title;

    @JsonProperty(value = "subtitle")
    private String subtitle;

    @JsonProperty(value = "description", required = true)
    private String description;

}
