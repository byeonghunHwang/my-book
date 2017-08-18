//
//  BookListTableViewController.swift
//  MyBook
//
//  Created by ktds 10 on 2017. 8. 17..
//  Copyright © 2017년 CJ ONS, Inc. All rights reserved.
//

import UIKit
import Foundation

class BookListTableViewController: UITableViewController, AddBookDelegate {
    
    var books:[Book] = Array()
    
    func getFilePath(withFileName fileName:String) -> String {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPath[0] as NSString
        print(docDir)
        
        let filePath = docDir.appendingPathComponent(fileName)
        
        return filePath
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = self.getFilePath(withFileName: "books")
        
        let fileManager = FileManager.default
        fileManager.fileExists(atPath: filePath)
        
        if fileManager.fileExists(atPath: filePath) {
            if let books = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Book] {
                self.books.append(contentsOf: books)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if let bookCell = cell as? BookTableViewCell {
            let book = self.books[indexPath.row]
            
            let numFormatter: NumberFormatter = NumberFormatter()
            numFormatter.numberStyle = NumberFormatter.Style.decimal
            
            if let price = book.price {
                let priceStr = numFormatter.string(from: NSNumber(integerLiteral: price))
                bookCell.bookPriceLabel.text = priceStr
            } else {
                bookCell.bookPriceLabel.text = ""
            }
            
            bookCell.bookTitleLabel.text = book.title
            bookCell.bookWriterLabel.text = book.writer
            bookCell.bookImageView.image = book.coverImage
            
            return bookCell
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addvc" {
            if let addVC = segue.destination as? AddBookViewController {
                addVC.delegate = self
            }
        } else if segue.identifier == "detailvc" {
            let cell = sender as? UITableViewCell
            let vc = segue.destination as? BookDetailViewController
            
            guard let selCell = cell, let detailVC = vc else {
                return
            }
            
            if let idx = self.tableView.indexPath(for: selCell) {
                detailVC.book = self.books[idx.row]
            }
        }
    }
    
    func sendNewBook(book:Book) {
        self.books.append(book)
        self.tableView.reloadData()
    }
}


class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!    
    @IBOutlet weak var bookWriterLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
