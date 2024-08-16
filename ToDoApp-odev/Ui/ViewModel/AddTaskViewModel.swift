//
//  AddTaskViewModel.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 11.08.2024.
//

import Foundation

class AddTaskViewModel{
    var trepo = MyTaskDaoRepository()
    
   
    
    // MARK: FONKSİYONLARIMIZ
   
    func gorevKaydet(name:String){
        trepo.gorevKaydet(name: name)
    }
}
