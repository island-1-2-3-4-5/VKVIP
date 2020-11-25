//
//  NewsfeedCodeCell.swift
//  VKVip
//
//  Created by Роман on 25.11.2020.
//

import Foundation
import UIKit

// Верстаем интерфейс из кода
final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        // разрешаем компилятору закреплять cardView  на экране
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавляем view на экран
        addSubview(cardView)
        backgroundColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        
        // cardView constraints
        // заполняем всю область
//        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true // прикрепляем верхнюю границу cardView к верхней границе ячейки
//        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
//        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true // прикрепляем нижнюю границу cardView к нижней границе ячейки
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true // прикрепляем левую границу cardView к левой границе ячейки
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true // прикрепляем правую границу cardView к правой границе ячейки

        
        // привязываем к левому верхнему углу с размерами 40 на 40
//        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true // высота cardView
//        cardView.widthAnchor.constraint(equalToConstant: 40).isActive = true // ширина cardView

        
        // центрируем
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
//        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        // верх, лево/право, половина ячейки
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
