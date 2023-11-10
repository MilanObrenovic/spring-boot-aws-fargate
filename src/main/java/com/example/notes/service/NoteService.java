package com.example.notes.service;

import com.example.notes.dto.NoteDTO;
import com.example.notes.dto.request.NoteCreateRequestDTO;
import com.example.notes.dto.request.NoteUpdateRequestDTO;
import com.example.notes.exception.RequestValidationException;
import com.example.notes.exception.ResourceNotFoundException;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface NoteService {

    NoteDTO createNote(NoteCreateRequestDTO requestDTO);
    NoteDTO findNoteById(Long noteId) throws ResourceNotFoundException;
    List<NoteDTO> findPaginatedNotes(Pageable pageable);
    NoteDTO updateNoteById(Long noteId, NoteUpdateRequestDTO requestDTO) throws ResourceNotFoundException, RequestValidationException;
    void deleteNoteById(Long noteId) throws ResourceNotFoundException;

}
