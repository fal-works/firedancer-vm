# Firedancer VM

Virtual machine for **Firedancer**, a Haxe based language for defining 2D shmup bullet-hell patterns. 


## Compiler flags

### `-D firedancer_verbose`

Emits verbose log.

### `-D firedancer_positionref_type=(name)`

Specifies the underlying type of `PositionRef`.

Example: `-D firedancer_positionref_type=broker_BatchSprite`

Valid values:

- "broker_BatchSprite" for `broker.draw.BatchSprite`
- "heaps_BatchElement" for `h2d.SpriteBatch.BatchElement`
- Otherwise an anonymous structure `{ x: Float, y: Float }`

### `-D firedancer_debug`

Detects infinite loops in the `Vm`.


## Dependencies

- [sinker](https://github.com/fal-works/sinker) v0.4.0 or compatible
- [sneaker](https://github.com/fal-works/sneaker) v0.10.0 or compatible
- [ripper](https://github.com/fal-works/ripper) v0.4.0 or compatible
- [banker](https://github.com/fal-works/banker) v0.7.0 or compatible
- [reckoner](https://github.com/fal-works/banker) v0.2.0 or compatible

See also:
[FAL Haxe libraries](https://github.com/fal-works/fal-haxe-libraries)
