# WindowManager

A lightweight macOS window management utility that provides global keyboard shortcuts for quickly positioning and resizing windows. Built with SwiftUI, WindowManager runs as a menu bar application to stay out of your way while providing powerful window control.

## Features

- **Global Hotkeys**: Control windows from any application
- **Multi-Screen Support**: Automatically detects and works across multiple displays
- **Menu Bar Interface**: Minimal UI that doesn't clutter your desktop
- **Instant Window Positioning**: Snap windows to predefined positions with a single keystroke

## Keyboard Shortcuts

All shortcuts use **Ctrl + Option** as the modifier keys:

### Window Positioning
- **← (Left Arrow)**: Move window to left half of screen
- **→ (Right Arrow)**: Move window to right half of screen
- **Enter**: Maximize window to full screen

### Quarter Screen Positioning
- **U**: Move window to top-left quarter
- **I**: Move window to top-right quarter  
- **J**: Move window to bottom-left quarter
- **K**: Move window to bottom-right quarter

### Multi-Screen Navigation
- **P**: Move window to previous screen
- **N**: Move window to next screen

## Requirements

- macOS 14.6 or later
- Accessibility permissions (automatically requested on first launch)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd WindowManager
   ```

2. Open the project in Xcode:
   ```bash
   open WindowManager.xcodeproj
   ```

3. Build and run the application (⌘ + R)

## Setup

When you first launch WindowManager, it will request Accessibility permissions. These permissions are required for the app to control windows of other applications.

1. Go to **System Preferences** → **Security & Privacy** → **Privacy** → **Accessibility**
2. Click the lock icon to make changes
3. Add WindowManager to the list of allowed applications
4. Restart WindowManager

## Usage

Once running, WindowManager will appear in your menu bar with a window grid icon. Use the keyboard shortcuts to position your active window instantly. The app remembers which screen each window is on and can move windows between multiple displays.

## Building from Source

### Prerequisites
- Xcode 16.0 or later
- Swift 5.0 or later

### Build Commands
```bash
# Build the project
xcodebuild -project WindowManager.xcodeproj -scheme WindowManager build

# Run tests
xcodebuild -project WindowManager.xcodeproj -scheme WindowManagerTests test

# Create archive
xcodebuild -project WindowManager.xcodeproj -scheme WindowManager archive
```

## Dependencies

- [HotKey](https://github.com/soffes/HotKey): Swift package for global hotkey registration

## License

MIT License

---

*This README was generated with [Claude Code](https://claude.ai/code)*