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

    // Resource function to insert a new user into the database.
    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        // Call the insert function with the user payload.
        sql:ExecutionResult|sql:Error response = database:insertUser(user);

        // Handle insertion error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        // Return HTTP 201 Created on success.
        return http:CREATED;
    }

    // Resource function to delete a user by ID.
    resource function delete users/[int id]() returns http:NoContent|http:InternalServerError {
        // Call the delete function with the user ID.
        sql:ExecutionResult|sql:Error response = database:deleteUser(id);

        // Handle deletion error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while deleting user"
            };
        }

        // Return HTTP 204 No Content on success.
        return http:NO_CONTENT;
    }

    // Resource function to update a user by ID.
    resource function patch users/[int id](database:UserUpdate user) returns http:NoContent|http:InternalServerError {
        // Call the update function with ID and updated user data.
        sql:ExecutionResult|sql:Error response = database:updateUser(id, user);

        // Handle update error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while updating user"
            };
        }

        // Return HTTP 204 No Content on success.
        return http:NO_CONTENT;
    }

    // Resource function to search users by name using a query parameter.
    resource function get users/search(@http:Query string name) returns database:User[]|http:InternalServerError {
        // Call the search function with the name.
        database:User[]|error response = database:searchUserByName(name);

        // Handle search error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while searching user by name"
            };
        }

        // Return matched users.
        return response;
    }

    // Resource function to fetch a single user by ID.
    resource function get users/[int id]() returns database:User|http:NotFound|http:InternalServerError {
        // Call the getUserById function with the given ID.
        database:User|error response = database:getUserById(id);

        // Handle error: differentiate between "not found" and other errors.
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

        // Return the user on success.
        return response;
    }


}