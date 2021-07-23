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
        table.register(StandardTableViewCell.self, forCellReuseIdentifier: StandardTableViewCell.indentifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.indentifier)
        table.delegate = self
        table.dataSource = self
        table.frame = view.bounds
        
        return table
        
    }()
    
    var models = [Sections]()
    
    // MARK: - Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case.standardCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: StandardTableViewCell.indentifier,
                for: indexPath
            ) as? StandardTableViewCell else {
                return UITableViewCell()
                }
            
            cell.configure(with: model)
            return cell
            
        case.switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.indentifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
                }
            
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case.standardCell(let model):
            model.handler()
        case.switchCell(let model):
            model.handler()
        }
    }
    
    // MARK: - Configure cell
    
    func configure() {
      
        models.append(Sections(options: [
            .switchCell(model: SettingSwitchOptions(
                            title: "Авиарежим",
                            icon: UIImage(systemName: "airplane"),
                            iconBackgroundColor: .systemOrange,
                            handler: {print("Нажата ячейка Авиарежим")},
                            isOn: true)),
            
            .standardCell(model:  SettingStandardOption(
                            title: "Сотовая связь",
                            icon: UIImage(systemName: "antenna.radiowaves.left.and.right"),
                            iconBackgroundColor: .systemGreen,
                            handler: {print("Нажата ячейка Сотовая связь")})),
        ]))
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.addSubview(tableView)
        self.title = "Настройки"
    }
}

    // MARK: - Type of cell

struct Sections {
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case standardCell(model: SettingStandardOption)
    case switchCell(model: SettingSwitchOptions)
    
}

struct SettingStandardOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct SettingSwitchOptions {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}
