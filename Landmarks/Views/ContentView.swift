//
//  ContentView.swift
//  Landmarks
//
//  Created by Alison Barnett on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }

}

#Preview {
    ContentView()
        .environment(ModelData())
}
