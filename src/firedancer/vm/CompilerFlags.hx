package firedancer.vm;

import haxe.macro.Context;
import haxe.macro.Compiler;
import prayer.CompilerFlag;

/**
	Compiler flags that require initialization and/or may be referred in runtime.
**/
class CompilerFlags {
	/**
		`-D firedancer-vm`
	**/
	public static final version: CompilerFlag<String> = {
		name: "firedancer-vm",
		getDefine: () -> Compiler.getDefine("firedancer-vm"),
		validate: define -> if (define != null) Some(Std.string(define)) else None,
		type: Optional("0.0.0")
	};

	#if macro
	/**
		Initializes compiler flags and set default values if needed.
		Can only be called from the initialization macro.
	**/
	static function initialize() {
		version.set();

		#if debug
		final debugFlag = "firedancer_debug";
		if (Context.definedValue(debugFlag) == null)
			Compiler.define(debugFlag, '1');
		#end
	}
	#end
}
