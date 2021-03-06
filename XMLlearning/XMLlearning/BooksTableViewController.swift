//
//  BooksTableViewController.swift
//  XMLlearning
//
//  Created by Man Kit Tsui on 7/16/20.
//  Copyright © 2020 Man Kit Tsui. All rights reserved.
//

import UIKit


struct Book {
    var bookTitle: String
    var bookAuthor: String
}


class BooksTableViewController: UITableViewController,XMLParserDelegate {

    
    var books: [Book] = []
    var elementName: String = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         if let path = Bundle.main.url(forResource: "Books", withExtension: "xml") {
               if let parser = XMLParser(contentsOf: path) {
                   parser.delegate = self
                   parser.parse()
               }
           }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let book = books[indexPath.row]
            
        cell.textLabel?.text = book.bookTitle
        cell.detailTextLabel?.text = book.bookAuthor

        return cell
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "book" {
            bookTitle = String()
            bookAuthor = String()
        }

        self.elementName = elementName
    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
        }
    }

    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }

}
