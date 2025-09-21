import ballerina/grpc;
import ballerina/protobuf;

public const string CARRENTAL_DESC = "0A0F63617272656E74616C2E70726F746F120963617272656E74616C22A1010A0343617212140A05706C6174651801200128095205706C61746512120A046D616B6518022001280952046D616B6512140A056D6F64656C18032001280952056D6F64656C12120A047965617218042001280552047965617212140A0570726963651805200128015205707269636512180A076D696C6561676518062001280152076D696C6561676512160A067374617475731807200128095206737461747573221D0A05436172496412140A05706C6174651801200128095205706C61746522460A084361725265706C7912180A076D65737361676518012001280952076D65737361676512200A0363617218022001280B320E2E63617272656E74616C2E4361725203636172222D0A074361724C69737412220A046361727318012003280B320E2E63617272656E74616C2E436172520463617273221E0A0646696C74657212140A05717565727918012001280952057175657279223E0A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C6522250A09557365725265706C7912180A076D65737361676518012001280952076D65737361676522640A0C416464546F4361727452657112160A06757365724964180120012809520675736572496412140A05706C6174651802200128095205706C61746512140A0573746172741803200128095205737461727412100A03656E641804200128095203656E6422250A09436172745265706C7912180A076D65737361676518012001280952076D6573736167652285010A0B5265736572766174696F6E12160A06757365724964180120012809520675736572496412200A0363617218022001280B320E2E63617272656E74616C2E436172520363617212140A0573746172741803200128095205737461727412100A03656E641804200128095203656E6412140A05707269636518052001280152057072696365224D0A0F5265736572766174696F6E4C697374123A0A0C7265736572766174696F6E7318012003280B32162E63617272656E74616C2E5265736572766174696F6E520C7265736572766174696F6E7322680A105265736572766174696F6E5265706C7912180A076D65737361676518012001280952076D657373616765123A0A0C7265736572766174696F6E7318022003280B32162E63617272656E74616C2E5265736572766174696F6E520C7265736572766174696F6E7322180A06557365724964120E0A0269641801200128095202696422070A05456D7074793284040A0652656E74616C122D0A06416464436172120E2E63617272656E74616C2E4361721A132E63617272656E74616C2E4361725265706C7912300A09557064617465436172120E2E63617272656E74616C2E4361721A132E63617272656E74616C2E4361725265706C7912310A0952656D6F766543617212102E63617272656E74616C2E43617249641A122E63617272656E74616C2E4361724C69737412400A104C6973745265736572766174696F6E7312102E63617272656E74616C2E456D7074791A1A2E63617272656E74616C2E5265736572766174696F6E4C69737412380A114C697374417661696C61626C654361727312112E63617272656E74616C2E46696C7465721A0E2E63617272656E74616C2E436172300112320A0953656172636843617212102E63617272656E74616C2E43617249641A132E63617272656E74616C2E4361725265706C79123A0A09416464546F4361727412172E63617272656E74616C2E416464546F436172745265711A142E63617272656E74616C2E436172745265706C7912420A10506C6163655265736572766174696F6E12112E63617272656E74616C2E5573657249641A1B2E63617272656E74616C2E5265736572766174696F6E5265706C7912360A0B4372656174655573657273120F2E63617272656E74616C2E557365721A142E63617272656E74616C2E557365725265706C792801620670726F746F33";

public isolated client class RentalClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, CARRENTAL_DESC);
    }

    isolated remote function AddCar(Car|ContextCar req) returns CarReply|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CarReply>result;
    }

    isolated remote function AddCarContext(Car|ContextCar req) returns ContextCarReply|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/AddCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CarReply>result, headers: respHeaders};
    }

    isolated remote function UpdateCar(Car|ContextCar req) returns CarReply|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/UpdateCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CarReply>result;
    }

    isolated remote function UpdateCarContext(Car|ContextCar req) returns ContextCarReply|grpc:Error {
        map<string|string[]> headers = {};
        Car message;
        if req is ContextCar {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/UpdateCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CarReply>result, headers: respHeaders};
    }

    isolated remote function RemoveCar(CarId|ContextCarId req) returns CarList|grpc:Error {
        map<string|string[]> headers = {};
        CarId message;
        if req is ContextCarId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/RemoveCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CarList>result;
    }

    isolated remote function RemoveCarContext(CarId|ContextCarId req) returns ContextCarList|grpc:Error {
        map<string|string[]> headers = {};
        CarId message;
        if req is ContextCarId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/RemoveCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CarList>result, headers: respHeaders};
    }

    isolated remote function ListReservations(Empty|ContextEmpty req) returns ReservationList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/ListReservations", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ReservationList>result;
    }

    isolated remote function ListReservationsContext(Empty|ContextEmpty req) returns ContextReservationList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/ListReservations", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ReservationList>result, headers: respHeaders};
    }

    isolated remote function SearchCar(CarId|ContextCarId req) returns CarReply|grpc:Error {
        map<string|string[]> headers = {};
        CarId message;
        if req is ContextCarId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CarReply>result;
    }

    isolated remote function SearchCarContext(CarId|ContextCarId req) returns ContextCarReply|grpc:Error {
        map<string|string[]> headers = {};
        CarId message;
        if req is ContextCarId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/SearchCar", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CarReply>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartReq|ContextAddToCartReq req) returns CartReply|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartReq message;
        if req is ContextAddToCartReq {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartReply>result;
    }

    isolated remote function AddToCartContext(AddToCartReq|ContextAddToCartReq req) returns ContextCartReply|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartReq message;
        if req is ContextAddToCartReq {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartReply>result, headers: respHeaders};
    }

    isolated remote function PlaceReservation(UserId|ContextUserId req) returns ReservationReply|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/PlaceReservation", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ReservationReply>result;
    }

    isolated remote function PlaceReservationContext(UserId|ContextUserId req) returns ContextReservationReply|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("carrental.Rental/PlaceReservation", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ReservationReply>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("carrental.Rental/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }

    isolated remote function ListAvailableCars(Filter|ContextFilter req) returns stream<Car, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        Filter message;
        if req is ContextFilter {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("carrental.Rental/ListAvailableCars", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        CarStream outputStream = new CarStream(result);
        return new stream<Car, grpc:Error?>(outputStream);
    }

    isolated remote function ListAvailableCarsContext(Filter|ContextFilter req) returns ContextCarStream|grpc:Error {
        map<string|string[]> headers = {};
        Filter message;
        if req is ContextFilter {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("carrental.Rental/ListAvailableCars", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        CarStream outputStream = new CarStream(result);
        return {content: new stream<Car, grpc:Error?>(outputStream), headers: respHeaders};
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

    isolated remote function receiveUserReply() returns UserReply|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserReply>payload;
        }
    }

    isolated remote function receiveContextUserReply() returns ContextUserReply|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserReply>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class CarStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Car value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if streamValue is () {
            return streamValue;
        } else if streamValue is grpc:Error {
            return streamValue;
        } else {
            record {|Car value;|} nextRecord = {value: <Car>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public isolated client class RentalCarReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCarReply(CarReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCarReply(ContextCarReply response) returns grpc:Error? {
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

public isolated client class RentalReservationReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendReservationReply(ReservationReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextReservationReply(ContextReservationReply response) returns grpc:Error? {
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

public isolated client class RentalReservationListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendReservationList(ReservationList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextReservationList(ContextReservationList response) returns grpc:Error? {
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

public isolated client class RentalUserReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUserReply(UserReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUserReply(ContextUserReply response) returns grpc:Error? {
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

public isolated client class RentalCartReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCartReply(CartReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCartReply(ContextCartReply response) returns grpc:Error? {
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

public isolated client class RentalCarListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCarList(CarList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCarList(ContextCarList response) returns grpc:Error? {
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

public isolated client class RentalCarCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCar(Car response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCar(ContextCar response) returns grpc:Error? {
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

public type ContextCarStream record {|
    stream<Car, error?> content;
    map<string|string[]> headers;
|};

public type ContextCarList record {|
    CarList content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextReservationList record {|
    ReservationList content;
    map<string|string[]> headers;
|};

public type ContextCartReply record {|
    CartReply content;
    map<string|string[]> headers;
|};

public type ContextReservationReply record {|
    ReservationReply content;
    map<string|string[]> headers;
|};

public type ContextUserReply record {|
    UserReply content;
    map<string|string[]> headers;
|};

public type ContextCarReply record {|
    CarReply content;
    map<string|string[]> headers;
|};

public type ContextCarId record {|
    CarId content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextCar record {|
    Car content;
    map<string|string[]> headers;
|};

public type ContextFilter record {|
    Filter content;
    map<string|string[]> headers;
|};

public type ContextUserId record {|
    UserId content;
    map<string|string[]> headers;
|};

public type ContextAddToCartReq record {|
    AddToCartReq content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type CarList record {|
    Car[] cars = [];
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type User record {|
    string id = "";
    string name = "";
    string role = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type ReservationList record {|
    Reservation[] reservations = [];
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type CartReply record {|
    string message = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type ReservationReply record {|
    string message = "";
    Reservation[] reservations = [];
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type UserReply record {|
    string message = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type CarReply record {|
    string message = "";
    Car car = {};
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type CarId record {|
    string plate = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type Reservation record {|
    string userId = "";
    Car car = {};
    string 'start = "";
    string end = "";
    float price = 0.0;
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type Car record {|
    string plate = "";
    string make = "";
    string model = "";
    int year = 0;
    float price = 0.0;
    float mileage = 0.0;
    string status = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type Filter record {|
    string query = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type UserId record {|
    string id = "";
|};

@protobuf:Descriptor {value: CARRENTAL_DESC}
public type AddToCartReq record {|
    string userId = "";
    string plate = "";
    string 'start = "";
    string end = "";
|};

