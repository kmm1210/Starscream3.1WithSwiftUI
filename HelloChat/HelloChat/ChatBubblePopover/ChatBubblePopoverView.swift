//
//  ChatBubblePopoverView.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/26/24.
//

import SwiftUI

struct ChatBubblePopoverView: View {
    @State var chatMessage: ChatMessage?
    var bodyAlignment: HorizontalAlignment {
        if let selectedMessage = chatMessage {
            return selectedMessage.role == .me ? .trailing : .leading
        }
        return .leading
    }
    
    var body: some View {
        VStack(alignment: bodyAlignment) {
           ReactionsView()
            if let chatMessage {
                ChatBubbleView(chatMessage: chatMessage)
                    .allowsHitTesting(false)
            }
           OptionsMenuView()
       }
       .padding(.top, -70)
    }
}

#Preview {
    ChatBubblePopoverView()
}
