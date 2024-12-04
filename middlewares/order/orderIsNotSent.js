const conn = require('../../mysqlConnection')

const orderIsNotSent = (req,res,next) =>
{
    const idOrder = req.query.idOrder;

    conn.query(`SELECT isSent FROM \`ORDER\` WHERE idOrder = ?;`,[idOrder],(err,result) =>{
        if (result.length <= 0) {
            res.status(404).json({ message: "Order not found" });
            return;
        }
        if (result.length > 1) {
            res.status(500).json({ message: "More than one order found" });
            return;
        }


        if(err)
        {
            res.status(500).json({message:err})
            return
        }
        if(result[0].isSent)
        {
            res.status(401).json({message:"order already sent : cannot be modified"})
            return
        }

        next()
    })
}

module.exports = orderIsNotSent