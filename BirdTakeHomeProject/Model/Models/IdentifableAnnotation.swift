//
//  IdentifableAnnotation.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 20.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Cluster

final class IdentifableAnnotation: Annotation {

    let index: Int

    init(index: Int) {
        self.index = index
        super.init()
    }

}
