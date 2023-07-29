//
//  Grape.swift
//  PodoRang
//
//  Created by coco on 2023/07/27.
//

import Foundation
import RealmSwift

enum Grape: Int, CaseIterable, PersistableEnum {
    case purple = 0
    case red
    case green
    case none
}
