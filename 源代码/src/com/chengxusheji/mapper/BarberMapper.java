package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Barber;

public interface BarberMapper {
	/*添加理发师信息*/
	public void addBarber(Barber barber) throws Exception;

	/*按照查询条件分页查询理发师记录*/
	public ArrayList<Barber> queryBarber(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有理发师记录*/
	public ArrayList<Barber> queryBarberList(@Param("where") String where) throws Exception;

	/*按照查询条件的理发师记录数*/
	public int queryBarberCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条理发师记录*/
	public Barber getBarber(int barberId) throws Exception;

	/*更新理发师记录*/
	public void updateBarber(Barber barber) throws Exception;

	/*删除理发师记录*/
	public void deleteBarber(int barberId) throws Exception;

}
