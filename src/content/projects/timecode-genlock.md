---
title: "Timecode & Genlock"
tab: "performance-capture"
category: "Media System"
order: 2
status: "active"
---

When it comes to having multiple devices communicate together and especially when there is a need to record an event from multiple different sources, it becomes necessary to have a system to synchronize everything so that you can tell when certain things have happened.

Within the studio when we record animations with Mocap we make sure that each reference camera and each recorder are synchronized with the same timecode and travel at the same framerate. Optitrack's eSync module ensures that synchronization also occurs within the Motion Capture software, communicating data to individual cameras.

Timecode comes from four Tentacle Sync units, jam-synced from the Tentacle app on an iPhone: there is no master timecode generator. One feeds the OptiTrack eSync, one the AJA recorders (chained: the Ki Pro Ultra 12G passes it on to the two Ki Pro Racks), one is recorded as an audio track on the Behringer X32 Rack, and one goes to the Sony Burano when it records in camera.

Genlock comes from a Blackmagic sync generator and reaches the eSync, the Burano and the LED processor. The Roland V-160HD and the AJA recorders are not genlocked.
