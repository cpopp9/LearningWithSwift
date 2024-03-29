//
//  ViewControllerWrapper.swift
//  UIKit-SwiftUI-Wrapper
//
//  Created by Cory Popp on 3/29/24.
//

import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    @Binding var title: String
    @Binding var description: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ViewControllerDelegate {
        
        private var parent: ViewControllerWrapper
        
        init(_ parent: ViewControllerWrapper) {
            self.parent = parent
        }
        
        func didChangeValues(title: String, description: String) {
            self.parent.title = title
            self.parent.description = description
        }
        
    }
    
}

protocol ViewControllerDelegate: AnyObject {
    func didChangeValues(title: String, description: String)
}
