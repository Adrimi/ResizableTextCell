//
//  ViewController.swift
//  ResizableTextCell
//
//  Created by adrian.szymanowski on 25/05/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Parameters
    private var newCellSize: CGSize = .init(width: 200, height: 50)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let f = UICollectionViewFlowLayout()
        f.scrollDirection = .vertical
        return f
    }()
    
    private lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        c.register(Cell.self, forCellWithReuseIdentifier: "cell")
        c.backgroundColor = .systemPink
        c.dataSource = self
        c.delegate = self
        return c
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

// MARK: - CollectionView DataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.delegate = self
        return cell
    }
    
}

// MARK: - CollectionView Flow Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        newCellSize
    }
}

// MARK: - Custom Cell Delegate
extension ViewController: CellDelegate {
    func updateLayout(_ cell: Cell, with newSize: CGSize) {
        newCellSize = newSize
        
        // NOTE: - You can add some options, but from i have invest. most of them just do not work
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
