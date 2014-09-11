﻿package qp.game {    import flash.media.Sound;	import flash.media.SoundChannel;    public class SoundManager {        private static var current: SoundChannel;        private static var map: Object = {};        public static function register(id: String, sound: Sound): void {            SoundManager.map[id] = sound;        }        public static function play(id: String): void {            SoundManager.stop();            if (SoundManager.map[id] != null)                current = SoundManager.map[id].play();        }        public static function stop(): void {            if (current != null)                current.stop();        }    }}