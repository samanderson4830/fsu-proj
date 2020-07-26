const express = require('express');
const mysql = require ('mysql');

// //enviorment variables from fsurun.sh 
// const port  = process.env.BSA_PORT;
// const vhost = process.env.BSA_HOST;
// const vpwd  = process.env.BSA_PWD;
// const vuser = process.env.BSA_USER;
// const vdb = process.env.BSA_DB;

// create connetion
const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '123456',
    database : 'bsa_database'
});

// connect server to database
db.connect ((err) => {
    if(err)
    {
        throw err;
    } else
    {
        console.log('MySQL connected ...');
    }
});

const app = express();

// get DB info
app.get ('/getCustomers',(req, res) => {
    let sql = "call BSA_Database.GetCustomersByName('Tesla')";
    
    db.query (sql, (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            console.log(result);
           res.json(result);
        }
    });
});

app.get ('/makeCustomer',(req, res) => {
    let sql = "call BSA_Database.AddCompany('Test@test.com', 'Test123', 'Test')";

    db.query (sql, (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            console.log(result);
           res.json(result[0][0].Company_Name);
        }
    });
});

//testing for customers table, survey results table

//testing procedure to get customers by ID using URL parameters
app.get ('/getCustomersByID/:id',(req, res) => {
    var customerID = req.params.id
    let sql = `call BSA_Database.GetCustomersByID('${customerID}')`;   
    db.query (sql, (err, result) => {
        if (err) throw err;
        else {
            console.log("Data found .....");
            console.log(result);
           res.json(result);
        }
    });
});

//testing procedure to get all customers
app.get ('/getCustomersAll',(req, res) => {
    let sql = "call BSA_Database.GetCustomersAll()";   
    db.query (sql, (err, result) => {
        if (err) throw err;
        else {
            console.log("Data found .....");
            console.log(result);
           res.json(result);
        }
    });
});

//testing procedure to get customers by name using URL parameters
app.get ('/getCustomersByName/:name',(req, res) => {
    var customerName = req.params.name
    let sql = `call BSA_Database.GetCustomersByName('${customerName}')`;   
    db.query (sql, (err, result) => {
        if (err) throw err;
        else {
            console.log("Data found .....");
            console.log(result);
           res.json(result);
        }
    });
});

//testing procedure to get customers by name using URL parameters
app.get ('/getCustomersByEmail/:email',(req, res) => {
    var customerEmail = req.params.email
    let sql = `call BSA_Database.GetCustomersByEmail('${customerEmail}')`;   
    db.query (sql, (err, result) => {
        if (err) throw err;
        else {
            console.log("Data found .....");
            console.log(result);
           res.json(result);
        }
    });
});

//Testing Procedure to get Valid Login
app.get ('/validLogin/:email/:password',(req, res) => {
    var customerEmail = req.params.email
    var customerPass = req.params.password
    let sql = `CALL Login('${customerEmail}','${customerPass}')`;   
    db.query (sql, (err, result) => {
        if (err) throw err;
        else {
            console.log("Data found .....");
            console.log(result);
           res.send(result);
        }
    });
});




app.listen (3000, () => {
    console.log('Server started on port ' + 3000);
});