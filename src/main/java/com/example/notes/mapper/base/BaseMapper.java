package com.example.notes.mapper.base;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public abstract class BaseMapper<X, Y> {

    public abstract X convertToEntity(Y dto, Object... args);
    public abstract Y convertToDto(X entity, Object... args);

    public Collection<X> convertToEntity(Collection<Y> dto, Object... args) {
        return dto
                .stream()
                .map(y -> convertToEntity(y, args))
                .collect(Collectors.toList());
    }

    public Collection<Y> convertToDto(Collection<X> entity, Object... args) {
        return entity
                .stream()
                .map(x -> convertToDto(x, args))
                .collect(Collectors.toList());
    }

    public List<X> convertToEntityList(Collection<Y> dto, Object... args) {
        return convertToEntity(dto, args)
                .stream()
                .collect(Collectors.toList());
    }

    public List<Y> convertToDtoList(Collection<X> entity, Object... args) {
        return convertToDto(entity, args)
                .stream()
                .collect(Collectors.toList());
    }

    public Set<X> convertToEntitySet(Collection<Y> dto, Object... args) {
        return convertToEntity(dto, args)
                .stream()
                .collect(Collectors.toSet());
    }

    public Set<Y> convertToDtoSet(Collection<X> entity, Object... args) {
        return convertToDto(entity, args)
                .stream()
                .collect(Collectors.toSet());
    }

}
