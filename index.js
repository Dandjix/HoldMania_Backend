const express = require('express')

const app = express()
const port = 3000

//const mySqlConnection = require('./mysqlConnection')

const holdRoutes = require('./routes/holdRoutes')
const orderRoutes = require('./routes/orderRoutes')

app.use(express.json())

app.listen(port,() => {
    console.log("listening on port 3000");
})


app.use('/holds',holdRoutes)
app.use('/orders',orderRoutes)