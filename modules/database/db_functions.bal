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

public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

public isolated function deleteUser(int userId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(userId));
}

public isolated function updateUser(int userId, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateUserQuery(userId, payload));
}

public isolated function searchUserByName(string name) returns User[]|sql:Error {
    stream<User, sql:Error?> resultStream = dbClient->query(searchUserByNameQuery(name));

    if resultStream is stream<User> {
        return from User user in resultStream
            select user;
    }

    return error("Error searching users by name");
}
