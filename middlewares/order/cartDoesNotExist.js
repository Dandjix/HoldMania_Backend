const conn = require('../../mysqlConnection')

const cartDoesntExist = (req,res,next) =>
{
    const idUser = req.params.idUser;

    conn.query(`SELECT COUNT(idOrder) AS number FROM \`ORDER\` WHERE idUser=? AND isSent=False;`,[idUser],(err,result) =>{

        const {number} = result[0];

        if(number == 0)
            next()
        else
        {
            res.status(409).json({error:"A cart (order not sent) already exists for this user."})
        }
    })
}

module.exports = cartDoesntExist