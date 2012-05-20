mongoose     = require 'mongoose'
Schema       = mongoose.Schema
ObjectId     = Schema.ObjectId

Sprite = new Schema
  _id: String        # the name forms the primary key
  ownerId: ObjectId  # reference to userId of owner
  creationDate: { type: Date, default: Date.now }

# a sprite animation is a single row of columns with identical width.
SpriteAnimation = new Schema
  spriteId: { type: ObjectId, index: true }
  name:     String
  image:    Buffer # png of sprite
  width:    Number # width of frame, height = image height

mongoose.model 'sprite', Sprite
mongoose.model 'sprite_animation', SpriteAnimation

# vim:ts=2 sw=2:

