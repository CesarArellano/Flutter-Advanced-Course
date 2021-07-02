const { checkJWT } = require('../helpers/jwt');
const { io } = require('../index');

// Socket Messages
io.on('connection', client => {
  console.log('Client Connected');
  const [validated, uid] = checkJWT(client.handshake.headers['x-token']);

  if( !validated ) return client.disconnect();

  console.log('Cliente autenticado');

  client.on('disconnect', () => {
    console.log('Client Disconnected');
  });  
});