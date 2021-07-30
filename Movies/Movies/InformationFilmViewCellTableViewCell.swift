// InformationFilmViewCellTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// InformationFilmViewCellTableViewCell
final class InformationFilmViewCellTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "InfoTableViewCell"

    let imageFilm = UIImageView()
    let filmDeascription = UILabel()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createVisualElements()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private Methods

    private func createFilmImage() {
        addSubview(imageFilm)

        imageFilm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageFilm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            imageFilm.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            imageFilm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            imageFilm.heightAnchor.constraint(equalToConstant: 350),
        ])
    }

    private func createFilmDescription() {
        filmDeascription.numberOfLines = 30
        addSubview(filmDeascription)

        filmDeascription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmDeascription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            filmDeascription.topAnchor.constraint(equalTo: imageFilm.bottomAnchor, constant: 50),
            filmDeascription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            filmDeascription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        ])
    }

    private func createVisualElements() {
        createFilmImage()
        createFilmDescription()
    }
}
