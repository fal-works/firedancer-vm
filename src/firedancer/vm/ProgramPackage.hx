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
		Creates a `ProgramPackage` instance from a JSON string.
		@param jsonText JSON-encoded text. The data should unify `ProgramPackageObject`.
	**/
	public static function fromString(jsonText: String): ProgramPackage {
		final obj: ProgramPackageObject = Json.parse(jsonText);
		final programTable = Vector.fromArrayCopy(obj.programTable.map(Program.deserialize));
		final nameIdMap = new Map<String, UInt>();
		for (name in Reflect.fields(obj.nameIdMap))
			nameIdMap.set(name, Reflect.field(obj.nameIdMap, name));

		return new ProgramPackage(programTable, nameIdMap, obj.vmVersion);
	}

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
		nameIdMapping: Map<String, UInt>,
		?vmVersion: String
	) {
		this.vmVersion = (vmVersion != null) ? vmVersion : CompilerFlags.version.get();
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
		final nameIdMap:Dynamic = {};
		this.nameIdMap.forEach((key, value) -> Reflect.setField(nameIdMap, key, value));
		final programTable = this.programTable.ref.map(Program.serialize).toArray();

		final obj: ProgramPackageObject = {
			nameIdMap: nameIdMap,
			programTable: programTable,
			vmVersion: this.vmVersion
		};

		final json = Json.stringify(obj, null, "  ");
		return json.toString();
	}
}

private typedef ProgramPackageObject = {
	final nameIdMap: Dynamic;
	final programTable: Array<String>;
	final vmVersion: String;
}
