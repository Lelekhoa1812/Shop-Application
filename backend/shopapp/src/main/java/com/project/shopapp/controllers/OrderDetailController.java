package com.project.shopapp.controllers;

import com.project.shopapp.dtos.*;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("${api.prefix}/order_details")
//@RequestMapping("api/v1/order_details")
public class OrderDetailController {
    // Add new order detail
    @PostMapping("")
    public ResponseEntity<?> createOrderDetail(
            @Valid  @RequestBody OrderDetailDTO newOrderDetail) {
        return ResponseEntity.ok("createOrderDetail here");
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getOrderDetail(
            @Valid @PathVariable("id") Long id) {
        return ResponseEntity.ok("getOrderDetail with id = "+id);
    }

    // View an order detail list
    @GetMapping("/order/{orderId}")
    public ResponseEntity<?> getOrderDetails(@Valid @PathVariable("orderId") Long orderId) {
        return ResponseEntity.ok("getOrderDetails with orderId = "+orderId);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateOrderDetail(
            @Valid @PathVariable("id") Long id,
            @RequestBody OrderDetailDTO newOrderDetailData) {
        return ResponseEntity.ok("updateOrderDetail with id="+id
                +",newOrderDetailData: "+newOrderDetailData);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrderDetail(
            @Valid @PathVariable("id") Long id) {
        return ResponseEntity.noContent().build();
    }
}
