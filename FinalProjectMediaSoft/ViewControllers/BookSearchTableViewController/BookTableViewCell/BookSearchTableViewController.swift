//
//  BookSearchTableViewController.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "Cell"

class BookSearchTableViewController: UITableViewController {

    var viewModel: BookSearchViewModel = BookSearchViewModel()
    
    
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.rowHeight = 120
        title = "Bookshelf"
        
        navigationItem.largeTitleDisplayMode = .always
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false // Always shows search bar
        }
        
        setupBindings()
        setupSearchController()
    }
    
    private func setupBindings() {
        
       
        viewModel.books
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: BookTableViewCell.self)) { (_, article, cell) in
                cell.populate(from: article)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(BookCellViewModel.self)
            .subscribe(onNext: {[weak self] book in
                if let strongSelf = self {
                    let viewController = UIStoryboard.viewController(from: "Main", type: BookDetailViewController.self)
                    viewController.viewModel = BookDetailViewModel(book: book.book)
                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.didStartSearch)
            .disposed(by: disposeBag)
    }
    
    private func setupSearchController() {
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

