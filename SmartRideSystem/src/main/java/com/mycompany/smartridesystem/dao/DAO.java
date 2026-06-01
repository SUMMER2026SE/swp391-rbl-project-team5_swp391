/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.smartridesystem.dao;

import java.util.List;

/**
 *
 * @author LeQuangMinh
 */
public interface DAO<T> { //cÃ¡i nÃ o cáº§n nhá»¯ng hÃ m nÃ y thÃ¬ impl, sáº½ update thÃªm nhá»¯ng hÃ m Ä‘c dÃ¹ng nhiá»u láº§n
    List<T> getAll();
    void insert(T t);
    void update(T t);
    void delete(T t);
}
