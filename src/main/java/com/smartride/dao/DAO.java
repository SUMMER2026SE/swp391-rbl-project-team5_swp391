package com.smartride.dao;

import java.util.List;

public interface DAO<T> { //cái nào cần những hàm này thì impl, sẽ update thêm những hàm đc dùng nhiều lần
    List<T> getAll();
    void insert(T t);
    void update(T t);
    void delete(T t);
}
