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

public class Motorcycle implements Serializable{
    private String motorcycleId;
    private String model;
    private String image;
    private String displacement;
    private String description;
    private int minAge;
    private int brandID;
    private int categoryID;
    private int priceListID;
    private List<MotorcycleDetail> listMotorcycleDetails;

    public Motorcycle(String motorcycleId, String model, String image, String displacement, String description, int minAge, int brandID, int categoryID, int priceListID) {
        this.motorcycleId = motorcycleId;
        this.model = model;
        this.image = image;
        this.displacement = displacement;
        this.description = description;
        this.minAge = minAge;
        this.brandID = brandID;
        this.categoryID = categoryID;
        this.priceListID = priceListID;
    }
    
}