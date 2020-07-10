const mysql = require('mysql');


// create connetion
const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'Pass12345',
    database : 'BSA_Database'
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

module.exports = db;
