const express = require('express')
const router = express.Router()

const orderIsNotSent = require('../middlewares/order/orderIsNotSent')
const cartDoesntExist = require('../middlewares/order/cartDoesNotExist')

const conn = require('../mysqlConnection')


router.get('/:idUser',(req,res)=>
{
    const idUser = req.params.idUser;

    conn.query(`
        SELECT 
            O.idOrder,
            O.dateOrder,
            O.isSent,
            COALESCE(SUM(H.price * OL.quantity),0) AS totalOrderPrice,
            COALESCE(SUM(OL.quantity),0) AS totalNumberOfHolds
        FROM \`ORDER\` O
        LEFT JOIN ORDER_LINE OL ON O.idOrder = OL.idOrder
        LEFT JOIN HOLD H ON OL.idHold = H.idHold
        WHERE O.idUser = ?
        GROUP BY O.idOrder, O.dateOrder;`
        ,
        [idUser]
        ,
        (err,result)=>{
            if(err)
            {
                console.error("error : "+err);
                res.status(500).json({error:err})
                return;
            }
            res.send(result)
    })
})

router.post('/lines',orderIsNotSent,(req,res)=>
    {
        let {idOrder,idHold, quantity} = req.query
    
        if(!quantity)
            quantity = 1
    
        conn.query(
            `INSERT INTO ORDER_LINE (idOrder, idHold, quantity) VALUES 
            (?, ?, ?);`,
            [idOrder,idHold,quantity],(err,result)=>{
            if(err)
            {
                console.error("error : "+err);
                res.status(500).json({error:err})
                return
            }
            res.status(200).json({message:"Line added successfully"})
        })
    })


router.post('/:idUser',cartDoesntExist,async (req,res)=>
    {
        const idUser = req.params.idUser;

        try {
            const query = `INSERT INTO \`ORDER\` (idUser, dateOrder) VALUES (?, CURDATE())`;
            const {insertId} = (await conn.promise().query(query, [idUser]))[0]; // Use a promise-based version of your query method
            res.status(200).json({ message: "Order created successfully",idOrder:insertId });
        } catch (err) {
            console.error("Error in creating the order: ", err);
            res.status(500).json({ error: err.message });
            return;
        }
    })

router.get('/lines/:idOrder',(req,res)=>{
    const idOrder = req.params.idOrder

    conn.query(`SELECT quantity,ORDER_LINE.idHold, holdName, imageURL, price AS unitPrice,price*quantity AS totalPrice  
        FROM ORDER_LINE
        LEFT JOIN HOLD ON ORDER_LINE.idHold = HOLD.idHold
        WHERE idOrder = ?
        ;`,
        [idOrder],
        (err,result)=>{
            if(err)
            {
                console.error("error : "+err);
                res.status(500).json({error:err})
                return;
            }
            res.send(result)
        })
})

router.patch('/lines',orderIsNotSent,(req,res)=>
{
    const {idOrder,idHold,quantity} = req.query

    console.log(idOrder, idHold, quantity);
    

    conn.query(
    `UPDATE ORDER_LINE
    SET quantity=?
    WHERE idOrder = ? AND idHold =?
    ;`,[quantity,idOrder,idHold],(err,result)=>
    {
        if(err)
        {
            console.error("error : "+err);
            res.status(500).json({error:err})
            return
        }

        res.status(200).json({message:"Quantity updated successfully"})
    })
})

router.delete('/lines',orderIsNotSent,(req,res)=>
{
    const {idOrder,idHold} = req.query
    conn.query(`DELETE FROM ORDER_LINE WHERE idOrder= ? AND idHold = ?;`,[idOrder,idHold],(err,result)=>{
        if(err)
        {
            console.error("error : "+err);
            return
        }
        res.status(200).json({message:"Line deleted successfully"})
    })
})
//route to send an order
router.patch('/',orderIsNotSent,(req,res)=>
{
    const {idOrder} =req.query
    conn.query(`UPDATE \`ORDER\` SET isSent = true WHERE idOrder = ?;`,[idOrder],(err,result)=>{
        if(err)
        {
            console.error("error : "+err);
            return
        }
        res.status(200).json({message:"Order sent successfully"})
    })
})

module.exports = router