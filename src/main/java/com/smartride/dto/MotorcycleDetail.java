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

public class MotorcycleDetail implements Serializable {
    private int motorcycleDetailId;
    private String motorcycleId;
    private String licensePlate;
    private String statusAction;
    private String note;
    
    public MotorcycleDetail(int motorcycleDetailId, String motorcycleId, String licensePlate) {
        this.motorcycleDetailId = motorcycleDetailId;
        this.motorcycleId = motorcycleId;
        this.licensePlate = licensePlate;
    }
}
