//
//  ReactionsView.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/26/24.
//

import SwiftUI

struct ReactionsView: View {
    var body: some View {
        HStack {
            ForEach(Array("👍👎😄🔥💕⚠️❓"), id: \.self) { char in
                EmojiButton(emoji: char)
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(.bar)
        }
    }
    
    struct EmojiButton: View {
        let emoji: Character
        @State private var animate = false

        var body: some View {
            Text(String(emoji))
                .font(.largeTitle)
                .scaleEffect(animate ? 1.3 : 1)
                .onTapGesture {
                    print("\(emoji) tapped")
                    withAnimation(.bouncy(duration: 0.2, extraBounce: 0.7)) {
                        animate = true
                    } completion: {
                        withAnimation(.bouncy(duration: 0.05)) {
                            animate = false
                        }
                    }
                }
        }
    }
}

#Preview("ReactionsView") {
    ReactionsView()
}
