# Firedancer VM

Virtual machine for [**Firedancer**](https://github.com/fal-works/firedancer), a Haxe based language for defining 2D shmup bullet-hell patterns.

## Usage

### Install

```sh
haxelib install firedancer-vm
```

### Preparation

#### ProgramPackage

Prepare any `firedancer.vm.ProgramPackage` instance created with [Firedancer](https://github.com/fal-works/firedancer) library.  
If you have a serialized program (which is a JSON string), parse it by `ProgramPackage.fromString()`.

#### Emitter & EventHandler

Extend the classes below and override their methods:

- `firedancer.vm.Emitter`
- `firedancer.vm.EventHandler`

#### Actors

Assuming you set the compiler flag `-D firedancer_use_actor_class`, create your actors by doing the below for each actor:

1. Create a `firedancer.vm.ThreadList` instance.
1. Create a `firedancer.vm.PositionRef` instance that provides read access to the position of the actor at the end of the last frame.
1. Create a `firedancer.vm.Actor` instance passing the two above.

Without the compiler flag `-D firedancer_use_actor_class`, the `Actor` class is not available and you have to prepare any SoA or AoSoA style structures using the type `banker.vector.WritableVector` for each property (see library [banker](https://github.com/fal-works/banker)).

#### Target position

Prepare another `PositionRef` instance that indicates the position of the target to be aimed.

This may be either common in actors or specific to each actor.

#### Set Program

At the beginning, at least one actor should be active and have any `firedancer.vm.Program` instance.

Set any `Program` instance (that you get from your `ProgramPackage` instance) by `ThreadList.set()` or `Actor.setProgram()`.

### Run

Run `firedancer.vm.Vm.run()` every frame for each actor, passing the below:

- The `programTable` that you get from your `ProgramPackage` instance.
- Instances of your classes extended from `EventHandler` and `Emitter`.
- The memory capacity in bytes, which you used when creating `ThreadList` instances. Typically it's common in all actors.
- Your actor data (`#if firedancer_use_actor_class`, the `Actor` instance).
- The `PositionRef` instance for the target position.

Then render the actors using any game framework or some kind of that.

## Compiler flags

### `-D firedancer_verbose`

Emits verbose log.

### `-D firedancer_positionref_type=(name)`

Specifies the underlying type of `PositionRef`.

Example: `-D firedancer_positionref_type=broker_BatchSprite`

Valid values:

- `broker_BatchSprite` for using `broker.draw.BatchSprite`
- `heaps_BatchElement` for using `h2d.SpriteBatch.BatchElement`
- Otherwise uses an anonymous structure `{ x: Float, y: Float }`

### `-D firedancer_use_actor_class

Enables to use `Actor` class instead of the default SoA (Structure of Arrays) style.

(*Not yet tested*)

### `-D firedancer_debug`

Throws error if:

- infinite loop is detected in the `Vm`
- unknown `Opcode` is detected in a `Program`

Automatically set `#if debug`.

## Dependencies

- [sinker](https://github.com/fal-works/sinker) v0.5.0 or compatible
- [sneaker](https://github.com/fal-works/sneaker) v0.11.0 or compatible
- [banker](https://github.com/fal-works/banker) v0.7.0 or compatible
- [reckoner](https://github.com/fal-works/banker) v0.2.0 or compatible

See also:
[FAL Haxe libraries](https://github.com/fal-works/fal-haxe-libraries)
