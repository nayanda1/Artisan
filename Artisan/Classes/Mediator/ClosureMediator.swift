//
//  ClosureMediator.swift
//  Artisan
//
//  Created by Nayanda Haberty on 16/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class ClosureMediator<View: NSObject>: ViewMediator<View> {
    var applicator: (View) -> Void
    
    public init(_ applicator: @escaping (View) -> Void) {
        self.applicator = applicator
    }
    
    required public init() {
        self.applicator = { _ in }
    }
    
    open override func bonding(with view: View) {
        applicator(view)
    }
}

open class TableClosureMediator<Cell: UITableViewCell>: TableCellMediator<Cell> {
    var applicator: (Cell) -> Void
    
    public init(_ applicator: @escaping (Cell) -> Void) {
        self.applicator = applicator
    }
    
    required public init() {
        self.applicator = { _ in }
    }
    
    open override func bonding(with view: Cell) {
        applicator(view)
    }
    
}

open class CollectionClosureMediator<Cell: UICollectionViewCell>: CollectionCellMediator<Cell> {
    var applicator: (Cell) -> Void
    
    public init(_ applicator: @escaping (Cell) -> Void) {
        self.applicator = applicator
    }
    
    required public init() {
        self.applicator = { _ in }
    }
    
    open override func bonding(with view: Cell) {
        applicator(view)
    }
}
#endif
