# Ballerina CRUD User Management API

A RESTful CRUD API built using [Ballerina](https://ballerina.io/) and MySQL for managing users.  
It supports basic Create, Read, Update, Delete operations, along with search and retrieval by ID.

---

## Features

- Get all users
- Get a single user by ID
- Search users by name
- Create a new user
- Update an existing user
- Delete a user

---

## Prerequisites

- [Ballerina](https://ballerina.io/downloads/) 2201.8.0 or later
- MySQL Server installed and running
- MySQL Workbench (optional, for DB UI)
- VS Code with Ballerina plugin

---

## Setup Instructions

### 1. Clone the project

```bash
git clone https://github.com/nimashag/ballerina-user-crud.git
cd ballerina-user-crud
```
---

### 2. Create Config.toml

- Create a Config.toml in the root with your DB credentials:
```toml
[databaseConfig]
user = "root"
password = "your_password"
host = "localhost"
port = 3306
database = "user_crud_db"
```
---

### 3. Run the Service
```bash
bal run
```
---

## API Endpoints


| Method  | Endpoint | Description             | 
| ------ | ---------- | ----------------------- | 
| GET  | ```/users ```     | Get all users | 
| GET  | ```/users/{id} ```      | Get one user by ID    | 
| GET | ```/users/search?name=Alice ```     | Search users by name    | 
| POST  | ```/users ```     | Create new user | 
| PATCH  | ```/users/{id} ```     | Update existing user     | 
| DELETE| ```/users/{id} ```    | Delete user by ID    | 

---
## Sample POST Body
  
  ```json
  {
  "name": "John Doe",
  "email": "john@example.com",
  "address": "123 Main St"
}
  ```
---

## Testing

- You can use Postman or curl to test the endpoints.
  
  ```bash
  curl http://localhost:9090/users

  ```

