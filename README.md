# Rocket_Elevators_Foundations




## Deployed Site:
http://jjyb8989rocketelevators.com/

## Login Info:
### Username:
Timothy.wever@codeboxx.biz
### Password:
password

*Once logged in Select the Intervention tab at the top and refresh page if neccesary.







# Rest API

### To access
-You will need to have postman downloaded and installed

## Interaction points

### (1) 
GET: Returns all fields of all intervention Request records that do not have a start
date and are in "Pending" status.
### Variable:
GET "https://consolidation-rest-api.herokuapp.com/api/intervention/pendingelevators"
### Body:

{
    "status": "Pending"
}



### (2)
PUT: Change the status of the intervention request to "InProgress" and add a start
date and time (Timestamp).
### Variable:
PUT "https://consolidation-rest-api.herokuapp.com/api/intervention/(x) 
replace "x" with a number 1-8
### Body:

{
    "status": "InProgress"
}

(use GET with same variable to view change made)



### (3)
PUT: Change the status of the request for action to "Completed" and add an end
date and time (Timestamp).
### Variable
PUT "https://consolidation-rest-api.herokuapp.com/api/intervention/(x) 
replace "x" with a number 1-8
### Body:

{
    "status": "Completed"
}

(use GET with same variable to view change made)
