//
//  ContentView.swift
//  WindowManager
//
//  Created by 竹澤誠敏 on 2025/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Press Command+Option+LeftArrow to move window left")
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
    }
}
