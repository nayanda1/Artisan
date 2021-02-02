//
//  Planable+Center.swift
//  Artisan
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension Planer {
    
    // MARK: Center Anchor
    
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let offset):
            constraint = view.centerXAnchor.constraint(greaterThanOrEqualTo: anchor, constant: offset)
        case .lessThanTo(let offset):
            constraint = view.centerXAnchor.constraint(lessThanOrEqualTo: anchor, constant: offset)
        case .equalTo(let offset):
            constraint = view.centerXAnchor.constraint(equalTo: anchor, constant: offset)
        case .moreThan:
            constraint = view.centerXAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.centerXAnchor.constraint(lessThanOrEqualTo: anchor)
        case .equal:
            constraint = view.centerXAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "artisan_\(view.uniqueKey)_center_x_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutXAxisAnchor) -> Self {
        return centerX(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: RelatedAnchor<NSLayoutXAxisAnchor>) -> Self {
        guard let offsetedAnchor = anchor.getOffsettedAnchor(from: context)  else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get anchor of anonymous relation"
                )
            )
            return self
        }
        return centerX(relation.add(offset: offsetedAnchor.offset), to: offsetedAnchor.anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let offset):
            constraint = view.centerYAnchor.constraint(greaterThanOrEqualTo: anchor, constant: offset)
        case .lessThanTo(let offset):
            constraint = view.centerYAnchor.constraint(lessThanOrEqualTo: anchor, constant: offset)
        case .equalTo(let offset):
            constraint = view.centerYAnchor.constraint(equalTo: anchor, constant: offset)
        case .moreThan:
            constraint = view.centerYAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.centerYAnchor.constraint(lessThanOrEqualTo: anchor)
        case .equal:
            constraint = view.centerYAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "artisan_\(view.uniqueKey)_center_y_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutYAxisAnchor) -> Self {
        return centerY(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: RelatedAnchor<NSLayoutYAxisAnchor>) -> Self {
        guard let offsetedAnchor = anchor.getOffsettedAnchor(from: context) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get anchor of anonymous relation"
                )
            )
            return self
        }
        return centerY(relation.add(offset: offsetedAnchor.offset), to: offsetedAnchor.anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self {
        guard let relatedView = getView(from: anchor) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get view from relation"
                )
            )
            return self
        }
        if #available(iOS 11.0, *), anchor.isSafeArea {
            let guide = relatedView.safeAreaLayoutGuide
            return centerX(relation, to: guide.centerXAnchor, priority: priority)
        } else if anchor.isSafeArea {
            let horizontal = relatedView.layoutMargins.horizontal
            let offset = horizontal.left - horizontal.right
            return centerX(relation.add(offset: offset), to: relatedView.centerXAnchor, priority: priority)
        }
        return centerX(relation, to: relatedView.centerXAnchor, priority: priority)
    }
    
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation) -> Self {
        return centerX(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self {
        guard let relatedView = getView(from: anchor) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get view from relation"
                )
            )
            return self
        }
        if #available(iOS 11.0, *), anchor.isSafeArea {
            let guide = relatedView.safeAreaLayoutGuide
            return centerY(relation, to: guide.centerYAnchor, priority: priority)
        } else if anchor.isSafeArea {
            let horizontal = relatedView.layoutMargins.vertical
            let offset = horizontal.top - horizontal.bottom
            return centerX(relation.add(offset: offset), to: relatedView.centerXAnchor, priority: priority)
        }
        return centerY(relation, to: relatedView.centerYAnchor, priority: priority)
    }
    
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation) -> Self {
        return centerY(relation, to: anchor, priority: context.mutatingPriority)
    }
}
#endif
