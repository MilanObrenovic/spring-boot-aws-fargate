package com.example.notes.handler;

import com.example.notes.dto.ApiErrorDTO;
import com.example.notes.exception.DuplicateResourceException;
import com.example.notes.exception.RequestValidationException;
import com.example.notes.exception.ResourceNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.LocalDateTime;

@ControllerAdvice
public class DefaultExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiErrorDTO> handleException(
            ResourceNotFoundException e,
            HttpServletRequest request
    ) {
        return apiErrorResponseEntity(
                e,
                request,
                HttpStatus.NOT_FOUND
        );
    }

    @ExceptionHandler(DuplicateResourceException.class)
    public ResponseEntity<ApiErrorDTO> handleException(
            DuplicateResourceException e,
            HttpServletRequest request
    ) {
        return apiErrorResponseEntity(
                e,
                request,
                HttpStatus.CONFLICT
        );
    }

    @ExceptionHandler(RequestValidationException.class)
    public ResponseEntity<ApiErrorDTO> handleException(
            RequestValidationException e,
            HttpServletRequest request
    ) {
        return apiErrorResponseEntity(
                e,
                request,
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiErrorDTO> handleException(
            Exception e,
            HttpServletRequest request
    ) {
        return apiErrorResponseEntity(
                e,
                request,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    private <T extends Exception> ResponseEntity<ApiErrorDTO> apiErrorResponseEntity(
            T e,
            HttpServletRequest request,
            HttpStatus status
    ) {
        String path = request.getRequestURI();
        String message = e.getMessage();
        LocalDateTime localDateTime = LocalDateTime.now();

        ApiErrorDTO apiErrorDTO = ApiErrorDTO
                .builder()
                .path(path)
                .message(message)
                .statusCode(status.value())
                .localDateTime(localDateTime)
                .build();

        return new ResponseEntity<>(
                apiErrorDTO,
                status
        );
    }

}
