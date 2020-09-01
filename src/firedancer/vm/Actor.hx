package firedancer.vm;

#if firedancer_use_actor_class
/**
	Object for storing values specific to each actor.

	Available only `#if firedancer_use_actor_class`.
**/
class Actor {
	public final threads: ThreadList;

	public var x: Float;
	public var y: Float;
	public var vx: Float;
	public var vy: Float;

	public var originPositionRef: Maybe<PositionRef>;

	public function new(threads: ThreadList) {
		this.threads = threads;
		this.x = 0.0;
		this.y = 0.0;
		this.vx = 0.0;
		this.vy = 0.0;
		this.originPositionRef = Maybe.none();
	}
}
#end
