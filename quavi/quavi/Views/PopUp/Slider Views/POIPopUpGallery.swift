//
//  POIPopUpGallery.swift
//  quavi
//
//  Created by Alex 6.1 on 3/3/20.
//  Copyright © 2020 Sunni Tang. All rights reserved.
//

import UIKit

class POIPopUpGallery: UIView {
    
    let padding: CGFloat = 20
    lazy var poiGalleryCollectionView = POIPopUpGalleryCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        poiGalleryCollectionView.delegate = self
        poiGalleryCollectionView.dataSource = self
        poiGalleryCollectionViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func poiGalleryCollectionViewContraints() {
        addSubview(poiGalleryCollectionView)
        poiGalleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            poiGalleryCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            poiGalleryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            poiGalleryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            poiGalleryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
}

extension POIPopUpGallery: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = poiGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: POIPopUpGalleryCollectionViewCell.reuseID, for: indexPath) as! POIPopUpGalleryCollectionViewCell
        cell.poiGalleryImageView.image = UIImage(named: "moMath2")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 175)
    }
    
    
}
