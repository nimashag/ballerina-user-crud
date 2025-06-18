// // Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
// //
// // This software is the property of WSO2 LLC. and its suppliers, if any.
// // Dissemination of any information or reproduction of any material contained
// // herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// // You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/sql;

# User record type.
public type User record {|
    # User ID
    @sql:Column {name: "id"}
    readonly int id;

    # User name
    @sql:Column {name: "name"}
    string name;

    # User email
    @sql:Column {name: "email"}
    string email;

    # User address
    @sql:Column {name: "address"}
    string address;
    
|};        

# User create record type.
public type UserCreate record {|
    # User name
    string name;
    # User email
    string email;
    # User address
    string address;
    
|};

# User update record type.
public type UserUpdate record {|
    # User name
    string? name = ();
    # User email
    string? email = ();
    # User address
    string? address = ();
|};