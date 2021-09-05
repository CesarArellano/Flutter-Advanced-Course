const express = require('express');
require('dotenv').config(); // Lee el archivo .env

const app = express();

// parsear params
app.use(express.json());

// Route
app.use( '/', require('./routes/auth') );

const port = process.env.PORT || 3000;

app.listen( port, () => {
  console.log(`Servidor corriendo en el puerto ${ port }`);
});