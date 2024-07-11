//
//  FilterCell.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var view_Background: UIView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.setSelected(isSelected: self.isSelected)
        }
    }
    
    var title: String? {
        didSet {
            self.setData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.view_Background.layer.cornerRadius = 5
        self.view_Background.clipsToBounds = true
        self.setSelected(isSelected: self.isSelected)
    }
}

extension FilterCell {
    private func setSelected(isSelected: Bool) {
        self.view_Background.backgroundColor = isSelected ? UIColor(named: "mainColor") : .white
        self.lbl_Title.textColor = isSelected ? UIColor.white : UIColor(named: "mainColor")
    }
    
    private func setData() {
        guard let model = self.title else { return }
        self.lbl_Title.text = model
    }
}
