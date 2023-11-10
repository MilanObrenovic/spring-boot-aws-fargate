package com.example.notes.controller;

import com.example.notes.dto.NoteDTO;
import com.example.notes.dto.request.NoteCreateRequestDTO;
import com.example.notes.dto.request.NoteUpdateRequestDTO;
import com.example.notes.service.NoteService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping(value = "/api/v1/notes")
public class NoteController {

    private final NoteService noteService;

    @PostMapping()
    public ResponseEntity<NoteDTO> createNote(
            @RequestBody NoteCreateRequestDTO requestDTO
    ) {
        NoteDTO noteDTO = noteService.createNote(requestDTO);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(noteDTO);
    }

    @GetMapping("/{noteId}")
    public ResponseEntity<NoteDTO> findNoteById(
            @PathVariable("noteId") Long noteId
    ) {
        NoteDTO noteDTO = noteService.findNoteById(noteId);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(noteDTO);
    }

    @GetMapping()
    public ResponseEntity<List<NoteDTO>> findPaginatedNotes(
            Pageable pageable
    ) {
        List<NoteDTO> paginatedNoteDTOs = noteService.findPaginatedNotes(pageable);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(paginatedNoteDTOs);
    }

    @PutMapping("/{noteId}")
    public ResponseEntity<NoteDTO> updateNoteById(
            @PathVariable("noteId") Long noteId,
            @RequestBody NoteUpdateRequestDTO requestDTO
    ) {
        NoteDTO updatedNoteDTO = noteService.updateNoteById(
                noteId,
                requestDTO
        );
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(updatedNoteDTO);
    }

    @DeleteMapping("/{noteId}")
    public ResponseEntity<Void> deleteNoteById(
            @PathVariable("noteId") Long noteId
    ) {
        noteService.deleteNoteById(noteId);
        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }

}
