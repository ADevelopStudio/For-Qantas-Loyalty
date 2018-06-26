//
//  Cells.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit


class CellWithImage: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: LoadingImageView!
    
    override func awakeFromNib() {
        setCorner()
    }
    func fillWith(recipe: Recipe)  {
        self.title.text = recipe.title.withoutWhiteCrap
        self.imageView.fillWith(recipe.thumbnail)
    }
}

class CellWithoutImage: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        setCorner()
    }
    
    func fillWith(recipe: Recipe)  {
        self.title.text = recipe.title.withoutWhiteCrap
    }
}

