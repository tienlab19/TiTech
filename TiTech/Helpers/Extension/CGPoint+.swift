//
//  CGPoint+.swift
//  VFTeKYC
//
//  Created by Thành HM on 28/02/2023.
//

import Foundation
import UIKit

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
