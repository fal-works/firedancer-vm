package firedancer.vm.internal;

import haxe.Int32;
import firedancer.vm.Opcode;
import firedancer.vm.Constants.*;
#if firedancer_verbose
import sneaker.print.Printer;

using firedancer.vm.OpcodeExtension;
#end

/**
	Virtual scanner of bytecode data.
**/
@:nullSafety(Off)
class Scanner {
	/**
		The program counter.
		Indicates the current position in the bytecode.
	**/
	public var pc: UInt;

	/**
		The upper bound of the value of `pc` i.e. the length of the bytecode.
	**/
	var codeLength(default, null): UInt;

	/**
		The bytecode data to scan.
	**/
	var code: Bytecode;

	#if (debug || firedancer_debug)
	/**
		Number of instructions that have been executed in the current frame.
		Used for detecting infinite loop in debug mode.
	**/
	var scanCount: UInt;
	#end

	public #if hl extern #end inline function new() {}

	/**
		Resets `this` scanner according to the current status of `thread`.
	**/
	public extern inline function reset(thread: Thread): Void {
		this.pc = thread.programCounter;
		this.codeLength = thread.codeLength;
		this.code = thread.code.unwrap();

		#if (debug || firedancer_debug)
		this.scanCount = UInt.zero;
		#end
	}

	/**
		Reads the next opcode.
	**/
	public extern inline function opcode(): Opcode {
		#if hl
		final opcode: Opcode = cast untyped $bgetui8(code, pc);
		#else
		final opcode: Opcode = cast code.getUI8(pc);
		#end

		#if firedancer_verbose
		println('${opcode.toString()} (pos: $pc)');
		#end

		pc += Opcode.size;

		#if (debug || firedancer_debug)
		scanCount += 1;
		#end

		return opcode;
	}

	/**
		Reads the next integer immediate.
	**/
	public extern inline function int(): Int32 {
		#if hl
		final value: Int32 = untyped $bgeti32(code, pc);
		#else
		final value: Int32 = code.getI32(pc);
		#end

		pc += IntSize;

		return value;
	}

	/**
		Reads the next float immediate.
	**/
	public extern inline function float(): Float {
		#if hl
		final value: Float = untyped $bgetf64(code, pc);
		#else
		final value: Float = code.getF64(pc);
		#end

		pc += FloatSize;

		return value;
	}

	/**
		@return `true` if the program counter has reached (or exceeded) the end of code.
	**/
	public extern inline function reachedEnd(): Bool
		return codeLength <= pc;

	/**
		Throws error if `opcode()` is called more times than `threshold`.

		No effect `#if (!debug && !firedancer_debug)`.
	**/
	public extern inline function checkInfinite(threshold: UInt): Void {
		#if (debug || firedancer_debug)
		if (threshold < scanCount) throw "Detected infinite loop.";
		#end
	}

	#if firedancer_verbose
	static function println(s: String): Void
		Printer.println(s);
	#end
}
