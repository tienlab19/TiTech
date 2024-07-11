//
//  LoadingView.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import Foundation
import UIKit

class LoadingView: UIView {

    private var activityIndicator: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator?.center = self.center
        self.activityIndicator?.color = .white
        self.activityIndicator?.startAnimating()
        if let activityIndicator = self.activityIndicator {
            self.addSubview(activityIndicator)
        }
    }
    
    func show(on view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        self.activityIndicator?.center = self.center // Make sure the indicator is centered
    }

    func hide() {
        self.removeFromSuperview()
    }
}
