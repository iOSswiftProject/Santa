//
//  extensionFile.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/25.
//

import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
