const { io } = require('../index');

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