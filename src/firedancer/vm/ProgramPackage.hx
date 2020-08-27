package firedancer.vm;

import haxe.Json;
import banker.vector.Vector;
import banker.map.ArrayMap;

using banker.type_extension.MapExtension;

/**
	Collection of `Program` instances that can be retrieved by ID or name.
**/
class ProgramPackage {
	/**
		The version of `firedancer-vm` that should be compatible with `this` package.
	**/
	public final vmVersion: String;

	/**
		Table for retrieving `Program` by ID number.
	**/
	public final programTable: Vector<Program>;

	/**
		Mapping from names to ID numbers of `Program` instances.
	**/
	final nameIdMap: ArrayMap<String, UInt>;

	public function new(
		programList: Vector<Program>,
		nameIdMapping: Map<String, UInt>
	) {
		this.vmVersion = CompilerFlags.version.get();
		this.programTable = programList;

		final nameIdMap = new ArrayMap<String, UInt>(nameIdMapping.countKeys());
		for (name => id in nameIdMapping) nameIdMap.set(name, id);
		this.nameIdMap = nameIdMap;
	}

	/**
		@return `Program` registered with `name`.
	**/
	public function getProgramByName(name: String): Program {
		#if firedancer_debug
		if (!this.nameIdMap.hasKey(name)) throw 'Program not found: $name';
		#end

		final id = this.nameIdMap.get(name);
		return this.programTable[id];
	}

	/**
		Converts `this` to JSON string.
	**/
	public function toString(): String {
		final nameIdMap = new Map<String, UInt>();
		this.nameIdMap.forEach((key, value) -> nameIdMap.set(key, value));
		final programTable = this.programTable.ref.map(Program.serialize).toArray();

		final obj: ProgramPackageObject = {
			vmVersion: this.vmVersion,
			programTable: programTable,
			nameIdMap: nameIdMap
		};

		final json = Json.stringify(obj, null, "  ");
		return json.toString();
	}
}

private typedef ProgramPackageObject = {
	final vmVersion: String;
	final programTable: Array<String>;
	final nameIdMap: Dynamic;
}
