mongoose     = require 'mongoose'
Schema       = mongoose.Schema
ObjectId     = Schema.ObjectId

User = new Schema
  handle:       { type: String, index: { unique: true } }
  email:        { type: String, index: { unique: true } }
  password:     { type: String }
  token:        { type: String }
  creationDate: { type: Date, default: Date.now }

# cache the session IDs of logged in users
Session = new Schema
  _id:    { type: String, index: 1 },
  userId: ObjectId,
  date:   { type: Date, default: Date.now, index: 1 }

mongoose.model 'user', User
mongoose.model 'session', Session

# vim:ts=2 sw=2:
