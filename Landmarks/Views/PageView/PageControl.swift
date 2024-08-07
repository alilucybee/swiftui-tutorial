//
//  PageControl.swift
//  Landmarks
//
//  Created by Alison Barnett on 21/07/2024.
//

import SwiftUI

// UIViewRepresentable and UIViewControllerRepresentable types have the same life cycle
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl


       init(_ control: PageControl) {
           self.control = control
       }

        // Because UIControl subclasses like UIPageControl use the target-action pattern instead of delegation, this Coordinator implements an @objc method to update the current page binding
       @objc
       func updateCurrentPage(sender: UIPageControl) {
           control.currentPage = sender.currentPage
       }
   }
}
