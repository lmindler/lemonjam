﻿package com.lemonjam.ui.buttons{	import flash.display.MovieClip;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormatAlign;	import flash.events.MouseEvent;		import com.lemonjam.ui.buttons.LinkUnderline;	import com.greensock.*;	import com.greensock.plugins.*;	import com.asual.swfaddress.*;		public class Link extends MovieClip	{		private var _linkTXT:TextField;		private var _hitbox:MovieClip;		private var _url:String;				private var _underlineArray:Array = new Array();				public function Link()		{						TweenPlugin.activate([TintPlugin, ColorTransformPlugin]);						_hitbox = getChildByName("hitboxMC") as MovieClip;			_linkTXT = getChildByName("linkText") as TextField;			_linkTXT.autoSize = TextFieldAutoSize.LEFT;			_linkTXT.autoSize = TextFormatAlign.LEFT;					}				public function setLink(value:String, linkUrl:String):void		{			_url = linkUrl;			_linkTXT.text = value;			_addUnderlineDot();			_hitbox.width = _linkTXT.width + 4;						_hitbox.addEventListener(MouseEvent.MOUSE_OVER, _btnOver);			_hitbox.addEventListener(MouseEvent.MOUSE_OUT, _btnOut);			_hitbox.addEventListener(MouseEvent.CLICK, _btnClick);			this.buttonMode = true;		}				private function _addUnderlineDot():void		{			if((_underlineArray.length * 3) < _linkTXT.width){				var _dot:LinkUnderline = new LinkUnderline();				this.addChild(_dot);								_dot.x = _underlineArray.length * 3;				_dot.y = 22;				_underlineArray.push(_dot);								_addUnderlineDot();			}		}				private function _btnOver(e:MouseEvent):void		{			TweenLite.to(this, .5, {colorTransform:{tint:0xFFF600, tintAmount:1}});		}				private function _btnOut(e:MouseEvent):void		{			TweenLite.to(this, .5, {colorTransform:{tintAmount:0}});		}				private function _btnClick(e:MouseEvent):void		{			TweenLite.to(this, .5, {colorTransform:{tintAmount:0}});			SWFAddress.setValue(_url);		}	}}