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
public class MotorcycleStatus implements Serializable {
    private int motorcycleStatusId;
    private int motorcycleDetailId;
    private String staffId;
    private String status;
    private String updateDate;
    private String note;
}
