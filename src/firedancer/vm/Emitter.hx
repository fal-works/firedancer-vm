package firedancer.vm;

import sneaker.exception.NotOverriddenException;

/**
	Any object that can emit a new actor.
**/
class Emitter {
	/**
		Creates a null object of `Emitter`.
	**/
	public static function createNull(): NullEmitter
		return new NullEmitter();

	/**
		Emits an actor.

		This method must be overridden by an user-defined sub-class.

		@param x X-component of the initial position (absolute).
		@param y Y-component of the initial position (absolute).
		@param vx X-component of initial velocity.
		@param vy Y-component of initial velocity.
		@param fireCode Any integer value to branch the emission process
		(e.g. switch graphics of the actor to be emitted).
		@param program The program to run.
		@param originPositionRef The reference to the origin point position.
		This is used for binding the position of the actor being fired to that of the actor that fired it.
		`Maybe.none()` if the position does not need to be bound.
	**/
	public function emit(
		x: Float,
		y: Float,
		vx: Float,
		vy: Float,
		fireCode: Int,
		program: Maybe<Program>,
		originPositionRef: Maybe<PositionRef>
	): Void {
		throw new NotOverriddenException();
	}
}

/**
	Null object class for `Emitter`.
**/
class NullEmitter extends Emitter {
	public function new() {}

	override public function emit(
		x: Float,
		y: Float,
		vx: Float,
		vy: Float,
		fireCode: Int,
		program: Maybe<Program>,
		originPositionRef: Maybe<PositionRef>
	): Void {}
}
