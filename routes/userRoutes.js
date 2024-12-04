const express = require('express')
const router = express.Router()

const conn = require('../mysqlConnection')

router.get("/",(req,res) =>{
    const {idClient} = req.query

    conn.query(`SELECT idClient,firstName,lastName,email,dateOfBirth,phoneNumber, clientLevelName, profilePictureURL
        FROM CLIENT 
        LEFT JOIN CLIENT_LEVEL ON  CLIENT.idClientLevel = CLIENT_LEVEL.idClientLevel
        WHERE idClient = ?;`,
        [idClient],(err,result)=>
    {
        // console.log("user : "+JSON.stringify(result));
        
        if(err)
        {
            res.status(500).json({message:err})
            return
        }
        if(result.length !== 1)
        {
            res.status(404).json({message:"user not found"})
            return
        }
        res.send(result[0])
    })
})

router.get("/connectByEmail",(req,res) =>{
    const {email} = req.query

    conn.query(`SELECT idClient,firstName,lastName,email,dateOfBirth,phoneNumber, clientLevelName, profilePictureURL
        FROM CLIENT 
        LEFT JOIN CLIENT_LEVEL ON  CLIENT.idClientLevel = CLIENT_LEVEL.idClientLevel
        WHERE email = ?;`,
        [email],(err,result)=>
    {
        // console.log("user : "+JSON.stringify(result));
        
        if(err)
        {
            res.status(500).json({message:err})
            return
        }
        if(result.length !== 1)
        {
            res.status(404).json({message:"user not found"})
            return
        }
        res.send(result[0])
    })
})


module.exports = router