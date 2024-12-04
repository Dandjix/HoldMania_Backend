const express = require('express')
const router = express.Router()

const conn = require('../mysqlConnection')

router.get('/',(req,res) => {
    conn.query(
        `
        SELECT idHold,

        HOLD_COLOR.holdColorName,
        HOLD_TYPE.holdTypeName,
        CLIENT_LEVEL.clientLevelName,

        holdName,
        price,
        weight,
        sizeMeters,
        imageURL 

        FROM HOLD
        LEFT JOIN HOLD_COLOR ON HOLD.idHoldColor = HOLD_COLOR.idHoldColor
        LEFT JOIN HOLD_TYPE ON HOLD.idHoldType = HOLD_TYPE.idHoldType
        LEFT JOIN CLIENT_LEVEL ON HOLD.idClientLevel = CLIENT_LEVEL.idClientLevel
        ;`
        ,(err,result,fields) => {
        if(err)
        {
            console.error("error : "+err)
            res.status(500).json({error:err})
            return
        }
        res.send(result)
    })
})

module.exports = router;