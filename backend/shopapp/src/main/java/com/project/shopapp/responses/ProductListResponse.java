package com.project.shopapp.responses;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor

// Set pagination function
public class ProductListResponse {
    private List<ProductResponse> products;
    private int totalPages;
}
