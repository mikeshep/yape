//
//  UseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol UseCase {
    associatedtype Dependency
    var dependencies: [Dependency] { get }
}
