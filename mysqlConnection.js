
console.log("mysql begin");

const mySql = require("mysql2")

const conn = mySql.createConnection(
    {
        host:"localhost",
        user:"root",
        password:"Chocobo521969420*",
        database:"HoldMania"
    }
)


module.exports = conn

