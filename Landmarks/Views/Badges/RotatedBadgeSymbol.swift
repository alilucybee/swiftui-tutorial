//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by Alison Barnett on 20/07/2024.
//

import SwiftUI

// copied from https://developer.apple.com/tutorials/swiftui/drawing-paths-and-shapes
struct RotatedBadgeSymbol: View {
    let angle: Angle

    var body: some View {
        BadgeSymbol()
             .padding(-60)
             .rotationEffect(angle, anchor: .bottom)
    }
}

#Preview {
    RotatedBadgeSymbol(angle: Angle(degrees: 5))
}
