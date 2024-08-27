//
//  ChatBubbleView.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/22/24.
//

import SwiftUI

struct ChatBubbleView: View {
    enum BubbleDirection {
        case left
        case right
    }
    
    var chatMessage: ChatMessage
    var profileImageURL: URL?
    var direction: BubbleDirection
    var bubbleConfig: (alignment:Alignment,
                         backgroundColor: Color,
                         textColor: Color,
                         textAlignment: Alignment,
                         textPaddingEdge: Edge.Set)
    
    init(chatMessage: ChatMessage, profileImageURL: URL? = nil) {
        self.chatMessage = chatMessage
        self.profileImageURL = profileImageURL
        //        setUI()
        if chatMessage.role == .me {
            self.direction = .right
            self.bubbleConfig = (alignment: .topTrailing,
                                 backgroundColor: Color(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)),
                                 textColor: .white,
                                 textAlignment: .trailing,
                                 textPaddingEdge: .trailing)
        } else {
            self.direction = .left
            self.bubbleConfig = (alignment: .topLeading,
                                 backgroundColor: Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)),
                                 textColor: Color(UIColor(red: 0.4, green: 0.4, blue: 0.41, alpha: 1)),
                                 textAlignment: .leading,
                                 textPaddingEdge: .leading)
        }
    }
    
    var body: some View {
        HStack {
            if direction == .left {
                HStack(alignment: .top) {
                    profileImage
                    bubbleView
                }
                
                Spacer()
            } else {
                Spacer()
                
                bubbleView
            }
        }
    }
    
    private var profileImage: some View {
        Group {
            if let url = profileImageURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView() // 이미지를 불러오는 동안 표시할 뷰
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    }
    
    private var bubbleView: some View {
        ZStack(alignment: bubbleConfig.alignment) {
            Triangle()
                .fill(bubbleConfig.backgroundColor)
                .cornerRadius(6)
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: 45))
                .offset(y:-15)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(chatMessage.message)
                    .allowsHitTesting(false)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(bubbleConfig.textColor)
                Text(chatMessage.time)
                    .allowsHitTesting(false)
                    .font(.system(size: 12))
                    .foregroundColor(bubbleConfig.textColor)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(bubbleConfig.backgroundColor)
            .cornerRadius(6)
            .frame(maxWidth: 220, alignment: bubbleConfig.textAlignment)
            .padding(bubbleConfig.textPaddingEdge, 13)
        }
        .padding(.bottom, 20)
    }
    
    
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct ChatBubbleTestView: View {
    var body: some View {
        VStack {
            ChatBubbleView(chatMessage: ChatMessage(role: .other, message:  "Hello! How are youggggggggggg?"))
            
            ChatBubbleView(chatMessage: ChatMessage(role: .me, message:  "I'm good, thank you! And you?gggggggggg"))
            
            ChatBubbleView(chatMessage: ChatMessage(role: .other, message:  "I'm doing well, thank you!"))
            
            ChatBubbleView(chatMessage: ChatMessage(role: .me, message:  "😆😜🤪🥳🤩\n😆😜🤪🥳🤩\n😆😜🤪🥳🤩\n😆😜🤪🥳🤩wowwow\n😆😜🤪🥳🤩"))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChatBubbleTestView()
}
