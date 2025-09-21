# DSA-Assignment1-2025

This repository contains the solutions for Assignment 1 of the DSA course (2025). 
It includes a RESTful API implementation for Q1 and a gRPC service for Q2.

## Directory Structure

```plaintext
DSA-Assignment1-2025/
│
├── Q1_RESTful_API/                  # Question 1: RESTful API
│
├── Q2_gRPC_CarRental/               # Question 2: gRPC Car Rental System
│   ├── carrental.proto              # gRPC service definition
│   │
│   ├── car_rental_server/           # Server module
│   │   ├── Ballerina.toml
│   │   ├── server.bal               # Server implementation
│   │   └── carrental_pb.bal         # Generated gRPC stub for server
│   │
│   ├── car_rental_client/           # Client module
│   │   ├── Ballerina.toml
│   │   ├── client.bal               # Client implementation
│   │   └── carrental_pb.bal         # Generated gRPC stub for client
│   │
│
├── docs/                            # Documentation folder
│   ├── requirements.md
│   ├── runbook.md
│   ├── team.md
│   └── test-plan.md
│
├── .gitignore                       # Ignore target/, .idea/, etc.
└── README.md                        # Main documentation for the repo



 

Group members:
 
|      Names       | Student Number|
| ----------------:|--------------:|
| Hermaine Kharugas| 224001833     |
| Rafael Timotheus | 222059710     |
| Nestor Shikulo   | 222059702     |
| El-Salvador Pashita| 223057606   |
| Uushona Selma    | 222081368     |
|                  |               |
