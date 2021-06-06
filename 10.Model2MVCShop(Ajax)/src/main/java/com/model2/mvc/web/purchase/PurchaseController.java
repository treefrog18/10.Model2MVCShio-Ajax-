package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

//==> 구매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model ) throws Exception {
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		System.out.println("/addPurchase.do : GET");
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, 
			 @RequestParam("buyerId") String buyerId,Model model ) throws Exception {

		System.out.println("/addPurchase.do : POST");
		String divyDate = purchase.getDivyDate().replace("-", "");
		System.out.println(divyDate);
		purchase.setDivyDate(divyDate);
		User user = userService.getUser(buyerId);
		purchase.setBuyer(user);
		purchaseService.addPurchase(purchase);
		model.addAttribute("purchase", purchase);
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search, 
			 Model model, HttpServletRequest request) throws Exception{
		
		System.out.println("/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		HttpSession session = request.getSession();
		String buyerId = (String)session.getAttribute("userId"); 
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPrurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		System.out.println("/getPurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchaseView( @RequestParam("tranNo") int tranNo, Model model ) throws Exception{

		System.out.println("/updatePurchaseView.do");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
	
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase, Model model,
			@RequestParam("buyerId") String buyerId) throws Exception{

		System.out.println("/updatePurchase : POST");
		//Business Logic
		//int prodNo = product.getProdNo();
		String divyDate = purchase.getDivyDate().replace("-", "");
		System.out.println(divyDate);
		purchase.setDivyDate(divyDate);
		User user = userService.getUser(buyerId);
		purchase.setBuyer(user);
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/listPurchase";
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTrancode( Model model,
			@RequestParam(value="prodNo", required=false) Integer prodNo,
			@RequestParam(value="tranNo", required=false) Integer tranNo) throws Exception{

		System.out.println("/updateTranCode");
		if(prodNo != null) {
			Purchase purchase = purchaseService.getPurchase2(prodNo);
			purchaseService.updateTranCode(purchase);
			return "forward:/product/listProduct.do?menu=manage";
		}else {
			Purchase purchase = purchaseService.getPurchase(tranNo);
			purchaseService.updateTranCode(purchase);
			return "redirect:/purchase/listPurchase";
		}
	}
	
}