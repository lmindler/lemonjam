﻿package com.lemonjam.pages.blog{	import flash.display.MovieClip;	import com.lemonjam.pages.SectionBase;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.Event;	import flash.net.URLRequestMethod;	import com.greensock.*;	import flash.text.StyleSheet;	import flash.events.StatusEvent;	import com.adobe.serialization.json.*;	public class BlogHolderBase extends SectionBase	{		//private var accountName:String = "lemonjamphoto";		private var accountName:String = "lemonjamphoto";		private var _dataSet:Boolean = false;		protected var posts:Array = new Array();				private var _currentLoading:Number = 0;				private var _css:StyleSheet = new StyleSheet();		private var _cssLoader:URLLoader = new URLLoader();				public function BlogHolderBase()		{			_cssLoader.load(new URLRequest("assets/type.css"));			_cssLoader.addEventListener(Event.COMPLETE, _cssComplete);		}				private function _cssComplete(e:Event):void		{			_css.parseCSS(e.target.data);		}		public function feedRequest():void		{			_dataSet = true;			var loader:URLLoader = new URLLoader  ;			var req = new URLRequest("http://" + accountName + ".tumblr.com/api/read/?num=25");			req.method = URLRequestMethod.GET;			loader.addEventListener(Event.COMPLETE, feedLoaded);			loader.load(req);		}		private function feedLoaded(evt:Event):void		{			evt.target.removeEventListener(Event.COMPLETE, feedLoaded);			var feed:XML = new XML((evt.target as URLLoader).data);			var xmlPosts:XMLList = feed.posts.post;			var tempItem:Object;			for (var i:uint = 0; i < xmlPosts.length(); i++)			{				tempItem = new Object();				tempItem.type = xmlPosts[i].@type;				var _tempCurrentXML:XML = xmlPosts[i];				if (tempItem.type == "photo")				{					tempItem.title = "PHOTO";					tempItem.desc = (xmlPosts[i].child("photo-caption").length() > 0) ? xmlPosts[i].child("photo-caption")[0] : "no photo caption";					tempItem.photo = _tempCurrentXML["photo-url"][1];					tempItem.width = _tempCurrentXML.@width;					tempItem.height = _tempCurrentXML.@height;					tempItem.url = _tempCurrentXML.@url;										var _tempPhoto:BlogItemPhoto = new BlogItemPhoto(tempItem, i + 1, xmlPosts.length(), stage.stageHeight);					addChild(_tempPhoto);					posts.push(_tempPhoto);				}				/*else if (tempItem.type == "video") {					tempItem.title = "VIDEO";					tempItem.desc = (xmlPosts[i].child("video-caption").length() > 0) ? xmlPosts[i].child("video-caption")[0] : "no video caption";					tempItem.src = xmlPosts[i].child("video-player")[0];					var _tempVideo:BlogItemVideo = new BlogItemVideo(tempItem,i + 1,xmlPosts.length(),stage.stageHeight);					addChild(_tempVideo);					posts.push(_tempVideo);				}*/								else if (tempItem.type == "quote") {					tempItem.title = xmlPosts[i].child("quote-text")[0];					tempItem.desc = (xmlPosts[i].child("quote-source").length() > 0) ? xmlPosts[i].child("quote-source")[0] : "no quote source";					var _tempQuote:BlogItemQuote = new BlogItemQuote(tempItem,i + 1,xmlPosts.length(),stage.stageHeight);					addChild(_tempQuote);					posts.push(_tempQuote);				}								else if (tempItem.type == "regular") {					tempItem.title = xmlPosts[i].child("regular-title")[0];					tempItem.desc = (xmlPosts[i].child("regular-body").length() > 0) ? xmlPosts[i].child("regular-body")[0] : "no description";					var _tempRegular:BlogItemRegular = new BlogItemRegular(tempItem,i + 1,xmlPosts.length(),stage.stageHeight, _css);					addChild(_tempRegular);					posts.push(_tempRegular);				}				posts[posts.length-1].itemHeight = stage.stageHeight;				posts[posts.length-1].alpha = 0;				posts[posts.length-1].x = (i == 0) ? 0 : (posts[posts.length-2].width + posts[posts.length-2].x + 1);			}									_loadNext();		}				private function _loadNext():void		{			TweenLite.to(posts[_currentLoading], .5, {alpha:1});						if(! posts[_currentLoading].hasEventListener(Event.COMPLETE)){				posts[_currentLoading].addEventListener(Event.COMPLETE, _postLoaded);				posts[_currentLoading].loadContent();			}		}				private function _postLoaded(e:Event):void		{			posts[_currentLoading].removeEventListener(Event.COMPLETE, _postLoaded);						_currentLoading += 1;						if(_currentLoading < posts.length)	_loadNext();						dispatchEvent(new StatusEvent(StatusEvent.STATUS, true));		}		public function get dataSet():Boolean		{			return _dataSet;		}	}}