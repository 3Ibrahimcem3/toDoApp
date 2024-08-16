//
//  EditTaskViewModel.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 11.08.2024.
//

import Foundation
import RxSwift

class EditTaskViewModel{
    var trepo = MyTaskDaoRepository()

    // MARK: FONKSİYONLARIMIZ
   
    func gorevDuzenle(name:String,id:Int){
        trepo.gorevDuzenle(name: name, id: id)
    }
}
