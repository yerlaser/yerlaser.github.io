#!/bin/zsh

# To install: cp com.user.loginscript.plist ~/Library/LaunchAgents/
# To manage: launchctl load <filename>
# More commands: unload, list, start, stop

hidutil property --set '{"UserKeyMapping":[
  {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},
  {"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000004C},
  {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x70000004D}
]}'
