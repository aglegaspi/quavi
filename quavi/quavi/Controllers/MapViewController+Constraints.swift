//
//  MapViewController+Constraints.swift
//  quavi
//
//  Created by Sunni Tang on 2/3/20.
//  Copyright © 2020 Sunni Tang. All rights reserved.
//

import Foundation
import UIKit

extension MapViewController {
//TODO: Add all constraints for objects here, marked and labeled
    
//TODO: Create addSubview and addConstraint func for specific objects i.e. addCollectionViewSubviews(), addCollectionViewConstraints
    
    //TODO: rename to addMapViewSubviews()
    func addSubviews() {
        //TODO: -- re-assign this to the view when the collectionview is added
        view.addSubview(mapView)
        sliderView.addSubview(startNavigationButton)
    }
    
    //TODO: rename to addMapViewConstraints()
    func addConstraints() {
        setMapViewConstraints()
        setStartNavigationButtonConstraints()
    }
    
    //MARK: -mapView Constraints
    //TODO: make funcs private
    func setMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        
    }
    
    func setStartNavigationButtonConstraints(){
        startNavigationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([startNavigationButton.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: -(startNavigationButton.frame.height / 2)),
                        startNavigationButton.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant:  -5),
                        startNavigationButton.heightAnchor.constraint(equalToConstant: 50),
                        startNavigationButton.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    //MARK: -collectionView Constraints
    
    //MARK: -tableView Constraints
}
