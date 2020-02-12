package dto.response;

import models.Product;

public class SucceedMessageDto {
    public Product product;

    public SucceedMessageDto(Product p) {
        product = p;
    }
}
