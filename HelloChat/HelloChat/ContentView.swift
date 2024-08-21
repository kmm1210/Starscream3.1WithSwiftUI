//
//  ContentView.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    @State private var inputMessage: String = ""
    
    var body: some View {
        VStack {
            HStack() {
                Text(webSocketManager.isConnected ? "연결되었습니다." : "연결이 끊겼습니다.")
                if !webSocketManager.isConnected {
                    Button(action: {
                        webSocketManager.connect()
                    }) {
                        Text("connect")
                            .padding(5)
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            
            List {
                ForEach(webSocketManager.messages, id: \.self) { message in
                    Text(message)
                }
            }
            
            HStack {
                TextField("Enter your message", text: $inputMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if !inputMessage.isEmpty {
                        webSocketManager.sendMessage(inputMessage)
                        inputMessage = ""
                    }
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!webSocketManager.isConnected)
                .padding()
            }
        }
        .onAppear {
            webSocketManager.connect()
        }
        .onDisappear {
            webSocketManager.disconnect()
        }
    }
}


#Preview {
    ContentView()
}
