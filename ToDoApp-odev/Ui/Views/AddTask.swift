//
//  AddTask.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 10.08.2024.
//

import UIKit


class AddTask: UIViewController {
    
    // MARK: IBOutlet tanımlamalarımız
    @IBOutlet weak var textFieldAddTask: UITextField!
    
    // MARK: Değişken tanımlamalarımız
    var viewModel=AddTaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonAdd(_ sender: UIButton) {
        if let ga = textFieldAddTask.text{
            if textFieldAddTask.text == ""{
                textFieldAddTask.placeholder = "Please enter task"
            }else{
                viewModel.gorevKaydet(name: ga)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        
    }
    
}
