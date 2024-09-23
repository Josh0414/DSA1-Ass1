import ballerina/grpc;
import ballerina/uuid;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingService" on ep {
    private table<Product> key(sku) products = table [
        {sku: "1234-0987-7664", name: "Shoes", description: "Nice shoes", price: 890.99, status: "available"}
    ];
    private table<User> key(id) users = table [
        {id: "josh21", name: "Josh", isAdmin: false}
    ];
    private table<CartItem> key() carts = table [];
    private table<Order> key(orderId) orders = table [];

    remote function AddProduct(Product value) returns ProductCode|error {
        do {
            self.products.add(value);
            return {code: value.sku};
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function UpdateProduct(Product value) returns Product|error {
        do {
            if (!self.products.hasKey(value.sku)) {
                return error("Product not found");
            }
            _ = self.products.put(value);

            Product? product = self.products[value.sku];
            if (product is ()) {
                return error("Product not found");
            }
            return product;
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function RemoveProduct(ProductCode value) returns ProductList|error {
        do {
            if (!self.products.hasKey(value.code)) {
                return error("Product not found");
            }
            _ = self.products.remove(value.code);
            return {products: self.products.toArray()};
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function ListAvailableProducts(Empty value) returns ProductList|error {
        do {
            Product[] availableProducts = from var product in self.products
                where product.status == "available"
                select product;
            
            return {products: availableProducts};
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function SearchProduct(ProductCode value) returns Product|error {
        do {

            Product? product = self.products[value.code];
            if (product is ()) {
                return error("Product not found");
            }
            return product;
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function AddToCart(CartItem value) returns CartResponse|error {
        do {
            if (!self.users.hasKey(value.userId)) {
                return error("User not found");
            }
            if (!self.products.hasKey(value.sku)) {
                return error("Product not found");
            }
            self.carts.add(value);
            return {message: "Product added to cart"};
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function PlaceOrder(UserId value) returns OrderResponse|error {
        do {
            CartItem[] userCart = [];
            float finalPrice = 0.0;
            foreach var item in self.carts {
                if item.userId == value.id {
                    userCart.push(item);
                }
                Product? product = self.products[item.sku];
                if product !is () {
                    finalPrice += product.price;
                }
            }

            if (userCart.length() == 0) {
                return error("Cart is empty");
            }

            string orderId = string `ORDER-${uuid:createType1AsString()}`;
            CartItem[] cartitems = self.carts.clone().toArray();
            self.carts.removeAll();

            foreach var item in cartitems {
                if item.userId != value.id {
                    self.carts.add(item);
                }
            }

            Order customerorder = {
                orderId: orderId,
                userId: value.id,
                items: userCart,
                total_price: finalPrice
            };

            self.orders.add(customerorder);
            return {success: true, orderId: orderId, message: "Order placed successfully"};
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns UsersCreatedResponse|error {
        do {
            _ = check clientStream.forEach(function (User t) {
                self.users.add(t);
            });
            
            string[] userids = [];
            foreach var item in self.users {
                userids.push(item.id);
            }
            
            UsersCreatedResponse response = {count: self.users.length(), userIds: []};
            return response;
        } on fail var e {
            return error(string `An Error occured: ${e.message()}`);
        }
    }
}

