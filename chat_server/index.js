const express = require('express');
const path = require('path');
require('dotenv').config();

// DB config
require('./database/config').dbConnection();

// App de Express
const app = express();

// Lectura y parseo del Body
app.use( express.json() );

// Node server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');


// Public path
const publicPath = path.resolve( __dirname, 'public' );
app.use(express.static( publicPath ));

// My routes
app.use('/api/login', require('./routes/auth'));
app.use('/api/users', require('./routes/users'));
app.use('/api/messages', require('./routes/messages'));

server.listen(process.env.PORT, (err) => {
  if( err ) throw new Error(err);

  console.log(`Servidor corriendo en puerto`, process.env.PORT);

});