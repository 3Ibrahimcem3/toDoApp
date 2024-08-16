//
//  EditTask.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 10.08.2024.
//

import UIKit

class EditTask: UIViewController {
    
    // MARK: IBOutlet bağlantılarımız
    @IBOutlet weak var textFieldEditTask: UITextField!
    
    // MARK: Değişkenlerimiz
    var task:Gorevler?
    var viewModel = EditTaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let gi = task {
            print("task Değişkeni Mevcut: ID: \(gi.id ?? -1)")
        } else {
            print("task Değişkeni Nil!")
        }

        if let gd = textFieldEditTask.text {
            print("TextField'deki Metin: \(gd)")
        } else {
            print("TextField Boş!")
        }
    }

    
    @IBAction func buttonEdit(_ sender: UIButton) {
        if let gd = textFieldEditTask.text, let gi = task {
            if textFieldEditTask.text == ""{
                textFieldEditTask.placeholder = "Please Edit Task "
            }else{
                viewModel.gorevDuzenle(name: gd, id: gi.id!)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
