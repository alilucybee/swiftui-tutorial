//
//  FavouriteButton.swift
//  Landmarks
//
//  Created by Alison Barnett on 20/07/2024.
//

import SwiftUI

struct FavouriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
            
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .purple : .gray)
        }
    }
}

#Preview {
    FavouriteButton(isSet: .constant(true))
}
