// Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.


import ballerina_crud_application.database;

import ballerina/http;
import ballerina/sql;

service / on new http:Listener(9090) {

    // Resource function to get all User.
    resource function get users() returns database:User[]|http:InternalServerError {
        // Call the getusers function to fetch data from the database.
        database:User[]|error response = database:getUsers();

        // If there's an error while fetching, return an internal server error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving users"
            };
        }

        // Return the response containing the list of Users.
        return response;
    }

    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        return http:CREATED;
    }

    resource function delete users/[int id]() returns http:NoContent|http:InternalServerError {
     sql:ExecutionResult|sql:Error response = database:deleteUser(id);

     if response is error {
         return <http:InternalServerError>{
             body: "Error while deleting user"
         };
     }

     return http:NO_CONTENT;
    }

    resource function patch users/[int id](database:UserUpdate user) returns http:NoContent|http:InternalServerError {
    sql:ExecutionResult|sql:Error response = database:updateUser(id, user);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while updating user"
        };
    }

    return http:NO_CONTENT;
    }

    resource function get users/search(@http:Query string name) returns database:User[]|http:InternalServerError {
    database:User[]|error response = database:searchUserByName(name);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while searching user by name"
        };
    }

    return response;
    }

    resource function get users/[int id]() returns database:User|http:NotFound|http:InternalServerError {
    database:User|error response = database:getUserById(id);

    if response is error {
        if response.message() == "User not found" {
            return <http:NotFound>{
                body: "User not found"
            };
        }
        return <http:InternalServerError>{
            body: "Error retrieving user"
        };
    }

    return response;
}


}