//
//  UIView+.swift
//  VFTeKYC
//
//  Created by Thành HM on 27/02/2023.
//

import Foundation
import UIKit

extension UIView {
    func layerGradient(startPoint:CAGradientPoint, endPoint:CAGradientPoint ,colorArray:[CGColor], type:CAGradientLayerType ) {
        let gradient = CAGradientLayer(start: .topLeft, end: .topRight, colors: colorArray, type: type)
        gradient.frame.size = self.frame.size
        self.layer.insertSublayer(gradient, at: 0)
    }
}
