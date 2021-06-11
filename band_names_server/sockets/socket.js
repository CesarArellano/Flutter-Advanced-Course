const { io } = require('../index');
const BandModel = require('../models/band-model');
const BandsModel = require('../models/bands-model');

const bands = new BandsModel;
bands.addBand( new BandModel('Siddhartha'));
bands.addBand( new BandModel('Technicolor Fabrics'));
bands.addBand( new BandModel('Daft Punk'));
bands.addBand( new BandModel('Odisseo'));

// Socket Messages
io.on('connection', client => {
  console.log('Client Connected');

  client.emit('activeBands', bands.getBands());

  client.on('disconnect', () => {
    console.log('Client Disconnected');
  });

  client.on('emitMessage', ( payload ) => {
    console.log(payload);
    // io.emit('newMessage', { name: 'César Arellano' }); Emite a todos.
    client.broadcast.emit('newMessage', payload ); // Emitir a todos menos al cliente.
  });

  client.on('voteBand', (id) => {
    bands.voteBand(id);
    io.emit('activeBands', bands.getBands());
  });
  
});