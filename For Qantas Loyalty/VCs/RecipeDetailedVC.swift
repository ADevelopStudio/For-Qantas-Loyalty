//
//  RecipeDetailedVC.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension RecipeDetailedVC: UIViewControllerTransitioningDelegate {
    //to use default modal presentation instead of push
}

class RecipeDetailedVC : UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var componentsLbl: UILabel!
    @IBOutlet weak var linkLbl: UILabel!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        if let recipe = recipe {
            self.fill(with: recipe)
        }
        linkLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openLink)))
    }
    
    func fill(with recipe: Recipe) {
        titleLbl.text = recipe.title.withoutWhiteCrap
        componentsLbl.text = recipe.ingredients.withoutWhiteCrap.split(separator: ",").map({" • \(String($0).withoutWhiteCrap)"}).joined(separator: "\n")

        let linklabelAtributes:[NSAttributedStringKey : Any]  = [
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.underlineColor: UIColor.blue
        ]
        linkLbl.attributedText = NSAttributedString(string: recipe.href, attributes: linklabelAtributes)
        
        var imageLoader =  ImageLoader()
        imageLoader.downloadImageFrom(urlString: recipe.thumbnail) {self.backgroundImage.image = $0}
    }
    
    @objc func openLink()  {
        guard let url = recipe?.hrefUrl else {return}
        UIApplication.shared.tapFeedback()
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.transitioningDelegate = self
        present(safariViewController, animated: true)
    }
}
