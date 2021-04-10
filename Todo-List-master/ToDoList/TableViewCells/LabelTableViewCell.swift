//
//  LabelTableViewCell.swift
//  ToDoList
//
//  Created by Creo Server on 25/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    var label : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "LabelCell" {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        contentView.addSubview(label)
        label.edges(.all, to: contentView, offset: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        label.font = UIFont.systemFont(ofSize: 15)
        
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
