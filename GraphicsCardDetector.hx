package;
import haxe.io.Bytes;
import haxe.io.Input;
import sys.io.Process;

/**
 * ...
 * @author isaac denner
 */
class GraphicsCardDetector 
{

	public function new() 
	{
		
	}
	
	///returns whether or not we have a name-brand graphics card. Probably only works on the CPP target. 
	public static function detectGraphicsCard():String
	{
		//this outputs a string with all detected graphics cards, including integrated.
		var t:Process = new Process("wmic path win32_VideoController get name", null, false);
		var h:Input = t.stdout;
		
		var myBytes:Bytes = h.readAll(10000);
		var outputString:String = myBytes.toString();
		
		
		//this is silly but I'm just searching for the names of any graphics card brand I can think of. You could ABSOLUTELY search for specific graphics cards (or strings like 2060/3060ti etc etc) within this and modify your settings accordingly.
		var ret:String = "No GPU";
		
		if (outputString.indexOf("NVIDIA") == -1 && outputString.indexOf("Radeon") == -1 && outputString.indexOf("GeForce") == -1)
		{
			trace("No graphics card detected");
		}
		else 
		{
			trace("Graphics card detected!");
			ret = outputString;
		}
		h.close();
		t.close();	
		
		//return whether or not we have found a graphics card of brand nvidia geforce/amd radeon 
		return ret;
	}
}
