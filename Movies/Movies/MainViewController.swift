// ListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// MainViewController
final class MainViewController: UIViewController {
    // MARK: - Private Properties

    private var filmTableView = UITableView()
    private var genresSegmentControl = UISegmentedControl()
    private let identifire = "MyCell"
    private var genresArray = ["Popular", "Top Rated", "Up Coming"]

    var presenter: MovieViewPresenterProtocol!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        createSegmentControl()
        presenter.fetchData()
        createTable()
    }

    // MARK: - Private Methods

    private func createTable() {
        filmTableView.register(ListTableViewCell.self, forCellReuseIdentifier: identifire)
        filmTableView.separatorStyle = .none
        filmTableView.estimatedRowHeight = 200
        filmTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(filmTableView)

        let safeArea = view.safeAreaLayoutGuide
        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            filmTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            filmTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            filmTableView.bottomAnchor.constraint(equalTo: genresSegmentControl.topAnchor, constant: -5)
        ])

        filmTableView.delegate = self
        filmTableView.dataSource = self
    }

    private func createSegmentControl() {
        genresSegmentControl = UISegmentedControl(items: genresArray)
        genresSegmentControl.isMomentary = true
        genresSegmentControl.backgroundColor = .systemGray2
        genresSegmentControl.addTarget(self, action: #selector(selectGendersSegmentControl), for: .valueChanged)
        view.addSubview(genresSegmentControl)

        let safeArea = view.safeAreaLayoutGuide
        genresSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            genresSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            genresSegmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
            genresSegmentControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func selectGendersSegmentControl() {
        presenter.selectCategory(index: genresSegmentControl.selectedSegmentIndex)

        presenter.fetchData()
    }

    func configureCell(cell: ListTableViewCell, for indexPath: IndexPath) {
        guard let result = presenter.category?.results[indexPath.row] else { return }
        let filmImage = result.posterPath

        DispatchQueue.global().async {
            let const = "https://image.tmdb.org/t/p/w500"
            guard let urlImage = URL(string: "\(const)\(filmImage ?? "")") else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                guard let image = UIImage(data: imageData) else { return }
                cell.configCell(films: result, image: image)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ListTableViewCell
        else { return UITableViewCell() }
        configureCell(cell: cell, for: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countRow = presenter.category?.results.count else { return Int() }
        return countRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = presenter.category?.results[indexPath.row] else { return }

        let informationFilmVC = InformationFilmViewController()

        informationFilmVC.idFilm = category.id
        informationFilmVC.infoCategory = category
        navigationController?.pushViewController(informationFilmVC, animated: true)
    }
}

// MARK: - MovieViewProtocol

extension MainViewController: MovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.filmTableView.reloadData()
        }
    }
}
