//
//  CarrerBlog.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import UIKit

class CarrerBlog: UITableViewCell {
    
    @IBOutlet weak var thumnailImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var brandedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.thumnailImage.layer.cornerRadius = 4
        self.thumnailImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
