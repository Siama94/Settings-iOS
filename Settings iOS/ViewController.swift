//
//  ViewController.swift
//  Settings iOS
//
//  Created by Анастасия on 23.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableView.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.frame = view.bounds
        
        return table
        
    }()
    
    // MARK: - Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Настройки"
    }
}

