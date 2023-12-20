package com.provider.api.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuVO {
	private int id;
	private String name;
	private int price;
	private Date orderDate;
	
	private int tableno;
}
