package org.osflash.signals {
	import asunit.framework.TestCase;

	import org.osflash.signals.natives.sets.EventDispatcherSignalSet;
	import org.osflash.signals.natives.sets.InteractiveObjectSignalSet;

	import flash.display.Sprite;
	import flash.events.Event;

	public class SignalSetTest extends TestCase {	

		private var sprite:Sprite;
		private var signalSet:InteractiveObjectSignalSet;

		override protected function setUp():void {
			super.setUp();
			
			sprite = new Sprite();
			signalSet = new InteractiveObjectSignalSet(sprite);
			
		}

		override protected function tearDown():void {
			super.tearDown();
			
			signalSet = null;
			
			removeChild(sprite);
			sprite = null;
		}

		[Test]
		public function subclassed_signal_set_should_instiantate():void {
			assertTrue(signalSet is EventDispatcherSignalSet);
		}

		[Test]
		public function numListeners_is_0_after_creation():void
		{
			assertEquals(signalSet.numListeners, 0);
		}

		[Test]
		public function add_listeners_to_two_different_signals():void {
			signalSet.activate.add(handleEvent);
			signalSet.deactivate.add(handleEvent);
			
			assertEquals(signalSet.numListeners, 2);
		}

		[Test]
		public function add_and_remove_signals():void {
			signalSet.activate.add(handleEvent);
			signalSet.deactivate.add(handleEvent);
			
			signalSet.removeAll();
			
			assertEquals(signalSet.numListeners, 0);
		}
		
		[Test]
		public function when_signal_adds_listener_then_target_should_have_listener():void
		{
			signalSet.activate.add(emptyHandler);
			assertEquals(1, signalSet.numListeners);
			assertTrue(sprite.hasEventListener(Event.ACTIVATE));
		}
		
		[Test]
		public function when_add_and_addOnce_should_have_one_listener():void
		{
			signalSet.activate.addOnce(emptyHandler);
			signalSet.deactivate.add(handleEvent);
			
			sprite.dispatchEvent(new Event(Event.ACTIVATE));
			
			assertEquals(1, signalSet.numListeners);
		}
		
		[Test]
		public function try_all_InteractiveObjectSignalSet_Events():void {
			signalSet.activate.add(handleEvent);
			
			assertSame(26, signalSet.numListeners);
		}

		private function handleEvent(event:Event):void
		{
			assertSame(sprite, event.target);
		}
		
		private function emptyHandler(e:Event):void {}
	}
}