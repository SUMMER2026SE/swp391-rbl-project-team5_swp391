package com.smartride.dto;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Contact implements Serializable{

    private int contactID;
    private String name;
    private String phoneNumber;
    private String email;
    private String title;
    private String message;
    private int accountID;
    
    
    
}
