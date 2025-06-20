// // Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
// //
// // This software is the property of WSO2 LLC. and its suppliers, if any.
// // Dissemination of any information or reproduction of any material contained
// // herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// // You may not alter or remove any copyright or other notice from copies of this content.


import ballerina/sql;

// Define the function to fetch users from the database.
public isolated function getUsers() returns User[]|sql:Error {
    // Execute the query and return a stream of user records.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersQuery());
    
    // Check if the result is a stream of user records.
    if resultStream is stream<User> {
        return from User user in resultStream
            select user;
    }
    
    // If there is an error, return an error message.
    return error("Error fetching books");
}

// Insert a new user into the database using the provided payload.
public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    // Execute the insert query and return the result.
    return dbClient->execute(insertUserQuery(payload));
}

// Delete a user by their unique ID.
public isolated function deleteUser(int userId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(userId));
}

// Update user information using the user ID and updated data.
public isolated function updateUser(int userId, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateUserQuery(userId, payload));
}

// Search for users whose names match the given input.
public isolated function searchUserByName(string name) returns User[]|sql:Error {
    // Execute the search query and get the result as a stream.
    stream<User, sql:Error?> resultStream = dbClient->query(searchUserByNameQuery(name));

    // If the result is a valid stream, return the list of matched users.
    if resultStream is stream<User> {
        return from User user in resultStream
            select user;
    }

    // Return an error if the query fails.
    return error("Error searching users by name");
}

// Get a single user by their unique ID.
public isolated function getUserById(int id) returns User|sql:Error {
    // Execute the query to fetch the user by ID.
    stream<User, sql:Error?> resultStream = dbClient->query(getUserByIdQuery(id));

    // If a valid stream is returned, collect users from the stream.
    if resultStream is stream<User> {
        User[] users = from User user in resultStream
                       select user;

        // If a user is found, return the first result.
        if users.length() > 0 {
            return users[0]; // Return the first (and only) user
        } else {
            return error("User not found");
        }
    }

    // Return an error if the query execution fails.
    return error("Error fetching user by ID");
}

