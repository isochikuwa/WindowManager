//
//  WindowManagerApp.swift
//  WindowManager
//
//  Created by 竹澤誠敏 on 2025/08/25.
//

import SwiftUI
import HotKey
import Cocoa

@main
struct WindowManagerApp: App {
    @StateObject private var hotKeyManager = HotKeyManager()
    
    var body: some Scene {
        MenuBarExtra("WindowManager", systemImage: "rectangle.3.offgrid") {
            ContentView()
        }
    }
}

class HotKeyManager: ObservableObject {
    var leftHotKey: HotKey?
    var rightHotKey: HotKey?
    var maximizeHotKey: HotKey?
    var topLeftHotKey: HotKey?
    var topRightHotKey: HotKey?
    var bottomLeftHotKey: HotKey?
    var bottomRightHotKey: HotKey?

    init() {
        // Ctrl + Option + 左矢印
        leftHotKey = HotKey(key: .leftArrow, modifiers: [.control, .option])
        leftHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowLeft()
        }
        
        // Ctrl + Option + 右矢印
        rightHotKey = HotKey(key: .rightArrow, modifiers: [.control, .option])
        rightHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowRight()
        }
        
        // Ctrl + Option + U
        topLeftHotKey = HotKey(key: .u, modifiers: [.control, .option])
        topLeftHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowTopLeft()
        }
        
        // Ctrl + Option + I
        topRightHotKey = HotKey(key: .i, modifiers: [.control, .option])
        topRightHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowTopRight()
        }
        
        // Ctrl + Option + J
        bottomLeftHotKey = HotKey(key: .j, modifiers: [.control, .option])
        bottomLeftHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowBottomLeft()
        }
        
        // Ctrl + Option + K
        bottomRightHotKey = HotKey(key: .k, modifiers: [.control, .option])
        bottomRightHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.moveActiveWindowBottomRight()
        }

        // Ctrl + Option + Enter
        maximizeHotKey = HotKey(key: .return, modifiers: [.control, .option])
        maximizeHotKey?.keyDownHandler = {
            print("Global Shortcut Pressed!")
            self.maximizeWindow()
        }

        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        if !accessEnabled {
            print("Access Not Enabled")
        }
    }
    
    func moveActiveWindowLeft() { setWindowPosition(xFactor: 0, yFactor: 0, widthFactor: 0.5, heightFactor: 1) }
    func moveActiveWindowRight() { setWindowPosition(xFactor: 0.5, yFactor: 0, widthFactor: 0.5, heightFactor: 1) }
    func moveActiveWindowTopLeft() { setWindowPosition(xFactor: 0, yFactor: 0, widthFactor: 0.5, heightFactor: 0.5) }
    func moveActiveWindowTopRight() { setWindowPosition(xFactor: 0.5, yFactor: 0, widthFactor: 0.5, heightFactor: 0.5) }
    func moveActiveWindowBottomLeft() { setWindowPosition(xFactor: 0, yFactor: 0.5, widthFactor: 0.5, heightFactor: 0.5) }
    func moveActiveWindowBottomRight() { setWindowPosition(xFactor: 0.5, yFactor: 0.5, widthFactor: 0.5, heightFactor: 0.5) }
    func maximizeWindow() { setWindowPosition(xFactor: 0, yFactor: 0, widthFactor: 1, heightFactor: 1) }


    private func getCurrentWindow() -> AXUIElement? {
        guard let frontApp = NSWorkspace.shared.frontmostApplication else {
            print("No active app")
            return nil
        }
        
        let pid = frontApp.processIdentifier
        let appRef = AXUIElementCreateApplication(pid)
        
        var frontWindow: AnyObject?
        let result = AXUIElementCopyAttributeValue(appRef, kAXFocusedWindowAttribute as CFString, &frontWindow)
        
        return (result == .success) ? (frontWindow as! AXUIElement) : nil
    }
    
    private func getWindowScreen(window: AXUIElement) -> NSScreen? {
        var positionValue: AnyObject?
        var sizeValue: AnyObject?

        let posResult = AXUIElementCopyAttributeValue(window, kAXPositionAttribute as CFString, &positionValue)
        let sizeResult = AXUIElementCopyAttributeValue(window, kAXSizeAttribute as CFString, &sizeValue)

        guard posResult == .success, sizeResult == .success,
              let axPoint = positionValue, let axSize = sizeValue else {
            return NSScreen.main
        }

        var point = CGPoint.zero
        var size = CGSize.zero
        AXValueGetValue(axPoint as! AXValue, .cgPoint, &point)
        AXValueGetValue(axSize as! AXValue, .cgSize, &size)

        // ウィンドウ中心座標を計算
        let center = CGPoint(x: point.x + size.width/2, y: point.y + size.height/2)

        // 複数スクリーンの中で中心があるスクリーンを返す
        for screen in NSScreen.screens {
            print("screen: \(screen)")
            if screen.visibleFrame.contains(center) {
                print("detected: \(screen)")
                return screen
            }
        }

        return NSScreen.main
    }
    
    private func setWindowPosition(xFactor: CGFloat, yFactor: CGFloat, widthFactor: CGFloat, heightFactor: CGFloat) {
        guard let window = getCurrentWindow(), let screen = getWindowScreen(window: window) else {
            return
        }

        let screenFrame = screen.frame
        
        let newWidth = screenFrame.width * widthFactor
        let newHeight = screenFrame.height * heightFactor
        let newX = screenFrame.minX + screenFrame.width * xFactor
        let newY = screenFrame.minY + screenFrame.height * yFactor
        
        var newSize = CGSize(width: newWidth, height: newHeight)
        var newPosition = CGPoint(x: newX, y: newY)

        AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, AXValueCreate(.cgPoint, &newPosition)!)
        AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, AXValueCreate(.cgSize, &newSize)!)
        
        print("Moved window: x=\(newX), y=\(newY), width=\(newWidth), height=\(newHeight) on screen \(screen)")
    }
}
