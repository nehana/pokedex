//
//  ListCell.swift
//  Pokedex
//
//  Created by Neha on 2/12/19.
//  Copyright © 2019 Neha. All rights reserved.
//

import Foundation
import UIKit

protocol ListCellDelegate {
    func listButton(forCell: ListCell)
}

class ListCell: UITableViewCell {
    
    var img: UIImageView!
    var pLabel: UILabel!
    var delegate: ListCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img = UIImageView(frame: CGRect(x: 0, y: 5, width: 100, height: 60))
        pLabel = UILabel(frame: CGRect(x: 120, y: contentView.frame.midY - 10, width: contentView.frame.width - 10, height: 20))
        img.contentMode = .scaleAspectFit
        contentView.addSubview(pLabel)
        contentView.addSubview(img)
    }
    
}

