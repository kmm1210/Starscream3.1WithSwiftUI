//
//  ChatBubblePopoverDemo.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/26/24.
//

import SwiftUI

struct ChatBubblePopoverDemo: View {
    @State private var selectedMessage: ChatMessage?
    @Namespace private var nsPopover
    
    private let demoMessages: [ChatMessage] = [
        ChatMessage(role: .me, message: "Once upon a time"),
        ChatMessage(role: .other, message: "the quick brown fox jumps over the lazy dog"),
        ChatMessage(role: .me, message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        ChatMessage(role: .other, message: "and they all lived happily ever after."),
    ]
    
    @ViewBuilder
    private var messageView: some View {
        if let selectedMessage {
            ChatBubbleView(chatMessage: selectedMessage)
                .allowsHitTesting(false)
        }
    }

    private var customPopover: some View {
        return VStack(alignment: selectedMessage?.role == .me ? .trailing : .leading) {
            ReactionsView()
            messageView
            OptionsMenuView()
        }
        .padding(.top, -70)
    }

    var body: some View {
        ZStack {
            List(demoMessages) { message in
                ChatBubbleView(chatMessage: message)
                    .id(message.id)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .matchedGeometryEffect(
                        id: message.id,
                        in: nsPopover,
                        anchor: message.role == .me ? .topTrailing : .topLeading,
                        isSource: true
                    )
                    .onLongPressGesture {
                        selectedMessage = message
                    }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
//            .blur(radius: selectedMessage == nil ? 0 : 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let selectedMessage {
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture { self.selectedMessage = nil }

                customPopover
                    .matchedGeometryEffect(
                        id: selectedMessage.id,
                        in: nsPopover,
                        properties: .position,
                        anchor: selectedMessage.role == .me ? .topTrailing : .topLeading,
                        isSource: false
                    )
                    .transition(
                        .opacity.combined(with: .scale)
                        .animation(.bouncy(duration: 0.25, extraBounce: 0.2))
                    )
            }
            
        }
        .animation(.easeInOut(duration: 0.25), value: selectedMessage)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.teal.opacity(0.3))
    }
}

#Preview {
    ChatBubblePopoverDemo()
}
