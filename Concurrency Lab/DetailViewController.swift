//
//  DetailViewController.swift
//  Concurrency Lab
//
//  Created by Michelle Cueva on 9/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    var country: Country!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
    }
    

}
