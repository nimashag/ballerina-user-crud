// // Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
// //
// // This software is the property of WSO2 LLC. and its suppliers, if any.
// // Dissemination of any information or reproduction of any material contained
// // herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// // You may not alter or remove any copyright or other notice from copies of this content.


import ballerina/sql;

isolated function getUsersQuery() returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user;
`;

isolated function insertUserQuery(UserCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO user
        (
            name,
            email,
            address
        )
    VALUES
        (
            ${payload.name},
            ${payload.email},
            ${payload.address}
        
        )
`;

isolated function deleteUserQuery(int userId) returns sql:ParameterizedQuery => `
    DELETE FROM user WHERE id = ${userId}
`;

isolated function updateUserQuery(int userId, UserUpdate payload) returns sql:ParameterizedQuery =>`
    UPDATE user
        SET 
            name = COALESCE(${payload.name}, name),
            email = COALESCE(${payload.email}, email),
            address = COALESCE(${payload.address}, address)
        WHERE id = ${userId}
`;

isolated function searchUserByNameQuery(string name) returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user
    WHERE
        name LIKE ${"%"+name+"%"}
`;

isolated function getUserByIdQuery(int id) returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user
    WHERE
        id = ${id}
`;
