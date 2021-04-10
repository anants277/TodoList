//
//  TextFieldTableViewCell.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    var titleTextField : UITextField =  {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        return titleTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "TextFieldCell" {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(titleTextField)
        titleTextField.edges(.all, to: contentView, offset: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        titleTextField.placeholder = "Title*"
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleTextField.font = UIFont.systemFont(ofSize: 20)
        
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
