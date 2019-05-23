//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Stoffer on 5/22/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - @IBOutlets and Variables
    @IBOutlet var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            self.filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("There was an error loading recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    // MARK: - @IBActions and Methods
    @IBAction func searchRecipes(_ sender: UITextField) {
        self.searchTextField.resignFirstResponder()
        self.filterRecipes()
    }
    
    private func filterRecipes() {
        guard let searchText = self.searchTextField.text else { return }
        
        if searchText.isEmpty {
            self.filteredRecipes = self.allRecipes
        } else {
            self.filteredRecipes = self.allRecipes.filter({ $0.name.contains(searchText) || $0.instructions.contains(searchText) })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeListEmbedSegue" {
            self.recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
