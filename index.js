const express = require('express')

const app = express()
const port = 3000

//const mySqlConnection = require('./mysqlConnection')

const holdRoutes = require('./routes/holdRoutes')
const orderRoutes = require('./routes/orderRoutes')
const userRoutes = require('./routes/userRoutes')

app.use(express.json())
const host = '192.168.189.207'; 

app.listen(port, host,() => {
    console.log(`listening on port ${port}`);
})


app.use('/holds',holdRoutes)
app.use('/orders',orderRoutes)
app.use('/users',userRoutes)