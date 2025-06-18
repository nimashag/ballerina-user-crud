// // Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
// //
// // This software is the property of WSO2 LLC. and its suppliers, if any.
// // Dissemination of any information or reproduction of any material contained
// // herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// // You may not alter or remove any copyright or other notice from copies of this content.
// import ballerina/sql;

// # Build the database update query with dynamic attributes.
// #
// # + mainQuery - Main query without the sub query
// # + filters - Array of sub queries to be added to the main query
// # + return - Dynamically build sql:ParameterizedQuery
// isolated function buildSqlUpdateQuery(sql:ParameterizedQuery mainQuery, sql:ParameterizedQuery[] filters)
//     returns sql:ParameterizedQuery {

//     boolean isFirstUpdate = true;
//     sql:ParameterizedQuery updatedQuery = ``;

//     foreach sql:ParameterizedQuery filter in filters {
//         if isFirstUpdate {
//             updatedQuery = sql:queryConcat(mainQuery, filter);
//             isFirstUpdate = false;
//             continue;
//         }

//         updatedQuery = sql:queryConcat(updatedQuery, ` , `, filter);
//     }

//     return updatedQuery;
// }

// # Build the database select query with dynamic filter attributes.
// #
// # + mainQuery - Main query without the new sub query
// # + filters - Array of sub queries to be added to the main query
// # + return - Dynamically build sql:ParameterizedQuery
// isolated function buildSqlSelectQuery(sql:ParameterizedQuery mainQuery, sql:ParameterizedQuery[] filters)
//     returns sql:ParameterizedQuery {

//     boolean isFirstSearch = true;
//     sql:ParameterizedQuery updatedQuery = mainQuery;

//     foreach sql:ParameterizedQuery filter in filters {
//         if isFirstSearch {
//             updatedQuery = sql:queryConcat(mainQuery, ` WHERE `, filter);
//             isFirstSearch = false;
//             continue;
//         }

//         updatedQuery = sql:queryConcat(updatedQuery, ` AND `, filter);
//     }

//     return updatedQuery;
// }

import ballerina/sql;

# Build SQL UPDATE query with dynamic columns.
#
# + mainQuery - Main query to start with
# + filters - Key-value update clauses
# + return - Combined sql:ParameterizedQuery
isolated function buildSqlUpdateQuery(sql:ParameterizedQuery mainQuery, sql:ParameterizedQuery[] filters)
    returns sql:ParameterizedQuery {

    boolean isFirstUpdate = true;
    sql:ParameterizedQuery updatedQuery = ``;

    foreach sql:ParameterizedQuery filter in filters {
        if isFirstUpdate {
            updatedQuery = sql:queryConcat(mainQuery, filter);
            isFirstUpdate = false;
        } else {
            updatedQuery = sql:queryConcat(updatedQuery, ` , `, filter);
        }
    }

    return updatedQuery;
}

# Build SQL SELECT query with dynamic WHERE filters.
#
# + mainQuery - Base SELECT query
# + filters - List of filter conditions
# + return - Final sql:ParameterizedQuery
isolated function buildSqlSelectQuery(sql:ParameterizedQuery mainQuery, sql:ParameterizedQuery[] filters)
    returns sql:ParameterizedQuery {

    boolean isFirstFilter = true;
    sql:ParameterizedQuery updatedQuery = mainQuery;

    foreach sql:ParameterizedQuery filter in filters {
        if isFirstFilter {
            updatedQuery = sql:queryConcat(mainQuery, ` WHERE `, filter);
            isFirstFilter = false;
        } else {
            updatedQuery = sql:queryConcat(updatedQuery, ` AND `, filter);
        }
    }

    return updatedQuery;
}
