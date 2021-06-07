package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	//@Test
	public void testAddPurchase() throws Exception{
		
		System.out.println("addPurchase() 시작");
		
		Purchase purchase = new Purchase();
		User user = new User();
		String userId = "user03";
		int prodNo = 10100;
		
		user = userService.getUser(userId);
		
		purchase.setProdNo(prodNo);
		purchase.setBuyer(user);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("탈론");
		purchase.setReceiverPhone("111-2222-3333");
		purchase.setDivyAddr("아이오니아");
		purchase.setDivyRequest("빨리 갖다주세요");
		purchase.setDivyDate("20230508");
		
		purchaseService.addPurchase(purchase);
		
		System.out.println(purchase);
		
		//Assert.assertEquals("10061", purchase.getTranNo());
		Assert.assertEquals(10100, purchase.getProdNo());
		Assert.assertEquals("user03", purchase.getBuyer());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("탈론", purchase.getReceiverName());
		Assert.assertEquals("111-2222-3333", purchase.getReceiverPhone());
		Assert.assertEquals("아이오니아", purchase.getDivyAddr());
		Assert.assertEquals("빨리 갖다주세요", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
	}
	
	
	//@Test
	public void testGetPurchase() throws Exception{
		
		System.out.println("tetGetPurchase() 시작");
		Purchase purchase = new Purchase();
		int tranNo = 10023;
		
		purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println(purchase);
		
		Assert.assertEquals(10023, purchase.getTranNo());
		Assert.assertEquals(10007, purchase.getProdNo());
		Assert.assertEquals("user05", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("트린다미어", purchase.getReceiverName());
		Assert.assertEquals("010-555-444", purchase.getReceiverPhone());
		Assert.assertEquals("프렐요드", purchase.getDivyAddr());
		Assert.assertEquals("택배함에넣어주세요", purchase.getDivyRequest());
		Assert.assertEquals("2", purchase.getTranCode());
	}
	
	
	//@Test
	public void testGetPurchase2() throws Exception{
		
		System.out.println("tetGetPurchase2() 시작");
		Purchase purchase = new Purchase();
		int prodNo = 10040;
		
		purchase = purchaseService.getPurchase2(prodNo);
		
		System.out.println(purchase);
		
		Assert.assertEquals(10020, purchase.getTranNo());
		Assert.assertEquals(10040, purchase.getProdNo());
		Assert.assertEquals("user05", purchase.getBuyer().getUserId());
		//Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("이성계", purchase.getReceiverName());
		Assert.assertEquals("123", purchase.getReceiverPhone());
		Assert.assertEquals("321", purchase.getDivyAddr());
		Assert.assertEquals("123", purchase.getDivyRequest());
		Assert.assertEquals("3", purchase.getTranCode().trim());
	}
	
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		System.out.println("testUpdatePurchase() 시작");
		Purchase purchase = new Purchase();
		int tranNo = 10040;
		
		purchase.setTranNo(tranNo);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("케넨");
		purchase.setReceiverPhone("778899");
		purchase.setDivyAddr("자운");
		purchase.setDivyRequest("번개배송");
		purchase.setDivyDate("20290904");
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);	
	}
	
	
	//@Test
	public void testUpdateTranCode() throws Exception{
		System.out.println("testUpdateTranCode() 시작");
		int tranNo = 10080;
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);
		purchaseService.updateTranCode(purchase);
		
		System.out.println(purchase);
		
		Assert.assertEquals(10080, purchase.getTranNo());
		Assert.assertEquals("2", purchase.getTranCode());
	}
	
	
	//@Test
	public void testGetSaleList() throws Exception{
		System.out.println("testGetSaleList() 시작");
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	String buyerId = null;
	 	
	 	
	 	Map<String, Object> map = purchaseService.getSaleList(search, buyerId);
	 	List<Object> list = (List<Object>)map.get("list");
		
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	}
	

	@Test
	public void testGetPurchaseList() throws Exception{
		System.out.println("testGetPurchaseList() 시작");
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
	 	User user = new User();
		String buyerId = "user05";
	
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	}
}
