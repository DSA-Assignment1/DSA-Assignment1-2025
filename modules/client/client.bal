import ballerina/http;
import ballerina/io;

// Record definitions (same as main.bal to avoid imports)
type Status "ACTIVE"|"UNDER_REPAIR"|"DISPOSED";

type Component record {
    string id;
    string name;
    string description;
};

type Schedule record {
    string id;
    string scheduleType; // ✅ renamed from `type` → `scheduleType`
    string nextDueDate;
};

type Task record {
    string id;
    string description;
    string status;
};

type WorkOrder record {
    string id;
    string description;
    string status;
    map<Task> tasks;
};

type Asset record {
    string assetTag;
    string name;
    string faculty;
    string department;
    Status status;
    string acquiredDate;
    map<Component> components;
    map<Schedule> schedules;
    map<WorkOrder> workOrders;
};

http:Client assetClient = check new ("http://localhost:8080");

public function main() returns error? {
    io:println("=== Demo: Adding and Updating Asset ===");
    Asset newAsset = {
        assetTag: "EQ-001",
        name: "3D Printer",
        faculty: "Computing & Informatics",
        department: "Software Engineering",
        status: "ACTIVE",
        acquiredDate: "2024-03-10",
        components: {},
        schedules: {},
        workOrders: {}
    };
    http:Response response = check assetClient->post("/assets", newAsset);
    json payload = check response.getJsonPayload();
    io:println(payload);

    // Update Asset
    Asset updatedAsset = {
        assetTag: "EQ-001",
        name: "Updated 3D Printer",
        faculty: "Computing & Informatics",
        department: "Software Engineering",
        status: "UNDER_REPAIR",
        acquiredDate: "2024-03-10",
        components: {},
        schedules: {},
        workOrders: {}
    };
    response = check assetClient->put("/assets/EQ-001", updatedAsset);
    payload = check response.getJsonPayload();
    io:println(payload);

    io:println("=== Demo: Viewing All Assets ===");
    response = check assetClient->get("/assets");
    json allAssets = check response.getJsonPayload();
    io:println(allAssets);

    io:println("=== Demo: Viewing by Faculty ===");
    response = check assetClient->get("/assets/faculty/Computing%20%26%20Informatics");
    json facultyAssets = check response.getJsonPayload();
    io:println(facultyAssets);

    io:println("=== Demo: Overdue Check ===");
    Schedule overdueSched = {id: "sched-001", scheduleType: "yearly", nextDueDate: "2025-09-01"}; // ✅ updated
    response = check assetClient->post("/assets/EQ-001/schedules/sched-001", overdueSched);
    io:println(check response.getJsonPayload());

    response = check assetClient->get("/assets/overdue");
    json overdue = check response.getJsonPayload();
    io:println(overdue);

    io:println("=== Demo: Managing Component ===");
    Component comp = {id: "comp-001", name: "Motor", description: "Replacement motor"};
    response = check assetClient->post("/assets/EQ-001/components/comp-001", comp);
    io:println(check response.getJsonPayload());

    response = check assetClient->get("/assets/EQ-001");
    io:println(check response.getJsonPayload());

    io:println("=== Demo: Managing Work Order and Task ===");
    WorkOrder wo = {id: "wo-001", description: "Fix printer jam", status: "OPEN", tasks: {}};
    response = check assetClient->post("/assets/EQ-001/workorders/wo-001", wo);
    io:println(check response.getJsonPayload());

    Task task = {id: "task-001", description: "Replace screen", status: "PENDING"};
    response = check assetClient->post("/assets/EQ-001/workorders/wo-001/tasks/task-001", task);
    io:println(check response.getJsonPayload());
}
