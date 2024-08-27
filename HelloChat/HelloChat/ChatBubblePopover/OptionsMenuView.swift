//
//  OptionsMenuView.swift
//  HelloChat
//
//  Created by KIM MIMI on 8/26/24.
//

import SwiftUI

struct OptionsMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                print("Copy tapped")
            } label: {
                optionLabel(label: "Copy", imageName: "doc.on.doc.fill")
            }
            Divider()
            Button {
                print("Reply tapped")
            } label: {
                optionLabel(label: "Reply", imageName: "arrowshape.turn.up.left.fill")
            }
            Divider()
            Button {
                print("Unsend tapped")
            } label: {
                optionLabel(label: "Unsend", imageName: "location.slash.circle.fill")
            }
        }
        .buttonStyle(.plain)
        .frame(width: 220)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.bar)
        }
    }
    
    private func optionLabel(label: String, imageName: String) -> some View {
        HStack(spacing: 0) {
            Text(label)
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

#Preview {
    OptionsMenuView()
}
