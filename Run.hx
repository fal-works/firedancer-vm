class Run {
	static function main() {
		#if sys
		final libraryName: String = "firedancer-vm";
		final version = haxe.macro.Compiler.getDefine("firedancer-vm");

		final url = 'https://lib.haxe.org/p/${libraryName}/';

		Sys.println('\n${libraryName} ${version}\n${url}\n');
		#end
	}
}
