//
//  GridCell.swift
//  Pokedex
//
//  Created by Neha on 2/12/19.
//  Copyright © 2019 Neha. All rights reserved.
//

import Foundation
import UIKit

protocol GridCellDelegate {
    func gridButton(forCell: GridCell)
}

class GridCell: UICollectionViewCell {
    
    var img: UIImageView!
    var pLabel: UILabel!
    var delegate: GridCellDelegate? = nil
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        pLabel = UILabel(frame: CGRect(x: 10, y: contentView.frame.maxY - 10, width: contentView.frame.width - 10, height: 20))
        img = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: contentView.frame.height - 30))
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        contentView.addSubview(pLabel)
        contentView.addSubview(img)
    }
    
}

