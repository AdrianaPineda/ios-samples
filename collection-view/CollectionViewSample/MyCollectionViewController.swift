//
//  MyCollectionViewController.swift
//  CollectionViewSample
//
//  Created by Adriana Pineda on 28/06/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyCell"

class MyCollectionViewController: UICollectionViewController {
    private var comics: [Comic] = []
    private let apiClient = ComicApiClient()

    private var itemsPerRow: CGFloat = 1
    private let minCellWidth = 200
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 8,
                                             bottom: 10.0,
                                             right: 8)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadComics()

        // Take into account safe area for content adjustment
        collectionView.contentInsetAdjustmentBehavior = .always
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

    private func loadComics() {
        for _ in 1 ... 15 {
            let randomNumber = Int.random(in: 1 ... 200)
            apiClient.fetchComic(id: randomNumber).then { comic in
                self.comics.append(comic)
                self.collectionView.reloadData()
            }
        }
    }
}

private extension MyCollectionViewController {
    func comic(for indexPath: IndexPath) -> Comic {
        return comics[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource

extension MyCollectionViewController {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return comics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let comicCell = cell as? ComicCell else {
            return cell
        }

        // Configure the cell
        let comic = self.comic(for: indexPath)
        comicCell.imageView.image = UIImage(data: comic.image)
        comicCell.titleLabel.text = comic.title

        return comicCell
    }
}

// MARK: - Collection View Flow Layout Delegate

extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize {
        let padding = Int(sectionInsets.left + sectionInsets.right)
        let currentSize = Int(view.safeAreaLayoutGuide.layoutFrame.width)
        let cells = currentSize / (minCellWidth + padding)
        let cellsWithPaddingWidth = currentSize / cells
        let cellsWidth = cellsWithPaddingWidth - padding

        return CGSize(width: cellsWidth, height: 120)
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        insetForSectionAt _: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return sectionInsets.left
    }
}
