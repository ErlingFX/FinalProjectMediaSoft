//
//  BookDetailViewController.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import UIKit
import AlamofireImage

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookAuthorsLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    var viewModel: BookDetailViewModel! {
        didSet {
            if viewIfLoaded != nil {
                populateFromViewModel()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        populateFromViewModel()
    }
    
    private func populateFromViewModel() {
        if let viewModel = viewModel {
            bookTitleLabel.text = viewModel.title
            bookAuthorsLabel.text = viewModel.authorsString
            bookDescriptionLabel.text = viewModel.description
            
            if let url = URL(string: viewModel.coverURLString) {
                bookCoverImageView.af.setImage(withURL: url)
            }
        } else {
            bookTitleLabel.text = nil
            bookAuthorsLabel.text = nil
            bookDescriptionLabel.text = nil
            bookCoverImageView.image = nil
        }
    }

}
