# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

WindowManager is a macOS window management utility built with SwiftUI that provides global hotkey shortcuts for positioning windows on the screen. It runs as a menu bar application and uses the HotKey library for keyboard shortcut handling and Accessibility APIs for window manipulation.

## Key Architecture Components

- **WindowManagerApp.swift**: Main application entry point with menu bar interface and HotKeyManager initialization
- **HotKeyManager**: Core class handling global keyboard shortcuts and window positioning logic using macOS Accessibility APIs
- **ContentView.swift**: Simple SwiftUI view for the menu bar interface

## Development Commands

### Building and Running
- Build: `xcodebuild -project WindowManager.xcodeproj -scheme WindowManager build`
- Run from Xcode: Open `WindowManager.xcodeproj` in Xcode and use Cmd+R
- Archive: `xcodebuild -project WindowManager.xcodeproj -scheme WindowManager archive`

### Testing
- Run unit tests: `xcodebuild -project WindowManager.xcodeproj -scheme WindowManagerTests test`
- Run UI tests: `xcodebuild -project WindowManager.xcodeproj -scheme WindowManagerUITests test`
- Uses Swift Testing framework (not XCTest)

## Dependencies

- **HotKey**: External Swift package for global hotkey registration (https://github.com/soffes/HotKey)
- Requires macOS 14.6+ (specified in project settings)

## Accessibility Requirements

The app requires Accessibility permissions to manipulate windows of other applications. The HotKeyManager automatically prompts for these permissions on first launch using `AXIsProcessTrustedWithOptions`.

## Keyboard Shortcuts

The application registers these global shortcuts (Ctrl+Option+):
- Left/Right Arrow: Move window to left/right half of screen
- U/I: Move window to top-left/top-right quarter
- J/K: Move window to bottom-left/bottom-right quarter  
- Enter: Maximize window
- P/N: Move window to next/previous screen

## Key Implementation Details

- Uses AXUIElement APIs for window manipulation
- Coordinate system conversion needed between Cocoa and Accessibility coordinates
- Multi-screen support with automatic screen detection based on window center point
- Menu bar only application (no dock icon) with quit functionality