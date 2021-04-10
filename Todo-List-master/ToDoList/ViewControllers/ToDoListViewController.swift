//
//  ViewController.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UIViewController {
    
    var realm = try! Realm()
    var toDoList = [ListItem]()
    var searchTodoList = [ListItem]()
    var searching = false
    
    var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    var activityIndicatorView : UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = arrangeList()
        
        
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    func setup() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        title = "Todo List"
        self.navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.setTitle("Add", for: .normal)
        button.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(addButtonAction(sender:)), for: .touchUpInside)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.style = .large
        activityIndicatorView.size(width: 50, height: 50)
        activityIndicatorView.center = view.center
        
        view.addSubview(searchBar)
        searchBar.edges([.left,.right,.top], to: view.safeAreaLayoutGuide, offset: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: -10))
        searchBar.layer.masksToBounds = false
        searchBar.barTintColor = .yellow
        searchBar.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        searchBar.tintColor = .blue
        searchBar.showsCancelButton = true
        searchBar.placeholder = " "
        searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        tableView.edges([.left,.right,.bottom], to: view, offset: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: -10))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
    }
    
    @objc func addButtonAction(sender: UIButton) {
        let addVC = AddTodoViewController()
        addVC.completionHandler = {
            self.refresh()
        }
        let navAddVC = UINavigationController(rootViewController: addVC)
        navAddVC.modalPresentationStyle = .fullScreen
        self.present(navAddVC, animated: true, completion: nil)
        
    }
    
    func refresh() {
        
        var uncheckedList = [ListItem]()
        var checkedList = [ListItem]()
        let allList = realm.objects(ListItem.self).map({$0})
        for item in allList {
            if item.toDoisChecked == false{
                uncheckedList.append(item)
            } else {
                checkedList.append(item)
            }
        }
        
        toDoList = uncheckedList + checkedList
        tableView.reloadData()
    }
    
    func arrangeList()-> [ListItem] {
        
        var uncheckedList = [ListItem]()
        var checkedList = [ListItem]()
        let allList = realm.objects(ListItem.self).map({$0})
        for item in allList {
            if item.toDoisChecked == false{
                uncheckedList.append(item)
            } else {
                checkedList.append(item)
            }
        }
        
        return uncheckedList + checkedList
    }
    
    @objc func checkTheBox(_ sender: UIButton) {
        if !searching {
            let index = sender.tag
            let duplicateItem = ListItem()
            duplicateItem.title = toDoList[index].title
            duplicateItem.todoDescription = toDoList[index].todoDescription
            duplicateItem.imageName = toDoList[index].imageName
            duplicateItem.toDoisChecked = !toDoList[index].toDoisChecked
            
            realm.beginWrite()
            realm.delete(toDoList[index])
            realm.add(duplicateItem)
            try! realm.commitWrite()
            self.refresh()
        }
        else {
            let alert = UIAlertController(title: "ALERT!", message: "Can't edit while searching!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }
        
    }
    


}

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchTodoList.count : toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        var imageName = ""
        var checkImage = UIImage()
        cell.tag = indexPath.row
        
        if searching {
            cell.titleLabel.text = searchTodoList[indexPath.row].title
            cell.descriptionLabel.text = searchTodoList[indexPath.row].todoDescription
            imageName = searchTodoList[indexPath.row].imageName
            checkImage = (searchTodoList[indexPath.row].toDoisChecked ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle"))!
            
        } else {
            cell.titleLabel.text = toDoList[indexPath.row].title
            cell.descriptionLabel.text = toDoList[indexPath.row].todoDescription
            imageName = toDoList[indexPath.row].imageName
            checkImage = (toDoList[indexPath.row].toDoisChecked ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle"))!
            cell.checkButton.tag = indexPath.row
            cell.checkButton.addTarget(self, action: #selector(checkTheBox(_:)), for: .touchUpInside)
        }
        
        cell.checkButton.setBackgroundImage(checkImage, for: .normal)
        
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            cell.myImageView.image = UIImage(contentsOfFile: imagePath)
        }else{
           print("No Image!")
        }
        
        
        return cell
        
    }
    
    
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ToDoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTodoList = toDoList.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
}
