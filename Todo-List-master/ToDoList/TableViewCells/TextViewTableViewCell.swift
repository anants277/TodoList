//
//  TextViewTableViewCell.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class TextViewTableViewCell: UITableViewCell {

   var titleTextView : KMPlaceholderTextView =  {
        let titleTextView = KMPlaceholderTextView()
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        return titleTextView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "TextViewCell" {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(titleTextView)
        titleTextView.edges(.all, to: contentView, offset: UIEdgeInsets.zero)
        titleTextView.placeholder = "Description"
//        titleTextView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        titleTextView.font = UIFont.systemFont(ofSize: 20)
        titleTextView.sizeToFit()
        titleTextView.isScrollEnabled = true

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
