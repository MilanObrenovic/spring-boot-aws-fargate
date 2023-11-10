package com.example.notes.serviceImpl;

import com.example.notes.dao.NoteDao;
import com.example.notes.dto.NoteDTO;
import com.example.notes.dto.request.NoteCreateRequestDTO;
import com.example.notes.dto.request.NoteUpdateRequestDTO;
import com.example.notes.exception.RequestValidationException;
import com.example.notes.exception.ResourceNotFoundException;
import com.example.notes.mapper.NoteMapper;
import com.example.notes.model.Note;
import com.example.notes.service.NoteService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class NoteServiceImpl implements NoteService {

    @Qualifier("noteJpa")
    private final NoteDao noteDaoJpa;

    private final NoteMapper noteMapper;

    @Override
    public NoteDTO createNote(
            NoteCreateRequestDTO requestDTO
    ) throws RequestValidationException {

        // If this field is empty (""), null or whitespace only, throw error
        if (StringUtils.isBlank(requestDTO.getTitle())) {
            throw new RequestValidationException(
                    "You must enter a note title."
            );
        }

        // If this field is empty (""), null or whitespace only, throw error
        if (StringUtils.isBlank(requestDTO.getDescription())) {
            throw new RequestValidationException(
                    "You must enter a note description."
            );
        }

        Note note = Note
                .builder()
                .title(requestDTO.getTitle())
                .subtitle(requestDTO.getSubtitle())
                .description(requestDTO.getDescription())
                .build();

        Note createdNote = noteDaoJpa.createNote(note);
        return noteMapper.convertToDto(createdNote);
    }

    @Override
    public NoteDTO findNoteById(
            Long noteId
    ) throws ResourceNotFoundException {
        return noteDaoJpa
                .findNoteById(noteId)
                .map(noteMapper::convertToDto)
                .orElseThrow(
                        () -> new ResourceNotFoundException(
                                "Could not find note with ID [%d].".formatted(noteId)
                        )
                );
    }

    @Override
    public List<NoteDTO> findPaginatedNotes(Pageable pageable) {
        List<Note> paginatedNotes = noteDaoJpa.findPaginatedNotes(pageable);
        return noteMapper.convertToDtoList(paginatedNotes);
    }

    @Override
    public NoteDTO updateNoteById(
            Long noteId,
            NoteUpdateRequestDTO requestDTO
    ) throws ResourceNotFoundException, RequestValidationException {

        // Find an existing note by ID
        NoteDTO existingNoteDTO = findNoteById(noteId);

        // By default, let's assume that no field has been changed
        boolean changes = false;

        // If there was a change, update it
        if (canUpdateField(existingNoteDTO.getTitle(), requestDTO.getTitle())) {
            existingNoteDTO.setTitle(requestDTO.getTitle().trim());
            changes = true;
        }

        // If there was a change, update it
        if (canUpdateField(existingNoteDTO.getSubtitle(), requestDTO.getSubtitle())) {
            existingNoteDTO.setSubtitle(requestDTO.getSubtitle().trim());
            changes = true;
        }

        // If there was a change, update it
        if (canUpdateField(existingNoteDTO.getDescription(), requestDTO.getDescription())) {
            existingNoteDTO.setDescription(requestDTO.getDescription().trim());
            changes = true;
        }

        // If there are no changes, throw exception
        if (!changes) {
            throw new RequestValidationException(
                    "No data changes found."
            );
        }

        // Convert the DTO note into JPA entity
        Note existingNote = noteMapper.convertToEntity(
                existingNoteDTO
        );

        // Update the note in postgres database
        Note updatedNote = noteDaoJpa.updateNote(
                existingNote
        );

        // Return the updated note
        return noteMapper.convertToDto(updatedNote);

    }

    @Override
    public void deleteNoteById(
            Long noteId
    ) throws ResourceNotFoundException {
        // Ensure the note exists before trying to delete it
        NoteDTO existingNote = findNoteById(noteId);

        // By this point the note exists, so delete it
        noteDaoJpa.deleteNoteById(existingNote.getId());
    }

    private boolean canUpdateField(String oldValue, String newValue) {
        // If this field is empty (""), null or whitespace only, skip it
        if (StringUtils.isBlank(newValue)) {
            return false;
        }

        // If this field is equal to the old field, no need to update it
        int result = StringUtils.compare(oldValue, newValue);
        if (result == 0) {
            return false;
        }

        // This field is genuinely new, so update it
        return true;
    }

}
