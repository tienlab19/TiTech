//
//  UITableView.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType _ : T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UITableViewCell>(ofType _ : T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderNib<T: UITableViewHeaderFooterView>(ofType _ : T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func registerFooterNib<T: UITableViewHeaderFooterView>(ofType _ : T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderClass<T: UITableViewHeaderFooterView>(ofType _ : T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UITableViewCell>(ofType _ : T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
    
    func dequeueHeaderView<T: UITableViewHeaderFooterView>(ofType: T.Type) -> T {
        guard let headerView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not dequeue Header view with identifier: \(String(describing: T.self))")
        }
        return headerView
    }
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollToTop(animated: Bool) {
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            let desiredOffset = CGPoint(x: 0, y: -self.contentInset.top)
            self.setContentOffset(desiredOffset, animated: animated)
        }, completion: nil)
    }
}

extension UITableView {
    func scroll(to: ScrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to {
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }
    
    enum ScrollsTo {
        case top, bottom
    }
}

extension UITableView {
    func reloadDataWithCompletion(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: reloadData) { _ in completion() }
    }
}

extension UITableView {
    /// Reloads a table view without losing track of what was selected.
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows

        reloadData()

        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}

// MARK: Table Header
extension UITableView {
    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView?) {
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        
        // Set first.
        self.tableHeaderView = headerView
        
        // Then setup AutoLayout.
        headerView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    /// Update header view's frame.
    func updateFrameHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        
        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        
        // ***Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
}

extension UITableView {
    func createImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: contentSize.width, height: contentSize.height), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let previousFrame = frame
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: contentSize.width, height: contentSize.height)
        layer.render(in: context!)
        frame = previousFrame
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func renderScrollViewToImage() -> UIImage? {
        var image: UIImage?

        UIGraphicsBeginImageContext(self.contentSize)
        do {
            let savedContentOffset = self.contentOffset
            let savedFrame = self.frame

            self.contentOffset = CGPoint.zero
            self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)

            if let context = UIGraphicsGetCurrentContext() {
                self.layer.render(in: context)
            }
            image = UIGraphicsGetImageFromCurrentImageContext()

            self.contentOffset = savedContentOffset
            self.frame = savedFrame
        }
        UIGraphicsEndImageContext()

        return image
    }
    
    func screenshot() -> UIImage? {
        let savedContentOffset = contentOffset
        let savedFrame = frame
        defer {
            contentOffset = savedContentOffset
            frame = savedFrame
        }
        
        contentOffset = .zero
        frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        
        let image = UIGraphicsImageRenderer(bounds: CGRect(origin: .zero, size: contentSize)).image { renderer in
            let context = renderer.cgContext
            layer.render(in: context)
        }
        
        return image
    }
    
}
