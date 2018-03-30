package com.SpringCommerce.controller;

import com.SpringCommerce.dao.ProductDao;
import com.SpringCommerce.model.Product;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;


@Controller
public class HomeController {

    @Autowired
    private ProductDao productDao;


    @RequestMapping("/")
    public String home() {
        return "home";
    }


    @RequestMapping("/productList")
    public String getProducts(Model model) {
        List<Product> products = productDao.getAllProducts();
        model.addAttribute("products", products);
        return "productList";
    }

    @RequestMapping("/admin")
    public String adminPanel() {
        return "admin";
    }



    @RequestMapping("/addProduct")
    public String addProduct(Model model) {
        Product product = new Product();
//        String productGenerator = UUID.randomUUID().toString().substring(0,6);

        product.setProductCategory("instrument");
        product.setProductCondition("new");
        product.setProductStatus("active");

        model.addAttribute("product", product);

        return "/addProduct";
    }

    @RequestMapping(value = "/addProduct", method = RequestMethod.POST)
    public String addProductPost(@Valid @ModelAttribute("product") Product product, BindingResult result, @RequestParam("file") MultipartFile file) throws IOException {
        if (result.hasErrors()) {

            return "addProduct";
        }


        byte[] bytes = null;
        try {
            bytes = file.getBytes();
        } catch (IOException e) {

            e.printStackTrace();
        }
        product.setPic(bytes);
//        product.setProductId(UUID.randomUUID().toString().substring(0, 6));
        productDao.addProduct(product);
        return "redirect:/productList";
    }


    @RequestMapping("admin/productInventory")
    public String productInventory(Model model) {
        List<Product> products = productDao.getAllProducts();
        model.addAttribute("products", products);

        return "productInventory";
    }

    @RequestMapping("/viewProduct/{productId}")
    public String viewProduct(@PathVariable String productId, Model model) throws IOException {
        Product product = productDao.getProductById(productId);
        model.addAttribute(product);


        return "/viewProduct";
    }


    @RequestMapping(method = RequestMethod.GET, value = "/getUserImage/{id}")
    public void getUserImage(HttpServletResponse response, @PathVariable("id") String productId) throws IOException {

        response.setContentType("image/jpeg");
        byte[] buffer = productDao.getProductById(productId).getPic();
        InputStream in1 = new ByteArrayInputStream(buffer);
        IOUtils.copy(in1, response.getOutputStream());
    }

    @RequestMapping({"admin/deleteProduct/{id}"})
    public String deleteProduct(@PathVariable String id) {
        this.productDao.deleteProduct(id);
        return "redirect:/productList";
    }

    @RequestMapping("admin/editProduct/{id}")
    public String editProduct(@PathVariable String id, Model model) {
        Product product = productDao.getProductById(id);
        model.addAttribute(product);

        return "editProduct";
    }

    @RequestMapping(value = "/editProduct", method = RequestMethod.POST)
    public String editProduct(@ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file, Model model) {
        byte[] bytes = null;
        try {
            bytes = file.getBytes();
        } catch (IOException e) {

            e.printStackTrace();
        }
        product.setPic(bytes);
        productDao.editProduct(product);
        return "redirect:/productList";
    }
}