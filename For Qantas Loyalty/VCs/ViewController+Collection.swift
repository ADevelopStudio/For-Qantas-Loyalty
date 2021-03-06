//
//  ViewController+Collection.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            var titleLbl : UILabel {
                if let titleLabel = headerView.subviews.first as? UILabel {return titleLabel}
                let titleLabel = UILabel(frame: .zero)
                titleLabel.textAlignment = .left
                titleLabel.textColor = .darkGray
                titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                headerView.addSubview(titleLabel, constraints: {
                    $0.edges.pinToSuperviewMargins(insets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), relation: .equal)
                })
                return titleLabel
            }
            titleLbl.text = indexPath.section == 0 ? "Popular" : "Other"
            return headerView
        default:
            return UICollectionReusableView(frame: .zero)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWithImage", for: indexPath) as! CellWithImage
            cell.fillWith(recipe:  recipes.withimages[indexPath.row])
            return cell
        } else {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWithoutImage", for: indexPath) as! CellWithoutImage
            cell.fillWith(recipe:  recipes.withoutimages[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? recipes.withimages.count : recipes.withoutimages.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIApplication.shared.tapFeedback()
        self.performSegue(withIdentifier: "details", sender: indexPath.section == 0 ? recipes.withimages[indexPath.row] : recipes.withoutimages[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let isPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
            let numberOfColumns:CGFloat = isPortrait ? 2 : 3
            let width = (UIScreen.main.bounds.width - 16) / numberOfColumns - ((numberOfColumns - 1) * 5)
            return CGSize(width: width , height: width)
        } else {
            return CGSize(width: (UIScreen.main.bounds.width - 16)  , height: 70)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 5, right: 8)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collection.performBatchUpdates({}) { (_) in }
        }, completion:nil)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.collection.performBatchUpdates({}) { (_) in }
    }
}
