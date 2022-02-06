package;

import lime.utils.Bytes;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import flixel.FlxSubState;
import openfl.filters.BitmapFilter;
import openfl.display.BitmapData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import flixel.util.FlxSpriteUtil;
import lime.app.Application;
import openfl.Assets;
import flash.geom.Point;
import D;

#if windows
import Discord.DiscordClient;
import Sys;
import sys.FileSystem;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class DesktopState extends MusicBeatState
{
	var freeplayFolder:FlxSprite;
	var freeplayScreen:FlxSprite;

	var optionsFolder:FlxSprite;
	var optionsScreen:FlxSprite;
	var bobAndBosipApp:FlxSprite;
	var bg:FlxSprite;
	var galleryBG:FlxSprite;
	var fuckyouText:FlxText;
	var inCat:Int = 0;
	var transitioning:Bool = false;
	var exFolder:Bool = false;

	var currentMenu:String = 'desktop';
	var trText:FlxText;
	var sstuff:FlxTypedGroup<FlxSprite>;

	public var folders:FlxTypedGroup<FlxExtendedSprite>;
	public var folderLabels:FlxTypedGroup<FlxSprite>;

	var folderData:Array<String> = [
		'freeplay',
		'gallery',
		'friday night funkin'',
		'options',
		'stats',
		'sound test',
	];

	var myButt:Bool = false;
	var achievementsUnlocked:Map<String, Bool> = new Map();
	var freeplayName:String = 'freeplay';
	var draggingFolder:Bool = false;
	var visualDragFolder:Bool = false;
	var folder:FlxTypedGroup<FlxSprite>;
	var folderOffsets:Array<FlxPoint> = [];
	var folderDrag:FlxExtendedSprite;
	var stickers:FlxTypedGroup<FlxSprite>;

	var freeplayStuff:FlxTypedGroup<HealthIcon>;
	var freeplayLocks:FlxTypedGroup<HealthIcon>;
	var freeplayOffsets:Array<FlxPoint> = [];
	var freeplayLabels:FlxTypedGroup<FlxSprite>;
	var folderSelect:FlxSprite;

	var desktopStickers:Map<String, FlxPoint> = new Map();

	var gallery:FlxTypedGroup<FlxExtendedSprite>;

	var prevPos:FlxPoint;

	public var galleryWall:FlxSprite;
	public var fWall:FlxSprite;
	public var officialImageLocations:Array<String> = [];
	public var fanmadeImageLocations:Array<String> = [];        
	public var uImageLocations:Array<String> = [];   

	public static var officialGallery:FlxTypedGroup<FlxSprite>;
	public static var officialPictures:FlxTypedGroup<FlxSprite>;
	public static var uGallery:FlxTypedGroup<FlxSprite>;
	public  static  var  uPictures : FlxTypedGroup < FlxSprite >;
	public  static  var  fanmadeGallery : FlxTypedGroup < FlxSprite >;
	public  static  var  fanmadePictures : FlxTypedGroup < FlxSprite >;
	public  var  loadingImageLocations : Array < String > = [];  
	public  static  var  loadingGallery : FlxTypedGroup < FlxSprite >;
	public  static  var  loadingPictures : FlxTypedGroup < FlxSprite >;

	var  songs : Array < String > = [];
	var  songUnlocked : Array < Bool > = [];
	var  iconArray : Array < String > = [];

	var  folderBorder : FlxSprite ;

	var  closeFolder : Bool  =  false ;
	var  canOpenFolder : Bool  =  true ;
	var  canOpenNotepad : Bool  =  true ;
	var  canOpenTR : Bool  =  true ;

	var  notepadDrag : FlxExtendedSprite ;
	var  notepad : FlxTypedGroup < FlxSprite >;
	var  notepadOffsets : Array < FlxPoint > = [];
	var  notepadTextArray : Array < FlxSprite > = [];

	var  trDrag : FlxExtendedSprite ;
	var  tr : FlxTypedGroup < FlxSprite >;
	var  trOffsets : Array < FlxPoint > = [];
	var  trTextArray : Array < FlxSprite > = [];
	

	var  statsScroll : Int  =  0 ;
	var  statsScrollMax : Int  =  0 ;

	public  static  var  theSong : FlxSound ;

	var  theCode : Array < Dinâmico > = [