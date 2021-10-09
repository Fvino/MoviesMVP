// MoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewProtocol: AnyObject {
    func reloadData()
}

protocol MovieViewPresenterProtocol: AnyObject {
    var category: Category? { get set }
    var jsonUrlString: String { get set }

    func fetchData()

    func selectCategory(index: Int)
}

final class MoviePresenter: MovieViewPresenterProtocol {
    var category: Category?
    private weak var listView: MovieViewProtocol!

    var jsonUrlString = Constants.popular {
        didSet {
            fetchData()
        }
    }

    // MARK: - Methods

    func presenterSetUp(listView: MovieViewProtocol) {
        self.listView = listView
    }

    func selectCategory(index: Int) {
        switch index {
        case 0:
            jsonUrlString = Constants.popular
        case 1:
            jsonUrlString = Constants.topRated
        case 2:
            jsonUrlString = Constants.upComing

        default:
            break
        }
    }

    func fetchData() {
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.category = try decoder.decode(Category.self, from: data)
                self.listView?.reloadData()
            } catch {
                print("error")
            }
        }.resume()
    }
}
