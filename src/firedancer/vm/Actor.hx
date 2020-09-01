package firedancer.vm;

#if firedancer_use_actor_class
/**
	Object for storing values specific to each actor.

	Available only `#if firedancer_use_actor_class`.
**/
class Actor {
	public var threads: ThreadList;

	public var x: Float;
	public var y: Float;
	public var vx: Float;
	public var vy: Float;

	public var thisPositionRef: PositionRef;
	public var originPositionRef: Maybe<PositionRef>;

	/**
		@param threads `ThreadList` instance specifid to `this` actor.
		@param thisPositionRef `PositionRef` instance that provides read access
		to the position of `this` actor at the end of the last frame.
	**/
	public function new(threads: ThreadList, thisPositionRef: PositionRef) {
		this.threads = threads;
		this.x = 0.0;
		this.y = 0.0;
		this.vx = 0.0;
		this.vy = 0.0;
		this.thisPositionRef = thisPositionRef;
		this.originPositionRef = Maybe.none();
	}
}
#end
