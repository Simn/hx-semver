import mtask.target.HaxeLib;

class Build extends mtask.core.BuildBase
{
	public function new()
	{
		super();
	}

	@target function haxelib(t:HaxeLib)
	{
		t.url = "http://github.com/dpeek/hx-semver";
		t.description = "A Haxe port of the Node SemVer library.";
		t.versionDescription = "Fix to less than comparison.";

		t.addTag("cross");
		t.addTag("utility");

		t.beforeCompile = function(path)
		{
			cp("src/*", path);
		}
	}

	@task function test()
	{
		cmd("haxelib", ["run", "munit", "test", "-coverage"]);
	}

	@task function teamcity()
	{
		invoke("test");
		cmd("haxelib", ["run", "munit", "report", "teamcity"]);
		invoke("build haxelib");
	}
}
