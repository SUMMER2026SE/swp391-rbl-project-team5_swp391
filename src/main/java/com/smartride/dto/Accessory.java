package com.smartride.dto;

import java.io.Serializable;
import java.util.List;
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
public class Accessory implements Serializable {

    private int accessoryId;
    private String accessoryName;
    private String accessoryImage;
    private String accessoryImageicon;
    private String accessoryDescription;
    private double price;
}
