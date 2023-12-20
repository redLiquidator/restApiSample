package com.provider.api.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApiVO {
	private String id;
	private String nm;
	private Date brdt;
	private String mbl_no;
	private String insp_rsvt_no;
	private String insp_addr;
	private Date insp_dt;	
}
