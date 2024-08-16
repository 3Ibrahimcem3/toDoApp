//
//  MyTaskViewModel.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 11.08.2024.
//

import Foundation
import RxSwift

class MyTaskViewModel{
    
    var trepo = MyTaskDaoRepository()
    var tasks = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    
    init(){
        veritabaniKopyala()
        tasks = trepo.tasks
        gorevEkle()
    }
    
    // MARK: FONKSİYONLARIMIZ
    func veritabaniKopyala() {
        // Uygulama paketindeki (bundle) 'ToDoApp.db' dosyasının yolunu buluyoruz.
        let bundleYolu = Bundle.main.path(forResource: "ToDoApp", ofType: ".db")
        
        // Cihazdaki belgeler dizininin (Documents directory) yolunu alıyoruz.
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        // Belgeler dizinine 'ToDoApp.db' dosyasını ekleyerek, kopyalanacak tam yolu oluşturuyoruz.
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("ToDoApp.db")
        
        // Dosya işlemleri için varsayılan FileManager örneğini oluşturuyoruz.
        let fileManager = FileManager.default
        
        // Belgeler dizininde 'ToDoApp.db' dosyasının zaten var olup olmadığını kontrol ediyoruz.
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            // Eğer dosya zaten varsa, konsola mesaj yazdırıyoruz.
            print("Veritabanı zaten var!")
        } else {
            // Eğer dosya yoksa, dosyayı kopyalama işlemini yapıyoruz.
            do {
                // Uygulama paketindeki veritabanı dosyasını belgeler dizinine kopyalıyoruz.
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch {
                // Eğer bir hata oluşursa, buraya bir hata mesajı eklenebilir.
            }
        }
    }
    // TREPO FONKSİYONLARIMIZ
    func gorevEkle(){
        trepo.gorevYukle()
    }
    
    func gorevSil(id:Int){
        trepo.gorevSil(id: id)
    }
    
    func tumGorevSil(){
        trepo.tumGorevSil()
    }
}
