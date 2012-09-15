﻿package com.lemonjam.core{		import flash.display.MovieClip;	import flash.events.Event;	import flash.display.*;	import flash.text.*;	import flash.net.*;	import flash.utils.*;		public class XMLLoader extends MovieClip {				public var _xml:XML;				public function XMLLoader(aURL){						var myData:URLRequest 	= new URLRequest(aURL);							var loader:URLLoader	= new URLLoader();								loader.dataFormat	= URLLoaderDataFormat.TEXT;						loader.addEventListener(Event.COMPLETE, onLoadXML);							loader.load(myData);		}				/**********************************************************		XML Event Handlers		**********************************************************/						private function onLoadXML(event:Event):void {			try {								_xml = new XML(event.target.data);				_xml.ignoreWhitespace	= true;								dispatchEvent(new Event(Event.COMPLETE, true));												} catch (e:TypeError) {				trace("Could not parse the XML");				trace(e.message);			}		}				public function get xmlData():XML		{			return _xml;		}	}//end class}//end package