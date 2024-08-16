//
//  ViewController.swift
//  ToDoApp-odev
//
//  Created by İbrahim Cem Ekti on 10.08.2024.

import UIKit


class MyTask: UIViewController {
    
    
    // MARK: IBOutlet tanımlamalarımız
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Değişkenlerimiz
    var tasks = [Gorevler]()
    var viewModel = MyTaskViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none

            // DataSource ve Delegate bağlantılarını yapalım
            tableView.dataSource = self
            tableView.delegate = self
        
        _ = viewModel.tasks.subscribe(onNext: { liste in
            self.tasks = liste
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.veritabaniKopyala()
        viewModel.gorevEkle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditTask" {
            if let destinationVC = segue.destination as? EditTask,
               let selectedTask = sender as? Gorevler {
                destinationVC.task = selectedTask
            }
        }
    }
    
    @IBAction func deleteTableViewCell(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete all!", message: "Delete all?", preferredStyle: .alert)
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(iptalAction)
        
        let evetAction = UIAlertAction(title: "Yes", style: .destructive){action in
            self.viewModel.tumGorevSil()
        }
        alert.addAction(evetAction)
        self.present(alert, animated: true)
        tableView.reloadData()
    }
}





extension MyTask: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = .black // Yazı rengini siyah yapıyoruz
        
        let gorev = tasks[indexPath.row]  // Görevi tasks array'inden alıyoruz
        cell.textLabel?.text = gorev.name // Görev adını hücreye yazdırıyoruz
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row] // `tasks` array'inden seçilen görevi al
           // Hücreye tıklanıldığında çalışacak kodlar
           performSegue(withIdentifier: "toEditTask", sender: selectedTask)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Delete"){contextualAction,view,bool in
            
            let gorev = self.tasks[indexPath.row]
            
            let alert = UIAlertController(title: "Deletion process", message: "\(gorev.name!) delete?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Yes", style: .destructive){action in
                self.viewModel.gorevSil(id: gorev.id!)
            }
            alert.addAction(evetAction)

            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])

    }
}
