//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit
import RealmSwift

class AddTodoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private var realm = try! Realm()
    
    var completionHandler : (()-> Void)?
    
    var todoImage = UIImage()
    var todoTitle = ""
    var todoDescription = ""
    var todoImageName = ""
    
    var errormsg = ""
    
    var bottomView : BottomView!
    
    var bottomViewConstraint : NSLayoutConstraint!
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToShowKeyboardNotifications()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    func setup() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        title = "New Todo Item"
        
        
        view.addSubview(tableView)
        tableView.edges([.left,.right,.top,.bottom], to: view.safeAreaLayoutGuide, offset: UIEdgeInsets(top: 30, left: 20, bottom: -80, right: -20))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "TextFieldCell")
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "TextViewCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "LabelCell")

        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        
        
        bottomView = BottomView(frame: CGRect(x: view.frame.size.width/2, y: 0, width: view.frame.size.width, height: 80))
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        
        view.addSubview(bottomView)
        bottomView.edges([.left,.right], to: view, offset: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30))
        bottomViewConstraint = bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomViewConstraint.isActive = true
        bottomView.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        bottomView.doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        
        
        
        
    }
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonAction() {
        
        
        if(todoTitle != "") {
            
            realm.beginWrite()
            let newItem = ListItem()
            newItem.title = todoTitle
            newItem.todoDescription = todoDescription
            newItem.imageName = todoImageName
            newItem.toDoisChecked = false
            realm.add(newItem)
            try! realm.commitWrite()
            completionHandler?()
            self.dismiss(animated: true, completion: nil)
        } else {
            errormsg = "Please give a title.."
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    @objc func showAlertForPhoto(_ sender : UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                print("no camera available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
        todoImage = pickedImage
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        DispatchQueue.global().async {
            self.todoImageName = UUID().uuidString
            
            let fileManager = FileManager.default
            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(self.todoImageName)
            let image = pickedImage
            let data = image.pngData()
            fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        
        var extraHeight:CGFloat = 0
        if UIDevice.current.hasNotch {
            extraHeight = 20
        }
        bottomViewConstraint.constant =  -keyboardHeight + extraHeight
        
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomViewConstraint.constant = 0

        let userInfo = notification.userInfo
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func textFieldDidChange(textField : UITextField) {
        if textField.text!.count > 0 {
            todoTitle = textField.text!
        }
    }
}

extension AddTodoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
            cell.titleTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
            return cell
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewTableViewCell
               cell.titleTextView.delegate = self
               return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelTableViewCell
                cell.label.text = errormsg
                cell.label.textColor = .red
                cell.label.textAlignment = .center
                return cell
            }
           
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonTableViewCell
            cell.label.text = "Image to remember"
            cell.label.textColor = .black
            cell.button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.button.setImage(UIImage(named: "add"), for: .normal)
            cell.button.setBackgroundImage(todoImage, for: .normal)
            cell.button.addTarget(self, action: #selector(showAlertForPhoto(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    
}

extension AddTodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 1) {
            return view.frame.size.height/3
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}


extension AddTodoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            todoDescription = textView.text
        }
    }
}
