const express = require('express');
const path = require('path');
require('dotenv').config();

// App de Express
const app = express();

// Node server
const server = require('http').createServer(app);
const io = require('socket.io')(server);

// Socket Messages
io.on('connection', client => {
  console.log('Client Connected');

  client.on('disconnect', () => {
    console.log('Client Disconnected');
  });

  client.on('message', ( payload ) => {
    console.log('Message!!!', payload);
    io.emit('message', { admin: 'New Message' });
  });
  
});



// Public path
const publicPath = path.resolve( __dirname, 'public' );
app.use(express.static( publicPath ));

server.listen(process.env.PORT, (err) => {
  if( err ) throw new Error(err);

  console.log(`Servidor corriendo en puerto`, process.env.PORT);

});