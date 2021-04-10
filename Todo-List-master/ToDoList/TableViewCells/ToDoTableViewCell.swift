//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel =  {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var descriptionLabel : UILabel =  {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    var checkButton : UIButton = {
        let checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.tintColor = .black
        return checkButton
    }()
    
    var myImageView : UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        return myImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "ToDoCell" {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        contentView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        
        contentView.addSubview(checkButton)
        checkButton.size(width: 30, height: 30)
        checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkButton.edges([.right, ], to: contentView, offset: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: -10))
        checkButton.layer.cornerRadius = 15
        checkButton.layer.masksToBounds = false
        checkButton.clipsToBounds = true
        checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        
        contentView.addSubview(myImageView)
        myImageView.size(width: 60, height: 60)
//        myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        myImageView.edges([.left, .top, .bottom], to: contentView, offset: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 0))
        myImageView.layer.cornerRadius = 30
        myImageView.layer.masksToBounds = false
        myImageView.clipsToBounds = true
        myImageView.image = UIImage(systemName: "circle")
        
        contentView.addSubview(titleLabel)
        titleLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.edges([.top], to: contentView, offset: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        titleLabel.text = " "
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 5).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -10).isActive = true
        descriptionLabel.text = " "
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
    }
}
