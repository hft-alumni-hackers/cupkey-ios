import Foundation
import UIKit

class SBBCollectionViewUtilities {
    class func registerDefaultCells(collectionView: UICollectionView) {
        collectionView.register(
            CupCell.self,
            forCellWithReuseIdentifier: CupCell.cellId
        )
    }

    class func getDefaultCellFor(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: SBBBaseCellItem
    ) -> UICollectionViewCell? {

        if item is CupCellItem {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CupCell.cellId,
                for: indexPath) as! CupCell
            cell.setupWithItem(item: item as! CupCellItem)
            return cell
        }

        return nil
    }
}
