import ballerina/http;

// ========================
// Data Models
// ========================
type Status "ACTIVE"|"UNDER_REPAIR"|"DISPOSED";

type Component record {|
    string id;
    string name;
    string description;
|};

type Schedule record {|
    string id;
    string scheduleType; // fixed (was `type`)
    string nextDueDate; // YYYY-MM-DD
|};

type Task record {|
    string id;
    string description;
    string status; // e.g., "PENDING", "COMPLETED"
|};

type WorkOrder record {|
    string id;
    string description;
    string status; // "OPEN", "CLOSED"
    map<Task> tasks;
|};

type Asset record {|
    string assetTag;
    string name;
    string faculty;
    string department;
    Status status;
    string acquiredDate; // YYYY-MM-DD
    map<Component> components;
    map<Schedule> schedules;
    map<WorkOrder> workOrders;
|};

// ========================
// In-Memory DB
// ========================
map<Asset> assetsDB = {};

// ========================
// DB Functions
// ========================
function addAsset(Asset asset) returns error? {
    if assetsDB.hasKey(asset.assetTag) {
        return error("Asset already exists");
    }
    assetsDB[asset.assetTag] = asset;
}

function updateAsset(string tag, Asset newAsset) returns error? {
    if !assetsDB.hasKey(tag) {
        return error("Asset not found");
    }
    newAsset.assetTag = tag;
    assetsDB[tag] = newAsset;
}

function deleteAsset(string tag) returns error? {
    if !assetsDB.hasKey(tag) {
        return error("Asset not found");
    }
    _ = assetsDB.remove(tag);
}

function getAsset(string tag) returns Asset|error {
    Asset? asset = assetsDB[tag];
    if asset is Asset {
        return asset;
    }
    return error("Asset not found");
}

// Corrected functions to avoid '[string, Asset]' field access errors
function getAllAssets() returns Asset[] {
    Asset[] assets = [];
    foreach var [_, asset] in assetsDB.entries() {
        assets.push(asset);
    }
    return assets;
}

function getAssetsByFaculty(string faculty) returns Asset[] {
    Asset[] result = [];
    foreach var [_, asset] in assetsDB.entries() {
        if asset.faculty == faculty {
            result.push(asset);
        }
    }
    return result;
}

function getOverdueAssets() returns Asset[] {
    string currentDate = "2025-09-19";
    Asset[] overdue = [];
    foreach var [_, asset] in assetsDB.entries() {
        boolean hasOverdue = false;
        foreach var [_, sched] in asset.schedules.entries() {
            if sched.nextDueDate < currentDate {
                hasOverdue = true;
                break;
            }
        }
        if hasOverdue {
            overdue.push(asset);
        }
    }
    return overdue;
}

// ========================
// Nested Management
// ========================
function addComponent(string tag, string compId, Component comp) returns error? {
    Asset asset = check getAsset(tag);
    asset.components[compId] = comp;
    assetsDB[tag] = asset;
}

function removeComponent(string tag, string compId) returns error? {
    Asset asset = check getAsset(tag);
    _ = asset.components.remove(compId);
    assetsDB[tag] = asset;
}

function addSchedule(string tag, string schedId, Schedule sched) returns error? {
    Asset asset = check getAsset(tag);
    asset.schedules[schedId] = sched;
    assetsDB[tag] = asset;
}

function removeSchedule(string tag, string schedId) returns error? {
    Asset asset = check getAsset(tag);
    _ = asset.schedules.remove(schedId);
    assetsDB[tag] = asset;
}

function addWorkOrder(string tag, string woId, WorkOrder wo) returns error? {
    Asset asset = check getAsset(tag);
    wo.tasks = {};
    asset.workOrders[woId] = wo;
    assetsDB[tag] = asset;
}

function addTask(string tag, string woId, string taskId, Task task) returns error? {
    Asset asset = check getAsset(tag);
    WorkOrder? wo = asset.workOrders[woId];
    if wo is () {
        return error("WorkOrder not found");
    }
    wo.tasks[taskId] = task;
    asset.workOrders[woId] = wo;
    assetsDB[tag] = asset;
}

// ========================
// REST Service
// ========================
service /assets on new http:Listener(8080) {

    resource function post .(@http:Payload Asset payload) returns json|error {
        error? err = addAsset(payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Asset created", "assetTag": payload.assetTag};
    }

    resource function get .() returns Asset[] {
        return getAllAssets();
    }

    resource function get [string tag]() returns Asset|json {
        Asset|error asset = getAsset(tag);
        if asset is error {
            return {"error": "Asset not found"};
        }
        return asset;
    }

    resource function put [string tag](@http:Payload Asset payload) returns json|error {
        error? err = updateAsset(tag, payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Asset updated"};
    }

    resource function delete [string tag]() returns json {
        error? err = deleteAsset(tag);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Asset deleted"};
    }

    resource function get faculty/[string faculty]() returns Asset[] {
        return getAssetsByFaculty(faculty);
    }

    resource function get overdue() returns Asset[] {
        return getOverdueAssets();
    }

    resource function post [string tag]/components/[string compId](@http:Payload Component payload) returns json|error {
        error? err = addComponent(tag, compId, payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Component added"};
    }

    resource function delete [string tag]/components/[string compId]() returns json|error {
        error? err = removeComponent(tag, compId);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Component removed"};
    }

    resource function post [string tag]/schedules/[string schedId](@http:Payload Schedule payload) returns json|error {
        error? err = addSchedule(tag, schedId, payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Schedule added"};
    }

    resource function delete [string tag]/schedules/[string schedId]() returns json|error {
        error? err = removeSchedule(tag, schedId);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Schedule removed"};
    }

    resource function post [string tag]/workorders/[string woId](@http:Payload WorkOrder payload) returns json|error {
        error? err = addWorkOrder(tag, woId, payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "WorkOrder added"};
    }

    resource function post [string tag]/workorders/[string woId]/tasks/[string taskId](@http:Payload Task payload) returns json|error {
        error? err = addTask(tag, woId, taskId, payload);
        if err is error {
            return {"error": err.message()};
        }
        return {"message": "Task added"};
    }
}
