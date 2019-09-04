//
//  ViewController.swift
//  Concurrency Lab
//
//  Created by Michelle Cueva on 9/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countries = [Country]()


    @IBOutlet weak var countryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigurations()
        loadData()
        
    }
    
    private func tableViewConfigurations() {
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.rowHeight = 80
        countryTableView.tableFooterView = UIView()
    }

    func loadData() {
        CountryAPI.shared.fetchDataForAnyURL(url: "https://restcountries.eu/rest/v2/name/united")  { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self.countries = try
                            Country.getDataInfo(data: data)
                        DispatchQueue.main.sync {
                            self.countryTableView.reloadData()
                        }
                    } catch {
                        self.countries = []
                    }
                }
            }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        if let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountriesTableViewCell {
            cell.nameLabel.text = "Name: \(country.name)"
            cell.capitalLabel.text = "Capital: \(country.capital)"
            cell.populationLabel.text = "Population: \(country.population)"
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "countrySegue":
            guard let DetailVC = segue.destination as? DetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = countryTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            
            let country = countries[selectedIndexPath.row]
            
            DetailVC.country = country
        default:
            fatalError("unexpected segue identifies")
        }
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
