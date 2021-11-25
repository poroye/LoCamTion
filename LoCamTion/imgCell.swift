//
//  imgCell.swift
//  LoCamTion
//
//  Created by ธนัท แสงเพิ่ม on 25/11/2564 BE.
//

import UIKit

class imgCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    func configure(with image: UIImage){
        img.image = image
    }
    
}
