import ballerina/grpc;
import ballerina/time;

// in-memory storage
map<Car> cars = {};
map<User> users = {};
map<AddToCartReq[]> carts = {};
Reservation[] reservations = [];

listener grpc:Listener l = new (9090);

@grpc:Descriptor {value: CARRENTAL_DESC}
service "Rental" on l {

    // admin operations
    remote function AddCar(Car car) returns CarReply|error {
        cars[car.plate] = car;
        return {message: "Car added", car: car};
    }

    remote function UpdateCar(Car car) returns CarReply|error {
        if cars.hasKey(car.plate) {
            cars[car.plate] = car;
            return {message: "Car updated", car: car};
        }
        return {message: "Car not found", car: car};
    }

    remote function RemoveCar(CarId id) returns CarList|error {
        _ = cars.remove(id.plate);
        return {cars: cars.toArray()};
    }

    remote function ListReservations(Empty unused) returns ReservationList|error {
        return {reservations: reservations};
    }

    // customer operations
    remote function ListAvailableCars(Filter f) returns stream<Car,error?> {
        return from var c in cars.toArray()
            where c.status == "AVAILABLE" && (f.query == "" || c.make.indexOf(f.query) >= 0 || c.model.indexOf(f.query) >= 0)
            select c;
    }

    remote function SearchCar(CarId id) returns CarReply|error {
        if cars.hasKey(id.plate) {
            return <CarReply>{message: "Found", car: <Car>cars[id.plate]};
        }
        
        return {message: "Not found", car: {plate: "", make: "", model: "", year: 0, price: 0.0, mileage: 0, status: ""}};
    }

    remote function AddToCart(AddToCartReq req) returns CartReply|error {
        if !cars.hasKey(req.plate) {
            return {message: "Car not found"};
        }
        if carts.hasKey(req.userId) {
            AddToCartReq[] arr = carts[req.userId] ?: [];
            arr.push(req);
            carts[req.userId] = arr;
        } else {
            carts[req.userId] = [req];
        }
        return {message: "Added to cart"};
    }

    
    remote function PlaceReservation(UserId uid) returns ReservationReply|error {
    Reservation[] userRes = [];
    if !carts.hasKey(uid.id) {
        return {message: "Cart empty", reservations: []};
    }

    foreach var req in carts[uid.id] ?: [] {
        Car? carOpt = cars[req.plate];
        if carOpt is Car {
            time:Utc startTime = check time:utcFromString(req.'start);
            time:Utc end = check time:utcFromString(req.end);
            int days = <int>(time:utcDiffSeconds(end, startTime) / (60*60*24));
            Reservation r = {
                userId: req.userId,
                car: carOpt,
                'start: req.'start,
                end: req.end,
                price: days * carOpt.price
            };
            reservations.push(r);
            userRes.push(r);
        }
    }

    _ = carts.remove(uid.id);
    return {message: "Reservation placed", reservations: userRes};
}


    // user operations
    remote function CreateUsers(stream<User, error?> u) returns UserReply|error {
        error? e = u.forEach(function(User user) {
            users[user.id] = user;
        });
        return {message: "Users added"};
    }
}