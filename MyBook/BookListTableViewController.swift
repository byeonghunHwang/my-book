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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let book1 = Book(title: "결국 이기는 사람들의 비밀", writer: "리웨이원", publisher: "갤리온", coverImage: UIImage(named:"book1.jpg")!, price: 15000, description: "불공평한 세상에서 발견한 10가지 성공 법칙", url: "http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=150101&barcode=9788901218137")
        let book2 = Book(title: "뭘 해도 되는 사람", writer: "질 해슨", publisher: "유노북스", coverImage: UIImage(named:"book2.jpg")!, price: 14000, description: "가능성을 끌어올리는 마법", url: "http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=150101&barcode=9791186665626")
        let book3 = Book(title: "나는 왜 작은 일에도 상처받을까 ", writer: "다장쥔궈", publisher: "비즈니스북스", coverImage: UIImage(named:"book3.jpg")!, price: 14500, description: "있는 그대로의 나로 행복해지는 변화를 경험하라!", url: "http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&linkClass=150605&barcode=9791186805732")
        
        let book4 = Book(title: "iPhone SDK 튜토리얼2", writer: nil, publisher: nil, coverImage: nil, price: nil, description: nil, url: nil)
        
        self.books.append(book1)
        self.books.append(book2)
        self.books.append(book3)
        self.books.append(book4)
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
