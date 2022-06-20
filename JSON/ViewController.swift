//
//  ViewController.swift
//  JSON
//
//  Created by Vladimir Pisarenko on 20.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    let searchcontroller = UISearchController(searchResultsController: nil)

    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        

    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchcontroller
        searchcontroller.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchcontroller.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponse?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=5"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.request(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let searchResponse):
                    self?.searchResponse = searchResponse
                    self?.table.reloadData()
                case .failure(let error):
                    print("Error:", error)
                }
            }
        })
        
    }
}


