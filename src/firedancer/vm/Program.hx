package firedancer.vm;

import haxe.Serializer;
import haxe.Unserializer;
import banker.binary.Bytes;

/**
	A firedancer program that represents a bullet pattern.

	You can also use `Bytecode` directly if you store the entire `length` externally.
**/
@:notNull @:forward(length, toHex)
abstract Program(Bytes) from Bytes to Bytes {
	/**
		@return `Program` instance deserialized from `s`.
	**/
	public static function deserialize(s: String): Program
		return Unserializer.run(s);

	/**
		Serializes `program`.
		@return Serialized data in `String` representation.
	**/
	public static function serialize(program: Program): String {
		final s = new Serializer();
		s.serialize(program.std());
		return s.toString();
	}

	/**
		@return Null object for `Program`.
	**/
	public static function createEmpty()
		return Bytes.alloc(UInt.zero);

	/**
		Provides access to the bytecode.
	**/
	public var data(get, never): Bytecode;

	/**
		Casts `this` to the standard `haxe.io.Bytes`.
	**/
	public inline function std(): haxe.io.Bytes
		return this.std();

	/**
		@return Hexadecimal representation of `this` with each byte separated.
	**/
	public inline function toString(): String
		return this.toHex();

	extern inline function get_data()
		return this.data;
}
