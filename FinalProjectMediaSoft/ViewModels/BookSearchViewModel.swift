//
//  BookSearchViewModel.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import Foundation
import RxSwift
import RxCocoa


class BookSearchViewModel {
    let books: Observable<[BookCellViewModel]>
    let didStartSearch: AnyObserver<String?>
    let selectBook: AnyObserver<BookCellViewModel>
    
    var bookService: BookRequestable
    
    private let disposeBag = DisposeBag()
    
    init(bookService: BookRequestable = BookService()) {
        self.bookService = bookService
        
        let _didStartSearch = PublishSubject<String?>.init()
        didStartSearch = _didStartSearch.asObserver()
        
        let _selectBook = PublishSubject<BookCellViewModel>.init()
        selectBook = _selectBook.asObserver()
        
        books = _didStartSearch.asObservable()
            .flatMap({ searchTerm -> Observable<[Book]> in
                if let searchTerm = searchTerm {
                    return bookService.books(for: searchTerm)
                }
                
                return Observable.empty()
            })
            .map({ books -> [BookCellViewModel] in
                books.compactMap(BookCellViewModel.init)
            })
    }
}

