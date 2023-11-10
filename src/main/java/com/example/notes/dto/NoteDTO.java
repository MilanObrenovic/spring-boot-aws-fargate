package com.example.notes.dto;

import com.example.notes.dto.base.BaseDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Builder
@EqualsAndHashCode(callSuper = true)
public class NoteDTO extends BaseDTO {

    @JsonProperty(value = "title")
    private String title;

    @JsonProperty(value = "subtitle")
    private String subtitle;

    @JsonProperty(value = "description")
    private String description;

}
