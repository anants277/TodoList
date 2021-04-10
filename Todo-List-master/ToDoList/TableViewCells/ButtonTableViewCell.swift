//
//  ButtonTableViewCell.swift
//  ToDoList
//
//  Created by Creo Server on 25/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    
    var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if reuseIdentifier == "ButtonCell" {
            setupButtonWithLabel()
        }
    }
    
    
    
    func setupButtonWithLabel() {
        
        contentView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        self.contentView.addSubview(label)
        label.edges([.top, .left, . right], to: self.contentView, offset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20))
        
        self.contentView.addSubview(button)
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        button.size(width: 60, height: 60)
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
}
