//
//  BookDetailViewModel.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import Foundation


class BookDetailViewModel: BookCellViewModel {
    var description: String
    
    override init(book: Book) {
        description = book.description
        super.init(book: book)
        coverURLString = book.images.thumbnail
    }
}
