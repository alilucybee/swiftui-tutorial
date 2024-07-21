//
//  PageViewController.swift
//  Landmarks
//
//  Created by Alison Barnett on 21/07/2024.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {

    var pages: [Page]
    // PageViewController updates the binding to match the visible page
    @Binding var currentPage: Int
    
    // call first so can access coordinator object when configuring view controller
    // You can use this coordinator to implement common Cocoa patterns, such as delegates, data sources, and responding to user events via target-action.
    // TODO read https://developer.apple.com/documentation/swift/cocoa-design-patterns
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // SwiftUI calls this method a single time when it’s ready to display the view, and then manages the view controller’s life cycle.
    func makeUIViewController(context: Context) -> UIPageViewController {
         let pageViewController = UIPageViewController(
             transitionStyle: .scroll,
             navigationOrientation: .horizontal)
         pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

         return pageViewController
     }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    // SwiftUI view that represents a UIKit view controller can define a Coordinator type that SwiftUI manages and provides as part of the representable view’s context.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
         var parent: PageViewController
        var controllers = [UIViewController]()

        // Initialize an array of controllers in the coordinator using the pages array of views.
        // The coordinator is a good place to store these controllers, because the system initializes them only once, and before you need them to update the view controller.
         init(_ pageViewController: PageViewController) {
             parent = pageViewController
             controllers = parent.pages.map { UIHostingController(rootView: $0) }
         }
        
        //  UIPageViewControllerDataSource required methods, which establish the relationships between view controllers, so that you can swipe back and forth between them.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }

            return controllers[index + 1]
        }
        
        // UIPageViewControllerDelegate conformance
        // SwiftUI calls this method whenever a page switching animation completes, so you can find the index of the current view controller and update the binding.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {

            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
     }
}
