const { response } = require('express');
const bcrypt = require('bcryptjs');

const User = require('../models/user');
const { generateJWT } = require('../helpers/jwt');

const errorServer = (error) => {
  console.log(error);
  res.status(500).json({
    ok: false,
    msg: 'Talk to the administrator'
  });
}

const createUser = async (req, res = response) => {
  
  try{
    const { email, password } = req.body;
    const emailExists = await User.findOne({ email });
    if(emailExists) {
      return res.status(400).json({
        ok: false,
        msg: 'Invalid credentials'
      });
    }
    const user = new User(req.body);
    
    // Encrypting password
    const salt = bcrypt.genSaltSync();
    user.password = bcrypt.hashSync(password, salt);

    await user.save();
    
    // Generate my JWT
    const token = await generateJWT(user.id);

    res.json({
      ok: true,
      user,
      token
    });

  } catch(error) {
    errorServer(error);
  }
}

const loginUser = async (req, res = response) => {
  const { email, password } = req.body;

  try {
    const dbUser = await User.findOne({ email });

    if( !dbUser ) {
      return res.status(400).json({
        ok: false,
        msg: 'Email not found'
      });
    }
    
    // Validating password
    const validPassword = bcrypt.compareSync(password, dbUser.password);
    
    if( !validPassword ) {
      return res.status(400).json({
        ok: false,
        msg: 'Invalid credentials'
      });
    }
    
    const token = await generateJWT(dbUser.id);

    res.json({
      ok: true,
      user: dbUser,
      token
    });
  } catch (error) {
    errorServer(error);
  }
  
}

const renewToken = async (req, res = responde) => {
  const uid  = req.uid;

  try {
    const newToken = await generateJWT(uid);
    const dbUser = await User.findById(uid);
    
    res.json({
      ok: true,
      user: dbUser,
      token: newToken
    });

  } catch (error) {
    errorServer(error);
  }
};

module.exports = {
  createUser,
  loginUser,
  renewToken
};