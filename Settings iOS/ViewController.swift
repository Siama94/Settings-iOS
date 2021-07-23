//
//  ViewController.swift
//  Settings iOS
//
//  Created by Анастасия on 23.07.2021.
//

import UIKit

// MARK: - Type of cell

struct Sections {
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case standardCell(model: SettingStandardOption)
    case switchCell(model: SettingSwitchOptions)
    case labelCell(model: SettingLabelOptions)
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

struct SettingLabelOptions {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var label: String
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(StandardTableViewCell.self, forCellReuseIdentifier: StandardTableViewCell.indentifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.indentifier)
        table.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.indentifier)
        
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
            
        case.labelCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LabelTableViewCell.indentifier,
                for: indexPath
            ) as? LabelTableViewCell else {
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
        case.labelCell(let model):
            model.handler()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.addSubview(tableView)
        self.title = "Настройки"
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
            .labelCell(model: SettingLabelOptions(
                        title: "Wi-Fi",
                        icon: UIImage(systemName: "wifi"),
                        iconBackgroundColor: .systemBlue,
                        label: "Не подключено",
                        handler: {print("Нажата ячейка Wi-Fi")})),
            
            .labelCell(model: SettingLabelOptions(
                        title: "Bluetooth",
                        icon: UIImage(named: "блютуз"),
                        iconBackgroundColor: .systemBlue,
                        label: "Вкл.",
                        handler: {print("Нажата ячейка Bluetooth")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Сотовая связь",
                            icon: UIImage(systemName: "antenna.radiowaves.left.and.right"),
                            iconBackgroundColor: .systemGreen,
                            handler: {print("Нажата ячейка Сотовая связь")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Режим модема",
                            icon: UIImage(systemName: "personalhotspot"),
                            iconBackgroundColor: .systemGreen,
                            handler: {print("Нажата ячейка Режим модема")})),
            
            .switchCell(model: SettingSwitchOptions(
                            title: "VPN",
                            icon: UIImage(systemName: "globe"),
                            iconBackgroundColor: .systemBlue,
                            handler: {print("Нажата ячейка VPN")}, isOn: false))
            ]))
      
        
        models.append(Sections(options: [
            .standardCell(model: SettingStandardOption(
                            title: "Уведомления",
                            icon: UIImage(systemName: "note"),
                            iconBackgroundColor: .systemRed,
                            handler: {print("Нажата ячейка Уведомления")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Звуки, тактильные сигналы",
                            icon: UIImage(systemName: "speaker.wave.3.fill"),
                            iconBackgroundColor: .systemPink,
                            handler: {print("Нажата ячейка Звуки, тактильные сигналы")})),
            
            .standardCell(model:  SettingStandardOption(
                            title: "Не беспокоить",
                            icon: UIImage(systemName: "moon.fill"),
                            iconBackgroundColor: .systemIndigo,
                            handler: {print("Нажата ячейка Не беспокоить")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Экранное время",
                            icon: UIImage(systemName: "hourglass"),
                            iconBackgroundColor: .systemIndigo,
                            handler: {print("Нажата ячейка Экранное время")})),
        ]))
        
        models.append(Sections(options: [
            .standardCell(model: SettingStandardOption(
                            title: "Основные",
                            icon: UIImage(systemName: "gear"),
                            iconBackgroundColor: .systemGray,
                            handler: {print("Нажата ячейка Основные")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Пункт управления",
                            icon: UIImage(systemName: "slider.horizontal.3"),
                            iconBackgroundColor: .systemGray,
                            handler: {print("Нажата ячейка Пункт управления")})),
            
            .standardCell(model:  SettingStandardOption(
                            title: "Экран и яркость",
                            icon: UIImage(systemName: "textformat.size"),
                            iconBackgroundColor: .systemBlue,
                            handler: {print("Нажата ячейка Экран и яркость")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Экран «‎Домой»‎",
                            icon: UIImage(systemName: "apps.iphone"),
                            iconBackgroundColor: .systemIndigo,
                            handler: {print("Нажата ячейка Экран «‎Домой")})),
            
            .standardCell(model:   SettingStandardOption(
                            title: "Универсальный доступ",
                            icon: UIImage(systemName: "figure.stand"),
                            iconBackgroundColor: .systemBlue,
                            handler: {print("Нажата ячейка Универсальный доступ")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Обои",
                            icon: UIImage(systemName: "seal"),
                            iconBackgroundColor: .systemTeal,
                            handler: {print("Нажата ячейка Обои")})),
            
            .standardCell(model:  SettingStandardOption(
                            title: "Face ID и код-пароль",
                            icon: UIImage(systemName: "person.fill.viewfinder"),
                            iconBackgroundColor: .systemGreen,
                            handler: {print("Нажата ячейка Face ID и код-пароль")})),
            
            .standardCell(model:  SettingStandardOption(
                            title: "Аккамулятор",
                            icon: UIImage(systemName: "battery.100"),
                            iconBackgroundColor: .systemGreen,
                            handler: {print("Нажата ячейка Аккамулятор")})),
            
            .standardCell(model: SettingStandardOption(
                            title: "Конфиденциальность",
                            icon: UIImage(systemName: "hand.raised.fill"),
                            iconBackgroundColor: .systemBlue,
                            handler: {print("Нажата ячейка Конфиденциальность")})),
        ]))
    }
}
