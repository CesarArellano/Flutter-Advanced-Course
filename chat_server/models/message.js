const { Schema, model } = require('mongoose');

const MessageSchema = Schema({
  from: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  to: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    require: true,
  },
  message: {
    type: String,
    require: true
  }
}, {
  timestamps: true
});

// Overwriting in the toJSON Method to display some properties
MessageSchema.method('toJSON', function() {
  const { __v, _id, ...object } = this.toObject();
  return object;
});

// Mongoose add by default a letter 's'
module.exports = model('Message', MessageSchema);