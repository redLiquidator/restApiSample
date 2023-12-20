package com.provider.api.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.provider.api.model.MenuVO;

@Mapper
public interface MenuMapper {
	public List<MenuVO> getAllMenu();
	public List<MenuVO> findMenuById(int id);

	//place an order
	public void InsertOrder(MenuVO menuVO);

}
