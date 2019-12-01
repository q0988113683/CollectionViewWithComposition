//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by Jhuo Yu cheng on 2019/11/30.
//  Copyright © 2019 Jhuo Yu cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section: Int {
        case Banner = 0
        case RecommendShop = 1
        case Ad = 2
        case ItemList = 3
        case Items = 4
    }
    
    @IBOutlet  var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.collectionViewLayout = makeLayout()
        self.collectionView.register(UINib(nibName: "TextCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TextCellIdentifier")
        self.collectionView.register(UINib(nibName: "ItemHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: "headerKind", withReuseIdentifier: "ItemHeaderCellIdentifier")
        
    }
}

extension ViewController: UICollectionViewDataSource , UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 1
        default:
            return 50
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCellIdentifier", for: indexPath) as! TextCollectionViewCell
        cell.labText.text = "\(indexPath.row)"
        cell.labText.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: "ItemHeaderCellIdentifier", for: indexPath)
        return reusableview
    }
    
}

// make Layout
extension ViewController{
    private func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .Banner:
                return self.BannerLayoutSection()
            case .RecommendShop:
                return self.RecommendShopLayoutSection()
            case .Ad:
                return self.BannerLayoutSection()
            case .ItemList:
                return self.ItemListLayoutSection()
            case .Items:
                return self.ItemsLayoutSection()
            default:
                return nil
            }
        }
    }
    
    
    func BannerLayoutSection() -> NSCollectionLayoutSection {
        let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(200))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item1])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        return section
    }
    
    func RecommendShopLayoutSection() -> NSCollectionLayoutSection {
        let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(60))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item1])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return section
    }
    
    func ItemListLayoutSection() -> NSCollectionLayoutSection {
        let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(100))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item1])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        group.interItemSpacing = .fixed(8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: "headerKind",
                                                                        alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    
    func ItemsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        item1.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8,
        bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.2))
         let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item1, count: 2)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        group.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return section
    }
}
