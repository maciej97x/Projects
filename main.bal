import ballerina/http;

// Definicja klasy User
public type User record {
    string id;
    string email;
    string password;
};

// Lista użytkowników przechowywana w pamięci
User[] users = [
    {"1", "user1@example.com", "password1"},
    {"2", "user2@example.com", "password2"},
    {"3", "user3@example.com", "password3"}
];

// Metoda do pobierania wszystkich użytkowników
@http:ResourceConfig {
    methods: ["GET"],
    path: "/users"
}
resource function getUsers(http:Caller caller, http:Request req) {
    caller->respond(users);
}

// Metoda do pobierania pojedynczego użytkownika na podstawie ID
@http:ResourceConfig {
    methods: ["GET"],
    path: "/users/{id}"
}
resource function getUserById(http:Caller caller, http:Request req, string id) {
    User? user = getUserByIdInternal(id);
    if (user == null) {
        caller->respondWithError(http:NOT_FOUND, "User not found");
    } else {
        caller->respond(user);
    }
}

function getUserByIdInternal(string id) returns User? {
    foreach var user in users {
        if (user.id == id) {
            return user;
        }
    }
    return ();
}

// Metoda do dodawania nowego użytkownika
@http:ResourceConfig {
    methods: ["POST"],
    path: "/users"
}
resource function addUser(http:Caller caller, http:Request req) {
    User newUser = req.getJsonPayload().getJson().toRecord<User>();
    users.push(newUser);
    caller->respond(201, "User added successfully");
}

// Metoda do resetowania hasła użytkownika na podstawie adresu e-mail
@http:ResourceConfig {
    methods: ["POST"],
    path: "/users/resetPassword"
}
resource function resetPassword(http:Caller caller, http:Request req) {
    string email = req.getJsonPayload().getJson().getString("email");
    boolean userExists = checkUserExists(email);
    if (userExists) {
        caller->respond(http:ACCEPTED, "Reset password request accepted");
    } else {
        caller->respondWithError(http:BAD_REQUEST, "User not found");
    }
}

function checkUserExists(string email) returns boolean {
    foreach var user in users {
        if (user.email == email) {
            return true;
        }
    }
    return false;
}

// Metoda do logowania użytkownika
@http:ResourceConfig {
    methods: ["POST"],
    path: "/auth/login"
}
resource function login(http:Caller caller, http:Request req) {
    json payload = req.getJsonPayload().getJson();
    string email = payload.getString("email");
    string password = payload.getString("password");
    
    User? user = getUserByEmail(email);
    if (user != null && user.password == password) {
        caller->respond(http:OK, "Login successful");
    } else {
        caller->respondWithError(http:UNAUTHORIZED, "Invalid credentials");
    }
}

function getUserByEmail(string email) returns User? {
    foreach var user in users {
        if (user.email == email) {
            return user;
        }
    }
    return ();
}

// Uruchomienie serwera HTTP na porcie 9090
public function main() {
    http:ListenerConfiguration listenerConfig = {
        port: 9090
    };
    http:Listener httpListener = new(listenerConfig, checkCaller);
    httpListener.start();
    io:println("Server started on port 9090");
}

function checkCaller(http:Caller, http:Request) returns error? {
    return checkAllowedMethods(http, http:METHOD_GET, http:METHOD_POST);
}
