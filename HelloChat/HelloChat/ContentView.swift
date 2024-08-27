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
            ScrollViewReader { proxy in
                List(webSocketManager.messages) { message in
                    ChatBubbleView(chatMessage: message)
                        .id(message.id)
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .onChange(of: webSocketManager.messages) {
                    //스크롤 뷰의 마지막 row를 먼저 보여주도록 이동
                    proxy.scrollTo(webSocketManager.messages.last?.id)
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
