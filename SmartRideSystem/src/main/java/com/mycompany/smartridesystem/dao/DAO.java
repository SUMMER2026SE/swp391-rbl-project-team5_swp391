
package com.mycompany.smartridesystem.dao;

import java.util.List;


public interface DAO<T> { 
    List<T> getAll();
    void insert(T t);
    void update(T t);
    void delete(T t);
}
