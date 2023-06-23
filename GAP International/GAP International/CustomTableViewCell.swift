//
//  CustomTableViewCell.swift
//  GAP International
//
//  Created by Yogesh on 6/22/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    let chapterNameLabel = UILabel()
    let commentLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Configure the labels' properties
        chapterNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        commentLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.font = UIFont.systemFont(ofSize: 12)

        // Add the labels to the cell's content view
        contentView.addSubview(chapterNameLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)

        // Set up constraints for the labels
        chapterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chapterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            chapterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            chapterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            commentLabel.topAnchor.constraint(equalTo: chapterNameLabel.bottomAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: chapterNameLabel.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: chapterNameLabel.trailingAnchor),

            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: chapterNameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: chapterNameLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
