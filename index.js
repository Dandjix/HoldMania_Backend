const express = require('express')

const app = express()
const port = 3000

//const mySqlConnection = require('./mysqlConnection')

const holdRoutes = require('./routes/holdRoutes')
const orderRoutes = require('./routes/orderRoutes')
const userRoutes = require('./routes/userRoutes')
const colorRoutes = require('./routes/colorRoutes')
const clientLevelRoutes = require('./routes/clientLevelRoutes')

app.use(express.json())
const host = '192.168.74.7'; 
  
app.listen(port, host,() => {
    console.log(`listening on port ${port}`);
})


app.use('/holds',holdRoutes)
app.use('/orders',orderRoutes)
app.use('/users',userRoutes)
app.use('/colors',colorRoutes)
app.use('/levels',clientLevelRoutes)