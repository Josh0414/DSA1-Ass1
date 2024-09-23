import ballerina/io;

ShoppingServiceClient shoppingClient = check new ("http://localhost:9090");

public function main() returns error? {

    string keepRunningClient = "yes";
    io:println("Client started successfully. Choose an operation:");

    while keepRunningClient.equalsIgnoreCaseAscii("yes") {

        io:println("Choose an operation:");
        io:println("1. Add Product");
        io:println("2. List Available Products");
        io:println("3. Search Product by SKU");
        io:println("4. Add to Cart");
        io:println("5. Place Order");
        string choice = io:readln("Enter your choice (1-5): ");
        if choice.equalsIgnoreCaseAscii("1") {
            _ = check addProduct();
        }
        if choice == "2" {
            listAvailableProducts();
        }
        if choice == "3" {
            searchProduct();
        }
        if choice == "4" {
            addToCart();
        }
        if choice == "5" {
            placeOrder();
        }
    }

    keepRunningClient = io:readln("Continue: (yes/no)");
}

public function addProduct() returns error? {

    string sku = io:readln("Enter product SKU: ");
    string name = io:readln("Enter product name: ");
    string description = io:readln("Enter product description: ");
    string priceInput = io:readln("Enter product price: ");
    float price = check float:fromString(priceInput);
    string status = io:readln("Enter product status (available/unavailable): ");

    Product product = {
        sku: sku,
        name: name,
        description: description,
        price: price,
        status: status
    };

    var response = shoppingClient->AddProduct(product);
    if (response is ProductCode) {
        io:println("Product added successfully! Product Code: " + response.code);
    } else {
        io:println("Failed to add product: " + response.toString());
    }
}

public function listAvailableProducts() {

    var response = shoppingClient->ListAvailableProducts({});
    if (response is ProductList) {
        io:println("Available products:");
        foreach var product in response.products {
            io:println("SKU: " + product.sku + ", Name: " + product.name + ", Price: " + product.price.toString());
        }
    } else {
        io:println("Failed to list products: " + response.toString());
    }
}

public function searchProduct() {

    string sku = io:readln("Enter product SKU to search: ");

    ProductCode productCode = {code: sku};

    var response = shoppingClient->SearchProduct(productCode);
    if (response is Product) {
        io:println("Product found: " + response.name + " (Price: " + response.price.toString() + ")");
    } else {
        io:println("Product not found: " + response.toString());
    }
}

public function addToCart() {
    string userId = io:readln("Enter user ID: ");
    string sku = io:readln("Enter product SKU to add to cart: ");

    CartItem cartItem = {
        userId: userId,
        sku: sku
    };

    var response = shoppingClient->AddToCart(cartItem);
    if (response is CartResponse) {
        io:println(response.message);
    } else {
        io:println("Failed to add item to cart: " + response.toString());
    }
}

public function placeOrder() {
    string userId = io:readln("Enter user ID to place the order: ");

    UserId userIdMessage = {id: userId};

    var response = shoppingClient->PlaceOrder(userIdMessage);
    if (response is OrderResponse) {
        io:println("Order placed! Order ID: " + response.orderId);
    } else {
        io:println("Failed to place order: " + response.toString());
    }
}
