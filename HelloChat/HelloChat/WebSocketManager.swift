//
//  WebSocketManager.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/20/24.
//

import Foundation
import Starscream

class WebSocketManager: ObservableObject {
    private var socket: WebSocket!
//        private let serverUrl = "wss://echo.websocket.org" // 예제용 에코 서버
    private let serverUrl = "ws://localhost:8080" // 예제용 로컬 서버
    
    
    @Published var isConnected = false
    @Published var messages: [ChatMessage] = []
    
    init() {
        var request = URLRequest(url: URL(string: serverUrl)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(_ message: String) {
        socket.write(string: message)
        messages.append(ChatMessage(role: .me, message: message))
        
    }
}

extension WebSocketManager: WebSocketDelegate {
    func websocketDidConnect(socket: any Starscream.WebSocketClient) {
        isConnected = true
        print("WebSocket is connected: \(socket)")
    }
    
    func websocketDidDisconnect(socket: any Starscream.WebSocketClient, error: (any Error)?) {
        print("WebSocket is disconnected: \(socket) with code: \(error.debugDescription)")
        isConnected = false
        handleError(error)
    }
    
    func websocketDidReceiveMessage(socket: any Starscream.WebSocketClient, text: String) {
        print("Received text: \(text)")
        messages.append(ChatMessage(role: .other, message: text))
    }
    
    func websocketDidReceiveData(socket: any Starscream.WebSocketClient, data: Data) {
        print("Received data: \(data)")
        print("Received data: \(data.count)")
        if let string = String(data: data, encoding: .utf8) {
            print("Received data string: \(string)")
            messages.append(ChatMessage(role: .other, message: string))
        } else {
            print("Failed to convert Data to String.")
        }
    }

    private func handleError(_ error: Error?) {
        if let error = error {
            print("WebSocket encountered an error: \(error)")
        } else {
            print("WebSocket encountered an unknown error")
        }
    }
}
