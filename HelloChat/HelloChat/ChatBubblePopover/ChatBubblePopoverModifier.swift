//
//  ChatBubblePopoverModifier.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/26/24.
//

import SwiftUI

extension View {
    func chatBubblePopover(chatMessage: Binding<ChatMessage?>, chatBubblePopoverNamespace:Namespace.ID) -> some View {
        self.modifier(ChatBubblePopoverModifier(selectedMessage: chatMessage, chatBubblePopoverNamespace: chatBubblePopoverNamespace))
    }
}

struct ChatBubblePopoverModifier: ViewModifier {
    @Binding var selectedMessage: ChatMessage?
    var chatBubblePopoverNamespace: Namespace.ID
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let selectedMessage {
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture { self.selectedMessage = nil }

                ChatBubblePopoverView(chatMessage: selectedMessage)
                    .matchedGeometryEffect(
                        id: selectedMessage.id,
                        in: chatBubblePopoverNamespace,
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
//        .background(Color.teal.opacity(0.3))
    }
}

struct ChatBubblePopoverModifierTestView: View {
    @State private var selectedMessage: ChatMessage?
    @Namespace private var chatBubblePopoverNamespace
    
    private let demoMessages: [ChatMessage] = [
        ChatMessage(role: .me, message: "Once upon a time"),
        ChatMessage(role: .other, message: "the quick brown fox jumps over the lazy dog"),
        ChatMessage(role: .me, message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        ChatMessage(role: .other, message: "and they all lived happily ever after."),
    ]
    
    var body: some View {
        VStack {
            List(demoMessages) { message in
                ChatBubbleView(chatMessage: message)
                    .id(message.id)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .matchedGeometryEffect(
                        id: message.id,
                        in: chatBubblePopoverNamespace,
                        anchor: message.role == .me ? .topTrailing : .topLeading,
                        isSource: true
                    )
                    .onLongPressGesture {
                        selectedMessage = message
                    }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .chatBubblePopover(chatMessage: $selectedMessage, chatBubblePopoverNamespace: chatBubblePopoverNamespace)
    }
}


#Preview {
    ChatBubblePopoverModifierTestView()
}
