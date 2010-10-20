package org.osflash.signals.natives.sets {
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Jon Adams
	 */
	public class DisplayObjectSignalSet extends EventDispatcherSignalSet {

		public var added:NativeSignal;
		public var addedToStage:NativeSignal;
		public var enterFrame:NativeSignal;
		public var removed:NativeSignal;
		public var removedFromStage:NativeSignal;
		public var render:NativeSignal;

		public function DisplayObjectSignalSet(target:DisplayObject) {
			super(target);
			signals.push(added = new NativeSignal(target, Event.ADDED, Event));
		}
	}
}