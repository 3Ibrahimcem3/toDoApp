//
//  MyTaskDaoRepository.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 11.08.2024.
//

import Foundation
import RxSwift

class MyTaskDaoRepository{
    var tasks = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    
    let db: FMDatabase?  // FMDatabase sınıfının isteğe bağlı (opsiyonel) bir örneğini tanımlar.

    init() {
        // Belgeler dizininin (Documents directory) yolunu alıyoruz.
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        // Belgeler dizinine 'ToDoApp.db' dosyasını ekleyerek, veritabanı için tam yol oluşturuyoruz.
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("ToDoApp.db")
        
        // FMDatabase örneğini oluşturuyoruz ve oluşturduğumuz yol ile başlatıyoruz.
        db = FMDatabase(path: veritabaniURL.path)
    }

    // MARK: FONKSİYONLARIMIZ
    func gorevYukle() {
        db?.open()
        var task = [Gorevler]()
        do {
            let rs = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while rs.next() {
                let gorev = Gorevler(id: Int(rs.string(forColumn: "id"))!,
                                     name: rs.string(forColumn: "name")!)
                
                task.append(gorev)
            }
            tasks.onNext(task)
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func gorevKaydet(name:String){
        db?.open()
        do {
             try db!.executeUpdate("INSERT INTO toDos (name) VALUES (?)", values: [name])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func gorevDuzenle(name:String,id:Int){
        db?.open()
        do {
             try db!.executeUpdate("UPDATE toDos SET name = ? WHERE id = ?", values: [name,id])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func gorevSil(id:Int){
        db?.open()
        do {
             try db!.executeUpdate("DELETE FROM toDos WHERE id = ?", values: [id])
            gorevYukle()
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func tumGorevSil() {
        db?.open()
        do {
            // Veritabanındaki tüm görevleri sil
            try db!.executeUpdate("DELETE FROM toDos", values: nil)
            
            // Görevleri yeniden yükle (Boş bir listeyle güncellenir)
            gorevYukle()
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }

}
