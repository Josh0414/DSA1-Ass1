import ballerina/grpc;
import ballerina/protobuf;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F120873686F7070696E6722070A05456D707479227F0A0750726F6475637412100A03736B751801200128095203736B7512120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128015205707269636512160A06737461747573180520012809520673746174757322210A0B50726F64756374436F646512120A04636F64651801200128095204636F646522440A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512180A07697341646D696E1803200128085207697341646D696E22460A14557365727343726561746564526573706F6E736512140A05636F756E741801200128055205636F756E7412180A0775736572496473180220032809520775736572496473223C0A0B50726F647563744C697374122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F647563747322340A08436172744974656D12160A06757365724964180120012809520675736572496412100A03736B751802200128095203736B7522420A0C43617274526573706F6E736512180A077375636365737318012001280852077375636365737312180A076D65737361676518022001280952076D65737361676522180A06557365724964120E0A02696418012001280952026964225D0A0D4F72646572526573706F6E736512180A077375636365737318012001280852077375636365737312180A076F72646572496418022001280952076F72646572496412180A076D65737361676518032001280952076D65737361676532FE030A0F53686F7070696E675365727669636512380A0A41646450726F6475637412112E73686F7070696E672E50726F647563741A152E73686F7070696E672E50726F64756374436F6465220012370A0D55706461746550726F6475637412112E73686F7070696E672E50726F647563741A112E73686F7070696E672E50726F647563742200123F0A0D52656D6F766550726F6475637412152E73686F7070696E672E50726F64756374436F64651A152E73686F7070696E672E50726F647563744C697374220012410A154C697374417661696C61626C6550726F6475637473120F2E73686F7070696E672E456D7074791A152E73686F7070696E672E50726F647563744C6973742200123B0A0D53656172636850726F6475637412152E73686F7070696E672E50726F64756374436F64651A112E73686F7070696E672E50726F64756374220012390A09416464546F4361727412122E73686F7070696E672E436172744974656D1A162E73686F7070696E672E43617274526573706F6E7365220012390A0A506C6163654F7264657212102E73686F7070696E672E5573657249641A172E73686F7070696E672E4F72646572526573706F6E7365220012410A0B4372656174655573657273120E2E73686F7070696E672E557365721A1E2E73686F7070696E672E557365727343726561746564526573706F6E736522002801620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function AddProduct(Product|ContextProduct req) returns ProductCode|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductCode>result;
    }

    isolated remote function AddProductContext(Product|ContextProduct req) returns ContextProductCode|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductCode>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(Product|ContextProduct req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function UpdateProductContext(Product|ContextProduct req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function RemoveProduct(ProductCode|ContextProductCode req) returns ProductList|grpc:Error {
        map<string|string[]> headers = {};
        ProductCode message;
        if req is ContextProductCode {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function RemoveProductContext(ProductCode|ContextProductCode req) returns ContextProductList|grpc:Error {
        map<string|string[]> headers = {};
        ProductCode message;
        if req is ContextProductCode {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function ListAvailableProducts(Empty|ContextEmpty req) returns ProductList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function ListAvailableProductsContext(Empty|ContextEmpty req) returns ContextProductList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function SearchProduct(ProductCode|ContextProductCode req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        ProductCode message;
        if req is ContextProductCode {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function SearchProductContext(ProductCode|ContextProductCode req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        ProductCode message;
        if req is ContextProductCode {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function AddToCart(CartItem|ContextCartItem req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartItem message;
        if req is ContextCartItem {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function AddToCartContext(CartItem|ContextCartItem req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartItem message;
        if req is ContextCartItem {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(UserId|ContextUserId req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function PlaceOrderContext(UserId|ContextUserId req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shopping.ShoppingService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUsersCreatedResponse() returns UsersCreatedResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UsersCreatedResponse>payload;
        }
    }

    isolated remote function receiveContextUsersCreatedResponse() returns ContextUsersCreatedResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UsersCreatedResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingServiceProductCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProduct(Product response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProduct(ContextProduct response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceOrderResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderResponse(OrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderResponse(ContextOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceProductListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductList(ProductList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductList(ContextProductList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceCartResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCartResponse(CartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCartResponse(ContextCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceUsersCreatedResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUsersCreatedResponse(UsersCreatedResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUsersCreatedResponse(ContextUsersCreatedResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceProductCodeCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductCode(ProductCode response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductCode(ContextProductCode response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextProductList record {|
    ProductList content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextProductCode record {|
    ProductCode content;
    map<string|string[]> headers;
|};

public type ContextUserId record {|
    UserId content;
    map<string|string[]> headers;
|};

public type ContextUsersCreatedResponse record {|
    UsersCreatedResponse content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextCartItem record {|
    CartItem content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductList record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type User record {|
    string id = "";
    string name = "";
    boolean isAdmin = false;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductCode record {|
    string code = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UserId record {|
    string id = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UsersCreatedResponse record {|
    int count = 0;
    string[] userIds = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Product record {|
    readonly string sku = "";
    string name = "";
    string description = "";
    float price = 0.0;
    string status = "";
|};
type ProductResponse record {
    string product_code;
};


@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartItem record {|
    string userId = "";
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type OrderResponse record {|
    boolean success = false;
    string orderId = "";
    string message = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartResponse record {|
    boolean success = false;
    string message = "";
|};

