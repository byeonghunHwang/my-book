//
//  BookDetailViewController.swift
//  MyBook
//
//  Created by ktds 10 on 2017. 8. 17..
//  Copyright © 2017년 CJ ONS, Inc. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var book:Book?

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookWriterLabel: UILabel!
    @IBOutlet weak var bookPublisherLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let newBook = self.book else {
            return
        }
        self.bookCoverImageView.image = newBook.coverImage
        self.bookWriterLabel.text = newBook.writer
        self.bookPublisherLabel.text = newBook.publisher
        
        if let bookPrice = newBook.price {
            self.bookPriceLabel.text = String(bookPrice)
        }
        
        self.bookDescriptionTextView.text = newBook.description
        
        //Title 표시
        self.navigationItem.title = newBook.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webVC = segue.destination as? WebViewController {
            webVC.shopURL = self.book?.url
        }
    }
    

}
