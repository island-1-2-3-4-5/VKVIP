//
//  NewsfeedViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 15/03/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogicProtocol: class { // class - под данный протокол можн оподписать только классы
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogicProtocol, NewsfeedCodeCellDelegate {

    

  var interactor: NewsfeedBusinessLogicProtocol?
  var router: (NSObjectProtocol & NewsfeedRoutingLogicProtocol)?
    
    // пустая модель данных нашего поста
    private var feedViewModel = FeedViewModel.init(cells: [])
  
    @IBOutlet weak var table: UITableView!
    
    // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    setup()
    // Регистрируем ячейку
    table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
    
    
    // Регистрируем ячейку сверстанную из кода
    table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
    
    table.separatorStyle = .none
    table.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.7645775639, blue: 0.6431372762, alpha: 1)
    
    // делаем запрос на получение новостей чтобы заполнить наш массив feedViewVodel
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsfeed)
    
    
    

  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {

    switch viewModel {

    case .displayNewsfeed(feedViewModel: let feedViewModel): // let feedViewModel - это ассоциативное значение, которое мы передали ранее
        self.feedViewModel = feedViewModel // заполняем feedViewModel информацией, которая приходит из презентера
        table.reloadData()
    }
  }
    
    
    
    
    //MARK: - NewsfeedCodeCellDelegate - протокол ячейки
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell

        // делаем кодом
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        
        // вытаскиваем нашу модель в ячейку
        let cellViewModel = feedViewModel.cells[indexPath.row]
        // в ячейке создали функцию отображения, в которую мы передаем модель данных подписанную под протокол
        // модель будем создавать в NewsfeedModels
        cell.set(viewModel: cellViewModel)
//        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //из модели вытаскиваем размер по строчно
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        return cellViewModel.sizes.totalHeight
    }
    
    
}
