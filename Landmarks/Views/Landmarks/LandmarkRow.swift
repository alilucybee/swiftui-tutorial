//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Alison Barnett on 19/07/2024.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            
            Spacer()
            
            if landmark.isFavourite {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }

        }
    }
}


#Preview {
    let landmarks = ModelData().landmarks
    return Group{
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
}
