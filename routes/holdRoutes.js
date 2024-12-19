const express = require('express')
const router = express.Router()

const conn = require('../mysqlConnection')

router.get('/',(req,res) => {
    try
    {
        const {idClientLevels,idColors} = req.query

        console.log(`query values : ${idClientLevels}|${idColors}`);
        // query values : 1,2,3|1,2
    
        let whereConditions = [];
        if (idClientLevels) {
            const clientLevels = idClientLevels.split(',').map(level => parseInt(level, 10)).filter(Boolean);
            if (clientLevels.length > 0) {
                whereConditions.push(`HOLD.idClientLevel IN (${clientLevels.join(',')})`);
            }
        }

        if (idColors) {
            const colors = idColors.split(',').map(color => parseInt(color, 10)).filter(Boolean);
            if (colors.length > 0) {
                whereConditions.push(`HOLD.idHoldColor IN (${colors.join(',')})`);
            }
        }

        const whereClause = whereConditions.length > 0 ? `WHERE ${whereConditions.join(' AND ')}` : '';


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
            ${whereClause};`
            ,(err,result,fields) => {
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
        res.status(500).json({error:"Internal error"})
    }
    
})

router.get('/:idHold',(req,res) => {

    const {idHold} = req.params
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
        WHERE idHold = ${idHold}
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