//
//  ViewController.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    var recipes: (withimages: [Recipe], withoutimages: [Recipe]) = ([],[])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        ConnectionManager.getRecipes { allRecipes, errorMessage in
            self.recipes = (allRecipes.filter({!$0.thumbnail.isEmpty}),allRecipes.filter({$0.thumbnail.isEmpty}))
            self.collection.reloadData()
            if !errorMessage.isEmpty {
                self.showError(errorMessage)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDetailedVC, let recipe = sender as? Recipe {
            destinationVC.recipe = recipe
        }
    }
}

