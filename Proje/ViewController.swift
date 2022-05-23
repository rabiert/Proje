//
//  ViewController.swift
//  Proje
//
//  Created by Rabia on 23.05.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private var models = [BookItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book List"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit book name", style: .cancel, handler: {[weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            
            self?.createItem(bookName: text)
        } ))
        
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.bookName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            let sheet2 = UIAlertController(title: "Edit Options",
                                          message: nil,
                                          preferredStyle: .actionSheet)
            sheet2.addAction(UIAlertAction(title: "Edit Book Name", style: .default, handler: {_ in
                let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
                                           
                alert.addTextField(configurationHandler: nil)
                alert.textFields?.first?.text = item.bookName
                alert.addAction(UIAlertAction(title: "Submit book name", style: .cancel, handler: {[weak self] _ in
                    guard let field = alert.textFields?.first, let newBook = field.text, !newBook.isEmpty else{
                        return
                    }
                                               
                    self?.updateBookItem(item: item, newBook: newBook)
                } ))
                
                self.present(alert, animated: true)
            }))
                                           
            sheet2.addAction(UIAlertAction(title: "Edit Author", style: .default, handler: {_ in
                let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)

                alert.addTextField(configurationHandler: nil)
                alert.textFields?.first?.text = item.authorName
                alert.addAction(UIAlertAction(title: "Submit author name", style: .cancel, handler: {[weak self] _ in
                    guard let field = alert.textFields?.first, let Author = field.text, !Author.isEmpty else{
                        return
                    }
                    self?.addAuthor(item: item, author: Author)
                } ))
                                
                self.present(alert, animated: true)}))
            
            self.present(sheet2, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            self?.deleteItem(item: item)
        }))

        present(sheet, animated: true)
    }

    //Core Data
    
    func getAllItems(){
        do{
            models = try context.fetch(BookItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{}
        
    }
    
    func createItem(bookName: String){
        let newItem = BookItem(context: context)
        newItem.bookName = bookName
        newItem.authorName = "author not selected"
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
    func addAuthor(item: BookItem, author: String){
        item.authorName = author
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
    func deleteItem(item: BookItem){
        context.delete(item)
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
        
    }
    
    func updateBookItem(item: BookItem, newBook: String){
        item.bookName = newBook
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
        
    }


}

