//
//  Theme.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/28/20.
//

import Foundation
import SwiftUI


struct Theme {
    
    static let attributes = [NSAttributedString.Key.foregroundColor: color]
    
    static var closeButton: UIBarButtonItem {
        let image = UIImage(systemName: "xmark")
        let button = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        button.tintColor = Theme.color
        
        return button
    }
    
    static let color = UIColor.systemTeal
    
    static let separator = " · "
}
