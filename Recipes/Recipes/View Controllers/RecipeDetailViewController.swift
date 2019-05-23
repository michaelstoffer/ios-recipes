//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Michael Stoffer on 5/22/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - @IBOutlets and Variabels
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeInstructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    // MARK: - @IBActions and Methods
    private func updateViews() {
        if isViewLoaded {
            self.recipeNameLabel.text = recipe?.name
            self.recipeInstructionsTextView.text = recipe?.instructions
        }
    }
}
