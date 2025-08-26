//
//  ContentView.swift
//  WindowManager
//
//  Created by 竹澤誠敏 on 2025/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("WindowManager Shortcuts")
                .font(.headline)
                .padding(.bottom, 4)
            
            Group {
                Text("Ctrl+Opt+← : Move left half")
                Text("Ctrl+Opt+→ : Move right half")
                Text("Ctrl+Opt+Enter : Maximize")
                Text("Ctrl+Opt+U : Top-left quarter")
                Text("Ctrl+Opt+I : Top-right quarter")
                Text("Ctrl+Opt+J : Bottom-left quarter")
                Text("Ctrl+Opt+K : Bottom-right quarter")
                Text("Ctrl+Opt+P : Next screen")
                Text("Ctrl+Opt+N : Previous screen")
            }
            .font(.system(size: 11, family: .monospaced))
            .foregroundColor(.secondary)
            
            Divider()
                .padding(.vertical, 4)
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 220)
    }
}
