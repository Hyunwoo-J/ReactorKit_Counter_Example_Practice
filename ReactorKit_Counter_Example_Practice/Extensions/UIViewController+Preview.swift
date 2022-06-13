//
//  UIViewController+Preview.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/06/12.
//

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI


extension UIViewController {
  @available(iOS 13, *)
  private struct Preview: UIViewControllerRepresentable {
    let viewController: UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
      return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
  }
  
  @available(iOS 13, *)
  func showPreview() -> some View {
    Preview(viewController: self)
  }
}
#endif
