﻿package com.lemonjam.core{		import flash.events.Event;	import flash.events.ProgressEvent;	import flash.display.Sprite;		public class DataSorter extends Sprite{		private var _xml:XML;		private var _categoryArrays:Array = new Array();		private var _categories:Array = new Array();		private var _featuredPhotos:Array = new Array();		private var _about:Array = new Array();		private var _contact:Array = new Array();		private var _blogImage:Array = new Array;				private var handle:String = "link-handle";		private var catFeatHandle:String = "featured-in-collection";				public function DataSorter()		{		}				public function set data(value:String):void		{			var _loadedXML:XML = new XML(value);						//contact			var _contactXML:XMLList = _loadedXML.contact;						for each(var contactSection:XML in _contactXML) {				for each(var contactEntry:Object in contactSection.entry)		_contact.push(contactEntry);			}						//about			var _aboutXMLList:XMLList = _loadedXML.about;						for each(var aboutSection:XML in _aboutXMLList) {				for each(var aboutEntry:Object in aboutSection.entry)			_about.push(aboutEntry);			}						//blog			var _blogXML:XMLList = _loadedXML.blog;			_blogImage.push(_blogXML[0].entry[0].background[0].filename[0]);						//photography			var _photoXML:XMLList = _loadedXML.photography;						for each(var photoSection:XML in _photoXML.section)			{				if(photoSection != "Photography")				{					var _newCategory:Array = new Array();					var _counter:Number = 1;										for each (var entry:Object in photoSection.entry){						var _entry:Object = new Object();						_entry.id = _counter						_entry.title = entry.title.@handle;						_entry.section = entry.section.item.@handle;						_entry.loaded = 0;						_entry.uri = makeURI(entry.title.@handle);						_entry.forceHorizontal = false;						_entry.img = "http://lemonjamphoto.com/cms/workspace/images/" + entry.photo.filename;						_entry.featured = entry.featured;						_entry.categoryFeatured = entry[catFeatHandle];						_newCategory.push(_entry);						_counter++;						if(_entry.featured == "Yes"){							_entry.forceHorizontal = true;							_featuredPhotos.push(_entry);						}					}					if(_newCategory.length > 0){						_categories.push(entry.section.item.@handle);						_categoryArrays.push(_newCategory);					}				}			}					organizePhotos();		}				private function makeURI(string:String):String		{			var _uri:String = "";			_uri = string.replace(" ", "-");			_uri = _uri.toLowerCase();			return _uri;		}				private function organizePhotos():void		{			_categories.unshift("blog");			_categories.unshift("about");			_categories.unshift("contact");						_featuredPhotos = shuffleArray(_featuredPhotos);						for(var i=0;i<_categoryArrays.length;i++){				_categoryArrays[i] = organizeCategoryArray(_categoryArrays[i]);			}		}				private function organizeCategoryArray(catArray:Array):Array		{			var _newArray:Array = new Array();						var _tempFeatured:Array = new Array();			var _tempRegular:Array = new Array();			var i:int = 0;						for(i=0;i<catArray.length;i++){				if(catArray[i].categoryFeatured == "Yes")		_tempFeatured.push(catArray[i]);				else											_tempRegular.push(catArray[i]);			}						_tempFeatured = shuffleArray(_tempFeatured);			_tempRegular = shuffleArray(_tempRegular);						for(i=0;i<_tempFeatured.length;i++){				_newArray.push(_tempFeatured[i]);			}						for(i=0;i<_tempRegular.length;i++){				_newArray.push(_tempRegular[i]);			}						return _newArray;		}				private function shuffleArray(arr:Array):Array {			var len:int = arr.length;			var temp:*;			var i:int = len;			while (i--) {				var rand:int = Math.floor(Math.random() * len);				temp = arr[i];				arr[i] = arr[rand];				arr[rand] = temp;			}			return arr;		}				public function get categories():Array		{			return _categories;		}				public function get photos():Array		{			return _categoryArrays;		}				public function get featured():Array		{			return _featuredPhotos;		}				public function get about():Array		{			return _about;		}				public function get contact():Array		{			return _contact;		}				public function get blogImage():Array		{			return _blogImage;		}	}}