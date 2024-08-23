//
//  ChatBubble.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/22/24.
//

import SwiftUI

struct ChatBubble: View {
    enum BubbleDirection {
        case left
        case right
    }
    
    var chatMessage: ChatMessage
    var profileImageURL: URL?
    var direction: BubbleDirection
    
    init(chatMessage: ChatMessage, profileImageURL: URL? = nil) {
        self.chatMessage = chatMessage
        self.profileImageURL = profileImageURL
        self.direction = chatMessage.role == .me ? .right : .left
    }
    
    var body: some View {
        HStack {
            if direction == .left {
                HStack(alignment: .top) {
                    if let url = profileImageURL {
                        // URL이 있을 경우
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView() // 이미지를 불러오는 동안 표시할 뷰
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    } else {
                        // URL이 없을 경우
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    
                    ZStack(alignment: .topLeading) {
                        Triangle()
                            .fill(Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
                            .cornerRadius(6)
                            .frame(width: 30, height: 30)
                            .rotationEffect(Angle(degrees: 45))
                            .offset(y:-15)
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(chatMessage.message)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                            Text(chatMessage.time)
                                .foregroundColor(Color(UIColor(red: 0.4, green: 0.4, blue: 0.41, alpha: 1)))
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
                        .cornerRadius(6)
                        .frame(maxWidth: 220, alignment: .leading)
                        .padding(.leading, 13)
                    }
                    .padding(.bottom, 20)
                    
                }
                
                
                Spacer()
            } else {
                Spacer()
                
                ZStack(alignment: .topTrailing) {
                    Triangle()
                        .fill(Color(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)))
                        .cornerRadius(6)
                        .frame(width: 30, height: 30)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(y:-15)
                    
                    
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(chatMessage.message)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        Text(chatMessage.time)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)))
                    .cornerRadius(6)
                    .frame(maxWidth: 220, alignment: .trailing)
                    .padding(.trailing, 13)
                    
                    
                }
                .padding(.bottom, 20)
                
            }
        }
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
            ChatBubble(chatMessage: ChatMessage(role: .other, message:  "Hello! How are youggggggggggg?"))
            
            ChatBubble(chatMessage: ChatMessage(role: .me, message:  "I'm good, thank you! And you?gggggggggg"))
            
            ChatBubble(chatMessage: ChatMessage(role: .other, message:  "I'm doing well, thank you!"))
            
            ChatBubble(chatMessage: ChatMessage(role: .me, message:  "😆😜🤪🥳🤩\n😆😜🤪🥳🤩\n😆😜🤪🥳🤩\n😆😜🤪🥳🤩wowwow\n😆😜🤪🥳🤩"))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChatBubbleTestView()
}
