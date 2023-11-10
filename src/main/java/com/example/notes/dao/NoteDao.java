package com.example.notes.dao;

import com.example.notes.model.Note;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface NoteDao {

    Note createNote(Note note);
    Optional<Note> findNoteById(Long noteId);
    List<Note> findPaginatedNotes(Pageable pageable);
    Note updateNote(Note note);
    void deleteNoteById(Long noteId);

}
