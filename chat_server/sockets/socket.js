const { io } = require('../index');

// Socket Messages
io.on('connection', client => {
  console.log('Client Connected');

  client.on('disconnect', () => {
    console.log('Client Disconnected');
  });  
});