//
//  ListItem.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import Foundation
import UIKit		
import RealmSwift

class ListItem: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var todoDescription: String = ""
    @objc dynamic var imageName: String = ""
    @objc dynamic var toDoisChecked: Bool = false
}

