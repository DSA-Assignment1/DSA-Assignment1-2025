import ballerina/io;

public function main() returns error? {
    // Connect to the server
    RentalClient c = check new("http://localhost:9090");

    // 1️⃣ Add cars
    // ...existing code...
    CarReply r1 = check c->AddCar({
        plate:"N123", 
        make:"Toyota", 
        model:"Corolla", 
        year:2020, 
        price:500,      // <-- FIXED FIELD NAME
        mileage:10000, 
        status:"AVAILABLE"
    });
// ...repeat for r2...
    CarReply r2 = check c->AddCar({
        plate:"N456", 
        make:"Mazda", 
        model:"CX-5", 
        year:2021, 
        price:600,      // <-- FIXED FIELD NAME
        mileage:8000, 
        status:"AVAILABLE"
    });
// ...existing code...

    // 2️⃣ Search car
    CarReply s = check c->SearchCar({plate:"N123"});
    io:println("Search result: Plate: ", s.car.plate, ", Make: ", s.car.make);

    // 3️⃣ List available cars
    stream<Car, error?> carStream = check c->ListAvailableCars({query:""});
    error? e = carStream.forEach(function(Car car) {
        io:println("Available: Plate: ", car.plate, ", Make: ", car.make, ", Model: ", car.model);
    });
    if e is error {
        io:println("Error reading available cars: ", e.message());
    }

    // 4️⃣ Add to cart
   CartReply cart = check c->AddToCart({
    userId:"U1", 
    plate:"N123", 
    'start:"2025-09-20T00:00:00Z", 
    end:"2025-09-25T00:00:00Z"
});

    io:println("Add to cart: ", cart.message);

    // 5️⃣ Place reservation
    ReservationReply res = check c->PlaceReservation({id:"U1"});
    io:println("Reservation confirmation:");
    foreach var r in res.reservations {
        io:println("Car: ", r.car.make, " ", r.car.model, 
                   ", Start: ", r.'start, 
                   ", End: ", r.end, 
                   ", Price: ", r.price);
    }
}

