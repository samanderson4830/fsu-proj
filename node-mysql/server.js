const express = require('express');
const mysql = require ('mysql');

//enviorment variables from fsurun.sh 
const port  = process.env.BSA_PORT;
const vhost = process.env.BSA_HOST;
const vpwd  = process.env.BSA_PWD;
const vuser = process.env.BSA_USER;
const vdb = process.env.BSA_DB;

// create connetion
const db = mysql.createConnection({
    host     : vhost,
    user     : vuser,
    password : vpwd,
    database : vdb
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
           res.json(result[0][0].Company_Name);
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

app.listen (port, () => {
    console.log('Server started on port ' + port);
});