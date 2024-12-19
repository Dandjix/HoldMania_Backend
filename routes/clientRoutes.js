const express = require('express')
const router = express.Router()

const conn = require('../mysqlConnection')

router.get('/',(req,res) => {
    try
    {
        levels = conn.query(`SELECT idClientLevel,clientLevelName FROM CLIENT_LEVEL;`,(err,result,fields)=>{
            if(err)
            {
                console.error("error : "+err)
                res.status(500).json({error:err})
                return
            }
            res.send(result)
        })
    }
    catch(e)
    {
        console.error("error : "+err)
        res.status(500).json({error:err})
        return
    }
})