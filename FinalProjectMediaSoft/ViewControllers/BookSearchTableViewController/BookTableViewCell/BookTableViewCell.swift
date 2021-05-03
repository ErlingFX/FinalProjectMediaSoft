//
//  BookTableViewCell.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import UIKit
import AlamofireImage

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        coverImageView.backgroundColor = UIColor.lightGray
    }

    func populate(from viewModel: BookCellViewModel) {
        titleLabel.text = viewModel.title
        authorsLabel.text = viewModel.authorsString
        
        if let url = URL(string: viewModel.coverURLString) {
            coverImageView.af.setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
    }

}
