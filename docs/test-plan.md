# Test Plan

## Q1: RESTful API
### Functional Tests
- Create asset (POST /assets)
- Get asset (GET /assets/{id})
- Update asset (PUT /assets/{id})
- Delete asset (DELETE /assets/{id})

### Tools
- Postman / curl

## Q2: gRPC Car Rental
### Functional Tests
- `AddCar` RPC: adds a new car
- `GetCar` RPC: fetches a car by ID
- `ReserveCar` RPC: reserves a car for a user

### Tools
- Ballerina client
- grpcurl (optional)

## Non-Functional Tests
- Check concurrent requests
- Validate error handling for invalid input
