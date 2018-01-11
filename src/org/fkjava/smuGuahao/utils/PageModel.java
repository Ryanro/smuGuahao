package org.fkjava.smuGuahao.utils;

/**
 * @Author 徐磊(Dlei)
 * @Email dlei0009@163.com
 * @Tel 18665616520	
 * @From http://www.fkjava.org 
 * @Date 2018年1月3日下午3:11:44 
 * 分页实体：封装了一个页面当前分页信息
 */
public class PageModel {
	
	private int pageIndex ;// 当前页码 
	private int pageSize=3;
	private int totalCount ; // 当前查询条件下可以分页的总数据量
	// 总页数：
	public int getPageCount(){
		//  totalCount 9 
		//  pageSize  3      
		return (this.getTotalCount() - 1) / this.getPageSize() + 1 ;
	}
	public int getPageIndex() {
		// 如果当前页码是0默认返回第一页
		this.pageIndex = this.pageIndex <= 0 ? 1 : this.pageIndex;
	    // 如果当前页码超过了最后一页默认返回最后一页
		this.pageIndex = this.pageIndex >= this.getPageCount() ? this.getPageCount():this.pageIndex;
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	// 分页的第一个参数值 
	/*SELECT * FROM doc_doctor LIMIT 0 , 3
      MySql的分页查询语句
	 pageIndex 1 
	 pageSize  3 
	 第一个参数：(pageIndex - 1) * pageSize  
	 第二个参数:  pageSize*/ 
	public int getFirstPageParam(){
		return (this.getPageIndex() - 1) * this.getPageSize();
	}
	
}
