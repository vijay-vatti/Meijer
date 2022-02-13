//
//  HomeViewController.swift
//  Meijer IOS APP
//
//  Created by Farhadul Fahim on 2/7/22.
//

import Foundation
import UIKit



//ViewController.swift
class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBAction func cartButton(_ sender: Any) {
        
        print("Button press")
        
        self.performSegue(withIdentifier: "cartButtonPage", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
    func setUpNavBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Item..."
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.present(UINavigationController(rootViewController: SearchViewController()), animated: false, completion: nil)
    }
}


class SearchViewController: UIViewController{
    
    var fileteredItems = [Items]()
    let items = Items.GetAllItems()
    
    lazy var tableView: UITableView = {
        let home = UITableView()
        home.translatesAutoresizingMaskIntoConstraints = false
        home.delegate = self
        home.dataSource = self
        home.register(ItemsCell.self, forCellReuseIdentifier: "cell")
        
        return home
    }()
    
    lazy var searchController:  UISearchController = {
        let object = UISearchController(searchResultsController: nil)
        object.searchResultsUpdater = self
        
        object.obscuresBackgroundDuringPresentation = false
        object.searchBar.placeholder = "Search Items..."
        object.searchBar.sizeToFit()
        object.searchBar.searchBarStyle = .prominent
        object.searchBar.barTintColor = .blue
        
        object.searchBar.scopeButtonTitles = ["All", "Grocery", "Household Essentials","Pet Care"]
        
        object.searchBar.delegate = self
        return object
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meijer"
        
        navigationItem.searchController = searchController
        
        
        setupElements()
        
        
    }
    
    func filterItemForSearchText( searchText: String, scope: String = "All" ){
        fileteredItems = items.filter({(item: Items) -> Bool in
            let doesDepartmentMatch = (scope == "All") || (item.department == scope)
            
            if isSearchBarEmpty(){
                return doesDepartmentMatch
            } else{
                return doesDepartmentMatch && item.title.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
}


extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterItemForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterItemForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {return fileteredItems.count}
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemsCell else { return UITableViewCell() }
        
        let currentItem: Items
        
        if isFiltering(){
            currentItem = fileteredItems[indexPath.row]
        }else {
            currentItem = items[indexPath.row]
        }
        
        cell.titleLbl.text = currentItem.title
        cell.categoryLbl.text = currentItem.department
        
        return cell
    }
}


extension SearchViewController {
    
    func setupElements(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
