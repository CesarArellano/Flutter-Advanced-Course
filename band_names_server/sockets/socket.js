const { io } = require('../index');

// Socket Messages
io.on('connection', client => {
  console.log('Client Connected');

  client.on('disconnect', () => {
    console.log('Client Disconnected');
  });

  client.on('emitMessage', ( payload ) => {
    // io.emit('newMessage', { name: 'César Arellano' }); Emite a todos.
    client.broadcast.emit('newMessage', payload ); // Emitir a todos menos al cliente.
  });
  
});