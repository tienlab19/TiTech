//
//  NewItem.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//

import UIKit

class NewItem: UITableViewCell {
    
    @IBOutlet weak var thumnailImage: UIImageView!
    @IBOutlet weak var titleBlog: UILabel!
    @IBOutlet weak var titleTag: UILabel!
    @IBOutlet weak var tagContainerView: UIView!
    @IBOutlet weak var subSource: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.thumnailImage.layer.cornerRadius = 8
        self.thumnailImage.clipsToBounds = true
        self.tagContainerView.backgroundColor = UIColor(named: "primaryColor")
        self.titleTag.textColor = .white
        self.subSource.textColor = UIColor(named: "primaryColor")
        self.tagContainerView.layer.cornerRadius = self.tagContainerView.frame.height / 2
        self.tagContainerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
