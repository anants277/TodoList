//
//  BottomView.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

class BottomView: UIView {

    func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    var cancelButton : UIButton!
    var doneButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .white
        
        cancelButton = createButton()
        doneButton =  createButton()
        
        self.addSubview(cancelButton)
        cancelButton.edges([.left,.bottom,.top], to: self, offset: UIEdgeInsets(top: 5, left: 5, bottom: -5, right: 0))
        cancelButton.size(width: self.frame.size.width/3, height: 50)
        cancelButton.setTitle("CANCEL", for: .normal)
        
        self.addSubview(doneButton)
        doneButton.edges([.right,.bottom,.top], to: self, offset: UIEdgeInsets(top: 5, left: 0, bottom: -5, right: -5))
        doneButton.size(width: self.frame.size.width/3, height: 50)
        doneButton.setTitle("DONE", for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
