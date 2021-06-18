const mongoose = require('mongoose');

const dbConnection = async () => {
  try {
    console.log('init dbConfig');
  } catch(error) {
    console.log(error);
    throw new Error('Error en la base de datos - Hable con el admin xd');
  }
}

module.exports = {
  dbConnection
}