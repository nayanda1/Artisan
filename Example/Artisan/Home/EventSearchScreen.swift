//
//  MovieSearchScreen.swift
//  Artisan
//
//  Created by Nayanda Haberty on 12/20/2020.
//  Copyright (c) 2020 24823437. All rights reserved.
//

import UIKit
import Artisan
import Draftsman

protocol EventSearchScreenObserver {
    func didTap(_ tableView: UITableView, cell: UITableViewCell, at indexPath: IndexPath)
}

class EventSearchScreen: UIViewController, ObservableView, Planned {
    typealias Observer = EventSearchScreenObserver
    
    // MARK: View
    lazy var searchBar: UISearchBar = builder {
        $0.placeholder = "Search event here!"
        $0.sizeToFit()
        $0.tintColor = .text
        $0.barTintColor = .background
    }
    lazy var tableView: UITableView = builder {
        $0.animationSet =  .init(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .top)
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.allowsSelection = true
        if #available(iOS 11.0, *) {
            $0.contentInset = view.safeAreaInsets
        } else {
            $0.contentInset = view.layoutMargins
        }
        $0.delegate = self
    }
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        tableView.plan.edges(.equal, to: .safeArea)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        applyPlan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
}

extension EventSearchScreen {
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .main
        navigationItem.titleView = searchBar
    }
}

extension EventSearchScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        observer?.didTap(tableView, cell: cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .background
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = .secondary
    }
}
