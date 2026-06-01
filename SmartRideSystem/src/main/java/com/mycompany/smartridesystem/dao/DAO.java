package com.mycompany.smartridesystem.dao;

import java.util.List;

public interface DAO<T> { //cÃ¡i nÃ o cáº§n nhá»¯ng hÃ m nÃ y thÃ¬ impl, sáº½ update thÃªm nhá»¯ng hÃ m Ä‘c dÃ¹ng nhiá»u láº§n
    List<T> getAll();
    void insert(T t);
    void update(T t);
    void delete(T t);
}
