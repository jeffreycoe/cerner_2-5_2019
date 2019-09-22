// cerner_2^5_2019
// Check if the audio input device is in use somewhere on the iOS / macOS system

import Foundation
import AudioToolbox

public func isAudioDeviceInUseSomewhere(device: AudioObjectID) -> Bool {
  var inUseSomewhere = UInt32(0)
  var size = UInt32(MemoryLayout<UInt32>.size)
  var address: AudioObjectPropertyAddress = AudioObjectPropertyAddress()
  address.mSelector = kAudioDevicePropertyDeviceIsRunningSomewhere
  address.mScope = kAudioObjectPropertyScopeGlobal
  address.mElement = kAudioObjectPropertyElementMaster
  
  do {
    var osStatus = AudioObjectGetPropertyData(device, &address, 0, nil, &size, &inUseSomewhere)

    if osStatus != kAudioHardwareNoError {
      NSLog("isAudioDeviceInUseSomewhere: Error occurred.")
    }
  } catch let e {
    NSLog("isAudioDeviceInUseSomewhere: Error occurred.")
  }
  
  if inUseSomewhere == 1 {
    return true
  } else {
    return false
  }
}
