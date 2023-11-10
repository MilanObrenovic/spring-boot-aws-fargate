package com.example.notes.mapper;

import com.example.notes.dto.NoteDTO;
import com.example.notes.mapper.base.BaseMapper;
import com.example.notes.model.Note;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@AllArgsConstructor
public class NoteMapper extends BaseMapper<Note, NoteDTO> {

    @Override
    public Note convertToEntity(NoteDTO dto, Object... args) {
        Note entity = Note.builder().build();
        if (dto != null) {
            BeanUtils.copyProperties(dto, entity);
        }
        return entity;
    }

    @Override
    public NoteDTO convertToDto(Note entity, Object... args) {
        NoteDTO dto = NoteDTO.builder().build();
        if (entity != null) {
            BeanUtils.copyProperties(entity, dto);
        }
        return dto;
    }

}
