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
public class PriceList implements Serializable{
    private int priceListId;
    private double dailyPriceForDay;
    private double dailyPriceForWeek;
    private double dailyPriceForMonth;
}
