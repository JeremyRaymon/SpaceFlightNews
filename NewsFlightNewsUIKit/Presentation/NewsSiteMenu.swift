//
//  NewsSiteMenu.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import UIKit

protocol UINewsSiteMenuDelegate {
    func changeNewsSite(selectedNewsSite: String)
}

class NewsSiteMenu: UIView {
    var newsSites: [String]
    var selectedNewsSite: String
    
    var label = UILabel()
    var button = UIButton()
    var delegate: UINewsSiteMenuDelegate?

    init(newssites: [String]) {
        self.newsSites = newssites
        self.selectedNewsSite = newssites.first ?? "All"
        super.init(frame: .zero)
        
        configureUI()
        configureLabel()
        configureButton(newssites: newssites)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .tertiarySystemFill
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48)
        ])
        self.layer.cornerRadius = 12
    }
    
    func configureButton(newssites: [String]) {
        self.addSubview(button)
        
        button.configuration = .plain()
        button.setTitle(selectedNewsSite, for: .normal)
        button.setImage(UIImage(systemName: "chevron.up.chevron.down")?.resize(16, 16).withTintColor(UIColor.accent), for: .normal)
        button.configuration?.imagePlacement = .trailing
        button.setTitleColor(UIColor.accent, for: .normal)
        
        self.configureMenus()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configureMenus() {
        var menuOptions: [UIMenuElement] = []
        for newsSite in newsSites {
            menuOptions.append(
                UIAction(title: newsSite, handler: { action in
                    self.delegate?.changeNewsSite(selectedNewsSite: action.title)
                    self.selectedNewsSite = action.title
                    self.button.setTitle(action.title, for: .normal)
                })
            )
        }
        let menu = UIMenu(children: menuOptions)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
    func configureLabel() {
        self.addSubview(label)
        
        label.text = "News Site"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
