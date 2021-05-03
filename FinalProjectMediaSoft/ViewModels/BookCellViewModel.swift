//
//  BookCellViewModel.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import Foundation


class BookCellViewModel {
    var title: String
    var authorsString: String
    var coverURLString: String
    
    let book: Book
    
    init(book: Book) {
        self.book = book
        title = book.title
        
        if book.authors.isEmpty {
            authorsString = "Unknown"
        } else {
            authorsString = book.authors.joined(separator: ", ")
        }
        
        coverURLString = book.images.smallThumbnail
    }
}

