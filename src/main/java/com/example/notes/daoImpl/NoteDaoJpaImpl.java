package com.example.notes.daoImpl;

import com.example.notes.dao.NoteDao;
import com.example.notes.model.Note;
import com.example.notes.repository.NoteRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@Repository("noteJpa")
public class NoteDaoJpaImpl implements NoteDao {

    private final NoteRepository noteRepository;

    @Override
    public Note createNote(Note note) {
        return noteRepository.save(note);
    }

    @Override
    public Optional<Note> findNoteById(Long noteId) {
        return noteRepository.findById(noteId);
    }

    @Override
    public List<Note> findPaginatedNotes(Pageable pageable) {
        return noteRepository.findAll(pageable).getContent();
    }

    @Override
    public Note updateNote(Note note) {
        return noteRepository.save(note);
    }

    @Override
    public void deleteNoteById(Long noteId) {
        noteRepository.deleteById(noteId);
    }

}
